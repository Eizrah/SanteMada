import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sante_mada/classes/widgetUtil.dart';
import 'package:sante_mada/database/dbLocal.dart';
import 'package:sante_mada/fonction/prendrePhoto.dart';
import 'package:sante_mada/models/Patient.dart';
import 'package:image_picker/image_picker.dart';

class AddPatient extends StatefulWidget {
  final String nAgent; // Le numéro de l'agent communautaire connecté

  const AddPatient({super.key, required this.nAgent});

  @override
  State<AddPatient> createState() => _AddPatient();
}

class _AddPatient extends State<AddPatient> {
  bool _isConnected = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    try {
      final results = await Connectivity().checkConnectivity();
      if (mounted) {
        setState(() {
          _isConnected =
              results.isNotEmpty && !results.contains(ConnectivityResult.none);
        });
      }
      _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
        results,
      ) {
        if (mounted) {
          setState(() {
            _isConnected =
                results.isNotEmpty &&
                !results.contains(ConnectivityResult.none);
          });
        }
      });
    } on MissingPluginException catch (_) {
      debugPrint('Connectivity plugin not available on this platform');
      if (mounted) {
        setState(() => _isConnected = false);
      }
    }
  }

  final TextEditingController _numCin = TextEditingController();
  final TextEditingController _nomComplet = TextEditingController();
  final TextEditingController _age = TextEditingController();
  late final TextEditingController _dateNaissance = TextEditingController();
  final TextEditingController _lieuNaissance = TextEditingController();
  final TextEditingController _adresseLocal = TextEditingController();
  final TextEditingController _photo = TextEditingController();
  final TextEditingController _sexe = TextEditingController();
  final TextEditingController _antecedentMaladie = TextEditingController();
  final TextEditingController _maladieHereditaire = TextEditingController();
  final TextEditingController _taille = TextEditingController();
  final TextEditingController _poids = TextEditingController();

  Future<void> ajoutPatient() async {
    List<String> dataPatient = [];
    if (_numCin.text.isEmpty) dataPatient.add("Num cin est obligatoire");
    if (_nomComplet.text.isEmpty)
      dataPatient.add("Nom complet est obligatoire");
    if (_age.text.isEmpty) dataPatient.add("Age est obligatoire");
    if (_dateNaissance.text.isEmpty)
      dataPatient.add("Date de naissance est obligatoire");
    if (_lieuNaissance.text.isEmpty)
      dataPatient.add("Lieu de naissance est obligatoire");
    if (_adresseLocal.text.isEmpty)
      dataPatient.add("Adresse locale est obligatoire");
    if (_photo.text.isEmpty) dataPatient.add("Photo est obligatoire");
    if (_sexe.text.isEmpty) dataPatient.add("Sexe est obligatoire");
    if (_antecedentMaladie.text.isEmpty)
      dataPatient.add("Antecedent maladie est obligatoire");
    if (_maladieHereditaire.text.isEmpty)
      dataPatient.add("Maladie hereditaire est obligatoire");
    if (_taille.text.isEmpty) dataPatient.add("Taille est obligatoire");
    if (_poids.text.isEmpty) dataPatient.add("Poids est obligatoire");

    if (dataPatient.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Veuillez remplir : ${dataPatient.join(', ')}"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    try {
      final newPatient = Patient(
        antecedentMaladie: _antecedentMaladie.text,
        maladieHereditaire: _maladieHereditaire.text,
        poids: double.tryParse(_poids.text) ?? 0,
        taille: double.tryParse(_taille.text) ?? 0,
        numeroAgent: widget.nAgent, // On utilise le nAgent de l'agent connecté
        nCIN: _numCin.text,
        nomComplet: _nomComplet.text,
        age: int.tryParse(_age.text) ?? 0,
        dateNaissance: DateTime.parse(_dateNaissance.text),
        lieuNaissance: _lieuNaissance.text,
        adressLocal: _adresseLocal.text,
        photo: _photo.text.isEmpty ? "" : _photo.text,
        sexe: _sexe.text,
      );
      await Dblocal.insertPatient(newPatient);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Ajout réussi !"),
            backgroundColor: Colors.green,
          ),
        );

        await Future.delayed(const Duration(seconds: 1));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur : $e"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
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
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _isConnected
                  ? const Color(0xFF1A3A2A)
                  : const Color(0xFF3A1A1A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isConnected
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFE53935),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  _isConnected ? 'En ligne' : 'Hors ligne',
                  style: TextStyle(
                    color: _isConnected
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFE53935),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
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
                  onTap: () async {
                    XFile? photo = await prendrePhoto(context);
                    if (!mounted) return;
                    if (photo != null) {
                      setState(() {
                        _photo.text = photo.path;
                      });
                    }
                  },
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
                                color: _photo.text.isNotEmpty
                                    ? const Color(0xFF2196F3)
                                    : const Color(0xFFD4B896),
                                width: 3,
                              ),
                            ),
                            child: ClipOval(
                              child: _photo.text.isNotEmpty
                                  ? Image.file(
                                      File(_photo.text),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      color: const Color(0xFF1A2836),
                                      child: const Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Color(0xFF3E4856),
                                      ),
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
                    ajoutPatient();
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
