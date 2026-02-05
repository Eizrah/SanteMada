import 'package:flutter/material.dart';
import 'package:sante_mada/classes/widgetUtil.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({super.key});

  @override
  State<AddPatient> createState() => _AddPatient();
}

class _AddPatient extends State<AddPatient> {
  // Controllers pour récupérer les données
  final TextEditingController _numCin = TextEditingController();
  final TextEditingController _nomComplet = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _dateNaissance = TextEditingController();
  final TextEditingController _lieuNaissance = TextEditingController();
  final TextEditingController _adresseLocal = TextEditingController();
  final TextEditingController _photo = TextEditingController();
  final TextEditingController _sexe = TextEditingController();
  final TextEditingController _antecedentMaladie = TextEditingController();
  final TextEditingController _maladieHereditaire = TextEditingController();
  final TextEditingController _taille = TextEditingController();
  final TextEditingController _poids = TextEditingController();

  @override
  void dispose() {
    _numCin.dispose();
    _nomComplet.dispose();
    _age.dispose();
    _dateNaissance.dispose();
    _lieuNaissance.dispose();
    _adresseLocal.dispose();
    _photo.dispose();
    _sexe.dispose();
    _antecedentMaladie.dispose();
    _maladieHereditaire.dispose();
    _taille.dispose();
    _poids.dispose();
    super.dispose();
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
          'Enregistrement du Patient',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // En-tête avec icône
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF102D4A),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.person_add,
                      size: 28,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Nouveau Patient",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                "Enregistrez un nouveau patient pour le suivi médical en milieu rural.",
                style: TextStyle(fontSize: 15, color: Color(0xFF7B8A9E)),
              ),
              const SizedBox(height: 24),

              // Photo du Patient
              Center(
                child: GestureDetector(
                  onTap: () => debugPrint("Capture photo cliquée"),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFD4B896),
                                width: 3,
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF1A2836),
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Color(0xFF3E4856),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF2196F3),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Photo du Patient",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Appuyez pour capturer",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Nom et Prénom
              CustomTextField(
                label: "Nom et Prénom",
                hint: "Ex: Jean Dupont",
                icon: Icons.person_outline,
                controller: _nomComplet,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),

              // Date de naissance et Âge côte à côte
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomCalendrier(
                      label: "Date de naissance",
                      controller: _dateNaissance,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      label: "Âge",
                      hint: "--",
                      icon: Icons.cake_outlined,
                      controller: _age,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Lieu de naissance
              CustomTextField(
                label: "Lieu de naissance",
                hint: "Ville ou village",
                icon: Icons.location_city_outlined,
                controller: _lieuNaissance,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),

              // Numéro d'identité (CNI/Passport)
              CustomTextField(
                label: "Numéro d'identité (CNI/Passport)",
                hint: "Numéro officiel",
                icon: Icons.badge_outlined,
                controller: _numCin,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Genre
              CustomGenreSelector(label: "Genre", controller: _sexe),
              const SizedBox(height: 16),

              // Taille et Poids côte à côte
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: "Taille (cm)",
                      hint: "Ex: 170",
                      icon: Icons.height,
                      controller: _taille,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      label: "Poids (kg)",
                      hint: "Ex: 65",
                      icon: Icons.monitor_weight_outlined,
                      controller: _poids,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Antécédent de maladie
              _buildTextArea(
                "Antécédent de maladie",
                "Décrivez les antécédents médicaux...",
                _antecedentMaladie,
              ),
              const SizedBox(height: 16),

              // Maladie héréditaire
              _buildTextArea(
                "Maladie héréditaire",
                "Décrivez les maladies héréditaires connues...",
                _maladieHereditaire,
              ),
              const SizedBox(height: 16),

              // Adresse locale
              _buildTextArea(
                "Adresse locale",
                "Quartier, rue ou indication géographique",
                _adresseLocal,
                maxLines: 2,
              ),
              const SizedBox(height: 20),

              // Message de synchronisation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "Prêt pour la synchronisation hors-ligne",
                    style: TextStyle(fontSize: 13, color: Color(0xFF4CAF50)),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Bouton Enregistrer le Patient
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: () {
                    debugPrint("bouton enregistrer patient cliquer");
                  },
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text(
                    "Enregistrer le Patient",
                    style: TextStyle(
                      fontSize: 18,
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
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pour les TextArea (champs multilignes) avec thème sombre
  Widget _buildTextArea(
    String label,
    String hint,
    TextEditingController controller, {
    int maxLines = 3,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF3E4856)),
            filled: true,
            fillColor: const Color(0xFF151C26),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF232D3B)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF232D3B)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2196F3)),
            ),
          ),
        ),
      ],
    );
  }
}
