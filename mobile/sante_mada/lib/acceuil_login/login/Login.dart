import 'package:flutter/material.dart';
import 'package:sante_mada/acceuil_login/mdp_forget/ForgetMdp.dart';
import 'package:sante_mada/classes/widgetUtil.dart';
import 'package:sante_mada/database/dbLocal.dart';
import 'package:sante_mada/navbar/NavBar.dart';
// import 'package:sante_mada/new_patient/AddPatient.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final storage = const FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),
);
  // Controllers pour récupérer les valeurs des champs
  final TextEditingController _identifiantController = TextEditingController();
  final TextEditingController _motDePasseController = TextEditingController();

  @override
  void dispose() {
    // Libérer les controllers quand le widget est détruit
    _identifiantController.dispose();
    _motDePasseController.dispose();
    super.dispose();
  }

  Future<void> gererLogin(String nAgent, String mdp) async {
    try {
      final ac = await Dblocal.login(nAgent, mdp);
      if (ac != null) {
        await storage.write(key: "nAgent", value: ac.nAgent.toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigation()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Connexion reussie"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Identifiant ou mot de passe incorrect"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("erreur: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Une erreur est survenue ")));
    }
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
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),

            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF102D4A),
                ),
                child: const Icon(
                  Icons.medical_services,
                  color: Color(0xFF137FEC),
                  size: 50,
                ),
              ),
            ),
            const SizedBox(height: 30),

            //zone image à mettre plus tard
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                // Un dégradé léger pour simuler l'espace de l'image
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF2196F3).withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
              child: const Center(
                child: Text(
                  "[Zone Image ECG]",
                  style: TextStyle(color: Color(0xFF3E4856)),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Connexion",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Accédez au portail de santé rurale",
                    style: TextStyle(color: Color(0xFF707E8D), fontSize: 16),
                  ),
                  const SizedBox(height: 40),

                  // Champ Email
                  CustomTextField(
                    label: "Email/Numéro utilisateur",
                    hint: "Entrez votre identifiant",
                    icon: Icons.email_outlined,
                    controller: _identifiantController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),

                  // Champ Mot de passe
                  CustomPasswordField(
                    label: "Mot de passe",
                    hint: "Entrez votre mot de passe",
                    controller: _motDePasseController,
                  ),
                  const SizedBox(height: 30),

                  // Bouton Se connecter
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {
                        // Récupérer les valeurs des champs
                        String identifiant = _identifiantController.text;
                        String motDePasse = _motDePasseController.text;

                        if (identifiant.isNotEmpty && motDePasse.isNotEmpty) {
                          gererLogin(identifiant, motDePasse);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Veuillez remplir tous les champs"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Se connecter",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      debugPrint(" bouton Mot de passe oublié cliquer");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgetMdp(),
                        ),
                      );
                    },
                    child: const Text(
                      "Mot de passe oublié ?",
                      style: TextStyle(color: Color(0xFF2196F3)),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Footer
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 14,
                        color: Color(0xFF3E4856),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Portail de santé sécurisé",
                        style: TextStyle(
                          color: Color(0xFF3E4856),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
