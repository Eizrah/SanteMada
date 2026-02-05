import 'package:flutter/material.dart';
import 'package:sante_mada/acceuil_login/login/Login.dart';
import 'package:sante_mada/classes/widgetUtil.dart';

class NewMdp extends StatefulWidget {
  const NewMdp({super.key});

  @override
  State<NewMdp> createState() => _NewMdp();
}

class _NewMdp extends State<NewMdp> {
  // Controller pour récupérer la valeur du champ numéro agent
  final TextEditingController _newMdpController = TextEditingController();
  final TextEditingController _MdpVerificationController =
      TextEditingController();
  @override
  void dispose() {
    _newMdpController.dispose();
    _MdpVerificationController.dispose();
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
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),

              // Icône cadenas avec cercle bleu
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF102D4A),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2196F3).withOpacity(0.2),
                        blurRadius: 9,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Cercle de flèche circulaire
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF2196F3),
                            width: 3,
                          ),
                        ),
                      ),
                      // Icône cadenas
                      const Icon(
                        Icons.lock_open_outlined,
                        color: Color(0xFF2196F3),
                        size: 40,
                      ),
                      // Flèche de rotation (simulée avec une icône)
                      Positioned(
                        top: 15,
                        right: 20,
                        child: Transform.rotate(
                          angle: -0.5,
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Color(0xFF2196F3),
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // Titre
              const Text(
                "Mot de passe oublié ?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // Description
              const Text(
                "Saisissez maintenant votre nouveau mot de passe",
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF7B8A9E),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),

              //mot de passe
              CustomPasswordField(
                label: "Nouveau mot de passe",
                hint: "Ex: ********",

                controller: _newMdpController,
              ),
              const SizedBox(height: 30),

              //mot de passe verification
              CustomPasswordField(
                label: "Confirmer le mot de passe",
                hint: "Ex: ********",

                controller: _MdpVerificationController,
              ),
              const SizedBox(height: 30),

              // Bouton Réinitialiser le mot de passe
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    //ajouter ici aussi une fonction de verification du code
                    String newMdp = _newMdpController.text;
                    String MdpVerification = _MdpVerificationController.text;
                    debugPrint("Mot de passe 1: $newMdp");
                    debugPrint("Mot de passe 2: $MdpVerification");

                    // Afficher un message de confirmation
                    if (newMdp.isNotEmpty && MdpVerification.isNotEmpty && newMdp == MdpVerification) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Un lien de réinitialisation a été envoyé pour l'agent $newMdp",
                          ),
                          backgroundColor: const Color(0xFF2196F3),
                        ),
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Veuillez Verifier votre mot de passe"),
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
                    "Enregistrer le nouveau mot de passe",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              const SizedBox(height: 40),

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
