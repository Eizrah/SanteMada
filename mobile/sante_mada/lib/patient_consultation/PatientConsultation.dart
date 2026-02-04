import 'package:flutter/material.dart';

class PatientConsultation extends StatefulWidget {
  const PatientConsultation({super.key});

  @override
  State<PatientConsultation> createState() => _PatientConsultationState();
}

class _PatientConsultationState extends State<PatientConsultation> {
  final TextEditingController _symptomesController = TextEditingController();
  bool _isMaladieHereditaireExpanded = false;

  // Données du patient (simulation)
  final Map<String, dynamic> patient = {
    'initiales': 'JD',
    'nom': 'Jean Dupont',
    'age': 42,
    'sexe': 'Homme',
    'id': '#8821',
    'maladieHereditaire':
        'Diabète de type 2 - Mère et grand-père maternel diagnostiqués. Hypertension artérielle - Père.',
    'allergies': ['Pénicilline', 'Arachides'],
    'allergieDescription':
        'Réaction anaphylactique signalée lors de la dernière visite.',
  };

  @override
  void dispose() {
    _symptomesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => debugPrint("Retour"),
        ),
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
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () => debugPrint("More options"),
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

              // Barre de recherche
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF151C26),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF232D3B)),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Rechercher un patient...",
                    hintStyle: const TextStyle(color: Color(0xFF3E4856)),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF3E4856),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  onChanged: (value) => debugPrint("Recherche: $value"),
                ),
              ),
              const SizedBox(height: 16),

              // Carte du patient
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF151C26),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    // Avatar avec initiales
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF2196F3),
                          width: 2,
                        ),
                        color: const Color(0xFF102D4A),
                      ),
                      child: Center(
                        child: Text(
                          patient['initiales'],
                          style: const TextStyle(
                            color: Color(0xFF2196F3),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patient['nom'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${patient['age']} ans • ${patient['sexe']} • ID: ${patient['id']}",
                          style: const TextStyle(
                            color: Color(0xFF7B8A9E),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Section: Antécédents & Famille
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

              // Maladies Héréditaires (expandable)
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
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
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
                    // Description expandable
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
                            patient['maladieHereditaire'],
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
              const SizedBox(height: 24),

              // Section: Alertes Critiques
              const Text(
                "ALERTES CRITIQUES",
                style: TextStyle(
                  color: Color(0xFF7B8A9E),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 12),

              // Carte d'alerte allergies
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D1A1A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF5C2828), width: 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "ATTENTION : ALLERGIES",
                            style: TextStyle(
                              color: Color(0xFFFF6B6B),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            (patient['allergies'] as List).join(', '),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            patient['allergieDescription'],
                            style: const TextStyle(
                              color: Color(0xFF9BA8B8),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B6B).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.warning_rounded,
                        color: Color(0xFFFF6B6B),
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Section: Description des Symptômes
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

              // Zone de texte avec boutons audio/photo
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
                    // Boutons audio et photo
                    Container(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Bouton enregistrer audio
                          IconButton(
                            onPressed: () => debugPrint("Enregistrer audio"),
                            icon: const Icon(
                              Icons.mic,
                              color: Color(0xFF7B8A9E),
                            ),
                            tooltip: "Enregistrer un message audio",
                          ),
                          // Bouton prendre photo
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
              const SizedBox(height: 30),

              // Bouton Enregistrer & Consulter
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: () {
                    debugPrint("Enregistrer & Consulter");
                    debugPrint("Symptômes: ${_symptomesController.text}");
                  },
                  icon: const Icon(Icons.send, color: Colors.white, size: 20),
                  label: const Text(
                    "Enregistrer & Consulter",
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
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
