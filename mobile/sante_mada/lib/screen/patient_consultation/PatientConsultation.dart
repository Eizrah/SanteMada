import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sante_mada/database/dbLocal.dart';
import 'package:sante_mada/models/Patient.dart';

class PatientConsultation extends StatefulWidget {
  const PatientConsultation({super.key});

  @override
  State<PatientConsultation> createState() => _PatientConsultationState();
}

class _PatientConsultationState extends State<PatientConsultation> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _symptomesController = TextEditingController();

  // État de la recherche
  List<Patient> _resultats = [];
  bool _isSearching = false;
  bool _isLoading = false;

  // Patient sélectionné pour la consultation
  Patient? _patientSelectionne;

  // Accordéon maladies héréditaires
  bool _isMaladieHereditaireExpanded = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _symptomesController.dispose();
    super.dispose();
  }

  // Déclenché à chaque frappe dans la barre de recherche
  void _onSearchChanged() {
    final texte = _searchController.text.trim();
    if (texte.isEmpty) {
      setState(() {
        _resultats = [];
        _isSearching = false;
      });
      return;
    }
    _rechercherPatients(texte);
  }

  Future<void> _rechercherPatients(String nom) async {
    setState(() => _isLoading = true);
    try {
      final resultats = await Dblocal.searchPatientsByNom(nom);
      if (mounted) {
        setState(() {
          _resultats = resultats;
          _isSearching = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur de recherche : $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Sélectionner un patient depuis la liste de résultats
  void _selectionnerPatient(Patient p) {
    setState(() {
      _patientSelectionne = p;
      _isSearching = false;
      _resultats = [];
      _searchController.clear();
      _isMaladieHereditaireExpanded = false;
      _symptomesController.clear();
    });
  }

  // Affiche la photo ou une icône par défaut
  Widget _buildPhoto(String? photoPath, double rayon) {
    final bool aPhoto = photoPath != null && photoPath.isNotEmpty;
    return Container(
      width: rayon * 2,
      height: rayon * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF2196F3), width: 2),
        color: const Color(0xFF102D4A),
      ),
      child: ClipOval(
        child: aPhoto
            ? Image.file(
                File(photoPath),
                width: rayon * 2,
                height: rayon * 2,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _defaultAvatar(rayon),
              )
            : _defaultAvatar(rayon),
      ),
    );
  }

  Widget _defaultAvatar(double rayon) {
    return Container(
      color: const Color(0xFF102D4A),
      child: Icon(Icons.person, size: rayon, color: const Color(0xFF2196F3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Historique & Symptômes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_off, color: Color(0xFF2196F3)),
            onPressed: () => debugPrint("Sync status"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              //Barre de recherche
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF151C26),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF232D3B)),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Rechercher un patient par nom...",
                    hintStyle: const TextStyle(color: Color(0xFF3E4856)),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF3E4856),
                    ),
                    suffixIcon: _isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(12),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFF2196F3),
                              ),
                            ),
                          )
                        : _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Color(0xFF7B8A9E),
                            ),
                            onPressed: () {
                              _searchController.clear();
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),

              //Liste des résultats de recherche
              if (_isSearching)
                _buildListeResultats()
              else ...[
                const SizedBox(height: 16),

                //Carte du patient sélectionné
                if (_patientSelectionne != null)
                  _buildContenuPatient(_patientSelectionne!)
                else
                  _buildEtatVide(),
              ],

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  //liste des résultats de recherche
  Widget _buildListeResultats() {
    if (_resultats.isEmpty && !_isLoading) {
      return Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF151C26),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Column(
            children: [
              Icon(Icons.search_off, color: Color(0xFF3E4856), size: 40),
              SizedBox(height: 8),
              Text(
                "Aucun patient trouvé",
                style: TextStyle(color: Color(0xFF7B8A9E), fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        const SizedBox(height: 8),
        // Compteur de résultats
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              const Icon(
                Icons.people_outline,
                size: 14,
                color: Color(0xFF7B8A9E),
              ),
              const SizedBox(width: 6),
              Text(
                "${_resultats.length} résultat(s) trouvé(s)",
                style: const TextStyle(color: Color(0xFF7B8A9E), fontSize: 12),
              ),
            ],
          ),
        ),
        // Tuiles des résultats
        ..._resultats.map((p) => _buildTuileResultat(p)),
      ],
    );
  }

  //Widget : une tuile de résultat (avec photo)
  Widget _buildTuileResultat(Patient p) {
    return GestureDetector(
      onTap: () => _selectionnerPatient(p),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF151C26),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF232D3B)),
        ),
        child: Row(
          children: [
            // Photo du patient
            _buildPhoto(p.photo, 26),
            const SizedBox(width: 14),
            // Infos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.nomComplet,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "${p.age} ans • ${p.sexe} • CIN: ${p.nCIN}",
                    style: const TextStyle(
                      color: Color(0xFF7B8A9E),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // Flèche de sélection
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF2196F3),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // Widget : état vide (aucun patient sélectionné)
  Widget _buildEtatVide() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF151C26),
                border: Border.all(color: const Color(0xFF232D3B)),
              ),
              child: const Icon(
                Icons.person_search,
                size: 40,
                color: Color(0xFF2196F3),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Recherchez un patient",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Tapez le nom complet dans la barre\nde recherche ci-dessus",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF7B8A9E), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  //Widget : contenu complet d'un patient sélectionn
  Widget _buildContenuPatient(Patient p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Carte identité patient
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF151C26),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF2196F3).withOpacity(0.4)),
          ),
          child: Row(
            children: [
              _buildPhoto(p.photo, 30),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.nomComplet,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${p.age} ans • ${p.sexe} • CIN: ${p.nCIN}",
                      style: const TextStyle(
                        color: Color(0xFF7B8A9E),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "📍 ${p.adressLocal}",
                      style: const TextStyle(
                        color: Color(0xFF7B8A9E),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Bouton changer de patient
              IconButton(
                onPressed: () {
                  setState(() {
                    _patientSelectionne = null;
                    _symptomesController.clear();
                  });
                },
                icon: const Icon(Icons.swap_horiz, color: Color(0xFF2196F3)),
                tooltip: "Changer de patient",
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        //Section : Antécédents & Famille
        const Text(
          "ANTÉCÉDENTS & FAMILLE",
          style: TextStyle(
            color: Color(0xFF7B8A9E),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),

        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF151C26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => setState(
                  () => _isMaladieHereditaireExpanded =
                      !_isMaladieHereditaireExpanded,
                ),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.family_restroom,
                        color: Color(0xFF2196F3),
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "Maladies Héréditaires",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Icon(
                        _isMaladieHereditaireExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              if (_isMaladieHereditaireExpanded)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2530),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      p.maladieHereditaire.isNotEmpty
                          ? p.maladieHereditaire
                          : "Aucune maladie héréditaire enregistrée.",
                      style: const TextStyle(
                        color: Color(0xFF9BA8B8),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Antécédents médicaux
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF151C26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.history_edu_outlined,
                color: Color(0xFF2196F3),
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Antécédents médicaux",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      p.antecedentMaladie.isNotEmpty
                          ? p.antecedentMaladie
                          : "Aucun antécédent enregistré.",
                      style: const TextStyle(
                        color: Color(0xFF9BA8B8),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        //Section : Infos physiques
        const Text(
          "INFORMATIONS PHYSIQUES",
          style: TextStyle(
            color: Color(0xFF7B8A9E),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildInfoChip(
              Icons.monitor_weight_outlined,
              "${p.poids} kg",
              "Poids",
            ),
            const SizedBox(width: 10),
            _buildInfoChip(Icons.height, "${p.taille.toInt()} cm", "Taille"),
            const SizedBox(width: 10),
            _buildInfoChip(Icons.cake_outlined, "${p.age} ans", "Âge"),
          ],
        ),
        const SizedBox(height: 24),

        //Section : Description des Symptômes
        const Text(
          "DESCRIPTION DES SYMPTÔMES",
          style: TextStyle(
            color: Color(0xFF7B8A9E),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),

        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF151C26),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF232D3B)),
          ),
          child: Column(
            children: [
              TextField(
                controller: _symptomesController,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText:
                      "Décrivez les symptômes actuels, la durée et l'intensité...",
                  hintStyle: TextStyle(color: Color(0xFF3E4856)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => debugPrint("Enregistrer audio"),
                      icon: const Icon(Icons.mic, color: Color(0xFF7B8A9E)),
                      tooltip: "Enregistrer un message audio",
                    ),
                    IconButton(
                      onPressed: () => debugPrint("Prendre photo"),
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Color(0xFF7B8A9E),
                      ),
                      tooltip: "Prendre une photo",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Bouton Enregistrer
        SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton.icon(
            onPressed: () {
              debugPrint("Enregistrer symptômes pour ${p.nomComplet}");
              debugPrint("Symptômes: ${_symptomesController.text}");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Symptômes enregistrés pour ${p.nomComplet}"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: const Icon(Icons.save, color: Colors.white, size: 20),
            label: const Text(
              "Enregistrer local",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget : puce info physique
  Widget _buildInfoChip(IconData icon, String valeur, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF151C26),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF2196F3), size: 22),
            const SizedBox(height: 6),
            Text(
              valeur,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(color: Color(0xFF7B8A9E), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
