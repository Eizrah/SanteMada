import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sante_mada/utils/WidgetUtil.dart';

class Recap extends StatefulWidget {
  const Recap({super.key});

  @override
  State<Recap> createState() => _RecapState();
}

class _RecapState extends State<Recap> {
  bool _isConnected = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isSending = false;

  // Données simulées des demandes spéciales
  final List<Map<String, dynamic>> demandesSpeciales = [
    {
      'nom': 'Paracétamol 500mg',
      'quantite': 4,
      'status': 'EN ATTENTE',
      'date': '23 Fév 2026',
      'icon': Icons.medication,
      'color': const Color(0xFF2196F3),
    },
    {
      'nom': 'Kit Pansement Basic',
      'quantite': 1,
      'status': 'ENVOYÉ',
      'date': '22 Fév 2026',
      'icon': Icons.medical_services,
      'color': const Color(0xFF4CAF50),
    },
    {
      'nom': 'Amoxicilline Sirop',
      'quantite': 2,
      'status': 'EN ATTENTE',
      'date': '21 Fév 2026',
      'icon': Icons.water_drop,
      'color': const Color(0xFFFF9800),
    },
  ];

  // Données simulées des patients consultés
  List<Map<String, dynamic>> patientsConsultes = [
    {
      'nom': 'Jean Dupont',
      'initiales': 'JD',
      'age': 42,
      'sexe': 'Homme',
      'symptomes': 'Fièvre persistante, maux de tête, fatigue générale',
      'date': '23 Fév 2026',
      'gravite': 'Modéré',
    },
    {
      'nom': 'Marie Rakoto',
      'initiales': 'MR',
      'age': 28,
      'sexe': 'Femme',
      'symptomes': 'Toux sèche, douleurs thoraciques, essoufflement',
      'date': '22 Fév 2026',
      'gravite': 'Urgent',
    },
    {
      'nom': 'Paul Andria',
      'initiales': 'PA',
      'age': 55,
      'sexe': 'Homme',
      'symptomes': 'Douleurs articulaires, gonflement des genoux',
      'date': '21 Fév 2026',
      'gravite': 'Léger',
    },
  ];

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

  /// Envoi de toutes les demandes en attente
  Future<void> _envoyerToutes() async {
    setState(() => _isSending = true);

    // Simulation d'un appel réseau (remplacer par vrai appel API)
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        for (final d in demandesSpeciales) {
          d['status'] = 'ENVOYÉ';
        }
        _isSending = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Toutes les demandes ont été envoyées !',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF4CAF50),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  /// Supprimer un patient de la liste
  void _supprimerPatient(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF151C26),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Supprimer le patient ?',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        content: Text(
          'Voulez-vous vraiment supprimer "${patientsConsultes[index]['nom']}" de la liste ?',
          style: const TextStyle(color: Color(0xFF7B8A9E), fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Annuler',
              style: TextStyle(color: Color(0xFF7B8A9E)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() => patientsConsultes.removeAt(index));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Supprimer',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Si pas connecté, afficher un écran spécial
    if (!_isConnected) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F1923),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'Récapitulatif',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          actions: [ConnectionBadge(isConnected: _isConnected)],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF3A1A1A),
                    border: Border.all(
                      color: const Color(0xFFE53935),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.cloud_off_rounded,
                    color: Color(0xFFE53935),
                    size: 50,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Connexion requise",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Le récapitulatif nécessite une connexion internet pour synchroniser les données.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF7B8A9E),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () => _initConnectivity(),
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: const Text(
                      "Réessayer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
              ],
            ),
          ),
        ),
      );
    }

    // Écran principal quand connecté
    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Récapitulatif',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [ConnectionBadge(isConnected: _isConnected)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              //Stats rapides 
              Row(
                children: [
                  StatCard(
                    label: "Demandes",
                    value: "${demandesSpeciales.length}",
                    bgColor: const Color(0xFF102D4A),
                    icon: Icons.inventory_2,
                    iconColor: const Color(0xFF2196F3),
                  ),
                  const SizedBox(width: 12),
                  StatCard(
                    label: "Patients",
                    value: "${patientsConsultes.length}",
                    bgColor: const Color(0xFF1A3A2A),
                    icon: Icons.people,
                    iconColor: const Color(0xFF4CAF50),
                  ),
                  const SizedBox(width: 12),
                  StatCard(
                    label: "Urgents",
                    value:
                        "${patientsConsultes.where((p) => p['gravite'] == 'Urgent').length}",
                    bgColor: const Color(0xFF3A1A1A),
                    icon: Icons.warning_rounded,
                    iconColor: const Color(0xFFE53935),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              //Section Demandes Spéciale
              Row(
                children: [
                  const Expanded(
                    child: SectionHeader(
                      icon: Icons.inventory_2,
                      title: "DEMANDES SPÉCIALES",
                      color: Color(0xFF2196F3),
                    ),
                  ),
                  //Bouton Envoye
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isSending
                        ? const SizedBox(
                            key: ValueKey('loading'),
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Color(0xFF2196F3),
                            ),
                          )
                        : ElevatedButton.icon(
                            key: const ValueKey('send'),
                            onPressed: _envoyerToutes,
                            icon: const Icon(
                              Icons.send_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Envoyer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2196F3),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...demandesSpeciales
                  .map((demande) => DemandeCard(demande: demande))
                  .toList(),
              const SizedBox(height: 24),

              //Section Patients Consulté
              const SectionHeader(
                icon: Icons.people_outline,
                title: "PATIENTS CONSULTÉS — SYMPTÔMES",
                color: Color(0xFF4CAF50),
              ),
              const SizedBox(height: 12),
              ...patientsConsultes.asMap().entries.map(
                (entry) => PatientSymptomeCard(
                  patient: entry.value,
                  onDelete: () => _supprimerPatient(entry.key),
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
