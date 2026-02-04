import 'package:flutter/material.dart';

class Acceuil extends StatelessWidget {
  const Acceuil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF101C28,
      ), // Couleur de fond bleu marine foncé
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Spacer(flex: 3),
            // Zone de l'icône centrale
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Grand cercle de fond sombre
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF283D52),
                    border: Border.all(
                      color: const Color(0xFF2196F3),
                      width: 0.5,
                    ),
                    //
                    boxShadow: [
                      BoxShadow(
                        // Couleur bleu clair avec opacité 0.4
                        color: const Color(0xFF2196F3).withOpacity(0.1),
                        blurRadius: 1, // Augmenté pour un effet plus diffus
                        spreadRadius: 30, // Étend légèrement l'ombre
                        offset: const Offset(
                          0,
                          0,
                        ), // Centré pour l'effet de lueur
                      ),
                    ],
                    //
                  ),
                  child: Center(
                    child: CustomPaint(
                      size: const Size(80, 80),
                      painter: MedicalIconPainter(),
                    ),
                  ),
                ),
                // Petit badge Wi-Fi bleu en haut à droite
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2196F3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.wifi,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            // Titre de l'application
            const Text(
              "Sante pour tous",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            // Slogan
            const Text(
              "Relier les soins aux communautés\nisolées.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: Color(0xFF707E8D), // Gris bleuté de l'image
                height: 1.4,
              ),
            ),
            const Spacer(flex: 2),
            // Bouton S'inscrire (Plein)
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Bouton Se connecter (Contourné/Sombre)
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D293C),
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF232D3B), width: 1.5),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Se connecter",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Version en bas
            const Text(
              "VERSION 1.0.0",
              style: TextStyle(
                color: Color(0xFF3E4856),
                letterSpacing: 2,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

/// Dessin personnalisé du logo médical (Croix + ECG)
class MedicalIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintBlue = Paint()
      ..color = const Color(0xFF2196F3)
      ..style = PaintingStyle.fill;

    final paintDark = Paint()
      ..color =
          const Color(0xFF151C26) // Même couleur que le fond du cercle
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double w = size.width;
    final double h = size.height;
    final double crossThickness = w * 0.35;

    // 1. Dessiner la croix (le "plus")
    RRect verticalBar = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(w / 2, h / 2),
        width: crossThickness,
        height: h,
      ),
      const Radius.circular(8),
    );
    RRect horizontalBar = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(w / 2, h / 2),
        width: w,
        height: crossThickness,
      ),
      const Radius.circular(8),
    );

    canvas.drawRRect(verticalBar, paintBlue);
    canvas.drawRRect(horizontalBar, paintBlue);

    // 2. Dessiner la ligne ECG au centre
    final Path path = Path();
    path.moveTo(0, h / 2); // Début à gauche
    path.lineTo(w * 0.3, h / 2); // Ligne droite
    path.lineTo(w * 0.4, h * 0.25); // Pic haut
    path.lineTo(w * 0.55, h * 0.75); // Pic bas
    path.lineTo(w * 0.65, h * 0.4); // Petit retour haut
    path.lineTo(w * 0.75, h / 2); // Retour milieu
    path.lineTo(w, h / 2); // Fin à droite

    canvas.drawPath(path, paintDark);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}





/*
NOTE

les contour de l'ombre de MedicalIcon A revoir
 */