import 'package:flutter/material.dart';
import 'package:sante_mada/acceuil_login/mdp_forget/VerificationCode.dart';
import 'package:sante_mada/classes/widgetUtil.dart';

class ForgetMdp extends StatefulWidget {
  const ForgetMdp({super.key});

  @override
  State<ForgetMdp> createState() => _ForgetMdpState();
}

class _ForgetMdpState extends State<ForgetMdp> {
  // Controller pour récupérer la valeur du champ numéro agent
  final TextEditingController _numAgentController = TextEditingController();

  @override
  void dispose() {
    _numAgentController.dispose();
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
                "Saisissez votre numéro Agent associé à votre compte santé pour recevoir un lien de réinitialisation sécurisé.",
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF7B8A9E),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),

              // Champ Numéro Agent
              CustomTextField(
                label: "Numéro Agent",
                hint: "Ex: AG12345",
                icon: Icons.badge_outlined,
                controller: _numAgentController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 30),

              // Bouton Réinitialiser le mot de passe
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    //ici la logic pour verifier le  que le code genere == à la valeur entrer par l'user
                    String numAgent = _numAgentController.text;
                    debugPrint("Bouton réinitialiser cliqué");
                    debugPrint("Numéro Agent: $numAgent");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerificationCode(),
                      ),
                    );
                    // Afficher un message de confirmation
                    if (numAgent.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Un lien de réinitialisation a été envoyé pour l'agent $numAgent",
                          ),
                          backgroundColor: const Color(0xFF2196F3),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Veuillez entrer votre numéro Agent"),
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
                    "Generer le code",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Lien "Vous n'avez pas reçu le lien ?"
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Vous n'avez pas reçu le code ?",
                      style: TextStyle(fontSize: 14, color: Color(0xFF7B8A9E)),
                    ),
                    TextButton(
                      onPressed: () {
                        debugPrint("Bouton Renvoyer le code cliqué");
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        "Renvoyer le code",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
