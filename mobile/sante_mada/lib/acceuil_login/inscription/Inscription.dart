import 'package:flutter/material.dart';
import 'package:sante_mada/acceuil_login/login/Login.dart';
import 'package:sante_mada/classes/widgetUtil.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _Inscription();
}

class _Inscription extends State<Inscription> {
  //controller de recuperation de données
  final TextEditingController _numCin = TextEditingController();
  final TextEditingController _nomComplet = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _dateNaissance = TextEditingController();
  final TextEditingController _lieuNaissance = TextEditingController();
  final TextEditingController _adresseLocal = TextEditingController();
  final TextEditingController _photo = TextEditingController();
  final TextEditingController _sexe = TextEditingController();
  final TextEditingController _NAgent =
      TextEditingController(); //generer automatiquement
  final TextEditingController _lieuTravail = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    //pour liberer les champs
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Center(
          child: Text(
            'Créer un compte',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        //mettre une petite bordure pour delimiter le appBar et le corps
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // En-tête avec icône shield
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
                      Icons.shield,
                      size: 28,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Rejoignez le réseau",
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
                "Enregistrez-vous pour accéder aux téléconsultations et au suivi patient en milieu rural.",
                style: TextStyle(fontSize: 15, color: Color(0xFF7B8A9E)),
              ),
              const SizedBox(height: 24),

              // Nom complet
              CustomTextField(
                label: "Nom Complet",
                hint: "Ex: Dr. Jean Dupont",
                controller: _nomComplet,
                icon: Icons.person,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),

              // Numéro CIN
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
                controller: _adresseLocal,
                icon: Icons.home_outlined,
                keyboardType: TextInputType.streetAddress,
              ),
              const SizedBox(height: 16),

              // Photo
              CustomTextField(
                label: "Photo",
                hint: "URL de votre photo",
                controller: _photo,
                icon: Icons.photo_camera_outlined,
                keyboardType: TextInputType.url,
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
              const SizedBox(height: 30),

              // Bouton Créer mon compte
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint("bouton s'inscrire cliquer");
                    //navigue directe vers le corps de l'appli
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Créer mon compte",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Lien Se connecter
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Vous avez déjà un compte ? ",
                    style: TextStyle(fontSize: 14, color: Color(0xFF7B8A9E)),
                  ),
                  TextButton(
                    onPressed: () {
                      debugPrint("bouton se connecter cliquer");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      "Connectez-vous",
                      style: TextStyle(fontSize: 14, color: Color(0xFF2196F3)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Footer sécurisé
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
                  const SizedBox(width: 8),
                  const Text(
                    "Système sécurisé SantéMada",
                    style: TextStyle(fontSize: 12, color: Color(0xFF7B8A9E)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
