import 'package:flutter/material.dart';
import 'package:sante_mada/acceuil_login/acceuil/acceuil.dart';
import 'package:sante_mada/classes/widgetUtil.dart';

class SettingAC extends StatefulWidget {
  const SettingAC({super.key});

  @override
  State<SettingAC> createState() => _SettingACState();
}

class _SettingACState extends State<SettingAC> {
  // Controllers pour les champs (mêmes que Inscription.dart)
  final TextEditingController _numCin = TextEditingController();
  final TextEditingController _nomComplet = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _dateNaissance = TextEditingController();
  final TextEditingController _lieuNaissance = TextEditingController();
  final TextEditingController _adresseLocal = TextEditingController();
  final TextEditingController _photo = TextEditingController();
  final TextEditingController _sexe = TextEditingController();
  final TextEditingController _NAgent = TextEditingController();
  final TextEditingController _lieuTravail = TextEditingController();
  final TextEditingController _password = TextEditingController();

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
    _NAgent.dispose();
    _lieuTravail.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          'Paramètres du Profil',
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

              // Section Photo de profil
              Center(
                child: GestureDetector(
                  onTap: () => debugPrint("Modifier photo"),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF2196F3),
                                width: 3,
                              ),
                              color: const Color(0xFF1A2836),
                            ),
                            child: ClipOval(
                              child: Container(
                                color: const Color(0xFF4DD0E1),
                                child: const Icon(
                                  Icons.person,
                                  size: 70,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF2196F3),
                                border: Border.all(
                                  color: const Color(0xFF0F1923),
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        "Modifier Photo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Appuyez pour modifier",
                        style: TextStyle(
                          color: Color(0xFF7B8A9E),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Nom Complet
              CustomTextField(
                label: "Nom Complet",
                hint: "Ex: Dr. Jean Dupont",
                icon: Icons.person,
                controller: _nomComplet,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),

              // Numéro de CIN
              CustomTextField(
                label: "Numéro de CIN",
                hint: "Numéro d'identification",
                icon: Icons.badge_outlined,
                controller: _numCin,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Age et Date de Naissance côte à côte
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      label: "Age",
                      hint: "Votre âge",
                      icon: Icons.cake_outlined,
                      controller: _age,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: CustomCalendrier(
                      label: "Date de Naissance",
                      controller: _dateNaissance,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Lieu de Naissance
              CustomTextField(
                label: "Lieu de Naissance",
                hint: "Ville de naissance",
                icon: Icons.location_city_outlined,
                controller: _lieuNaissance,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),

              // Genre
              CustomGenreSelector(label: "Genre", controller: _sexe),
              const SizedBox(height: 16),

              // Adresse actuelle
              CustomTextField(
                label: "Adresse actuelle",
                hint: "Votre adresse",
                icon: Icons.home_outlined,
                controller: _adresseLocal,
                keyboardType: TextInputType.streetAddress,
              ),
              const SizedBox(height: 16),

              // Lieu de Travail
              CustomTextField(
                label: "Lieu de Travail",
                hint: "Nom du centre de santé",
                icon: Icons.work_outlined,
                controller: _lieuTravail,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),

              // NAgent
              CustomTextField(
                label: "NAgent",
                hint: "Numéro d'agent",
                icon: Icons.numbers_outlined,
                controller: _NAgent,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Mot de passe
              CustomPasswordField(
                label: "Mot de passe",
                hint: "Minimum 8 caractères",
                controller: _password,
              ),
              const SizedBox(height: 24),

              // Message de synchronisation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: const Color(0xFF2196F3),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Les changements seront synchronisés automatiquement.",
                    style: TextStyle(color: Color(0xFF7B8A9E), fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Bouton Enregistrer Changement
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint("Enregistrer Changement");
                    debugPrint("Nom: ${_nomComplet.text}");
                    debugPrint("CIN: ${_numCin.text}");
                    debugPrint("Age: ${_age.text}");
                    debugPrint("Date Naissance: ${_dateNaissance.text}");
                    debugPrint("Lieu Naissance: ${_lieuNaissance.text}");
                    debugPrint("Sexe: ${_sexe.text}");
                    debugPrint("Adresse: ${_adresseLocal.text}");
                    debugPrint("Lieu Travail: ${_lieuTravail.text}");
                    debugPrint("NAgent: ${_NAgent.text}");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Enregistrer Changement",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              //bouton de deconnexion
              //  TextButton(
              //     onPressed: () {
              //       debugPrint(" bouton deconnexion cliquer");
              //       Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const Acceuil()),
              //   );
              //     },
              //     child: const Text(
              //       "Deconnexion",
              //       style: TextStyle(color: Color(0xFFB90F0F)),
              //     ),
              //   ),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                 
                  onPressed: () {
                    debugPrint("bouton deconnexion cliquer");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Acceuil()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC40D0D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                 
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    "Deconnexion",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
