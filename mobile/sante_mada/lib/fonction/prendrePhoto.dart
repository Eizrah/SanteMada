import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

/// Ouvre un dialog pour choisir la source (caméra ou galerie),
/// puis retourne le fichier image sélectionné, ou null si annulé.

Future<XFile?> prendrePhoto(BuildContext context) async {
  // Vérifier que le contexte est encore valide
  if (!context.mounted) return null;

  final ImagePicker picker = ImagePicker();

  // Afficher un BottomSheet pour choisir la source
  final ImageSource? source = await showModalBottomSheet<ImageSource>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext ctx) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choisir une source',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Prendre une photo'),
                onTap: () => Navigator.pop(ctx, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('Choisir depuis la galerie'),
                onTap: () => Navigator.pop(ctx, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.close, color: Colors.red),
                title: const Text('Annuler'),
                onTap: () => Navigator.pop(ctx, null),
              ),
            ],
          ),
        ),
      );
    },
  );

  // Si l'utilisateur a annulé le choix
  if (source == null) return null;

  try {
    // Prendre la photo selon la source choisie
    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1280,
      maxHeight: 1280,
    );
    return image;
  } on PlatformException catch (e) {
    // Permission refusée ou caméra non disponible
    debugPrint(
      'Erreur image_picker (PlatformException): ${e.code} - ${e.message}',
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.code == 'camera_access_denied'
                ? 'Accès à la caméra refusé. Veuillez autoriser l\'accès dans les paramètres.'
                : e.code == 'photo_access_denied'
                ? 'Accès à la galerie refusé. Veuillez autoriser l\'accès dans les paramètres.'
                : 'Impossible d\'accéder à la caméra/galerie : ${e.message}',
          ),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 3),
        ),
      );
    }
    return null;
  } catch (e) {
    debugPrint('Erreur inattendue lors de la prise de photo: $e');
    return null;
  }
}
