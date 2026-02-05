import 'package:flutter/material.dart';
import 'package:sante_mada/new_patient/AddPatient.dart';
import 'package:sante_mada/patient_consultation/PatientConsultation.dart';
import 'package:sante_mada/feedback_doctor/FeedBackDoctor.dart';
import 'package:sante_mada/Demande_Special/DemandeSpecial.dart';
import 'package:sante_mada/setting_AC/SettingAC.dart';

/// Widget de navigation principale avec BottomNavigationBar
/// Affiche les onglets: Home, Patient, Prescription, Demande, Setting
class MainNavigation extends StatefulWidget {
  final int initialIndex;

  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _currentIndex;

  // Liste des pages correspondant à chaque onglet
  final List<Widget> _pages = [
    const AddPatient(), // Home (index 0)
    const PatientConsultation(), // Patient (index 1)
    const FeedBackDoctor(), // Prescription (index 2)
    const DemandeSpecial(), // Demande (index 3)
    const SettingAC(), // Setting (index 4)
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF151C26),
          border: Border(top: BorderSide(color: Color(0xFF232D3B), width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF151C26),
          selectedItemColor: const Color(0xFF2196F3),
          unselectedItemColor: const Color(0xFF7B8A9E),
          selectedFontSize: 12,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Patient',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined),
              activeIcon: Icon(Icons.description),
              label: 'Prescription',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.inventory_2),
              label: 'Demande',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget personnalisé pour une BottomNavigationBar réutilisable indépendante
/// Utilisez ce widget dans n'importe quel Scaffold pour avoir la barre de navigation
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF151C26),
        border: Border(top: BorderSide(color: Color(0xFF232D3B), width: 1)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF151C26),
        selectedItemColor: const Color(0xFF2196F3),
        unselectedItemColor: const Color(0xFF7B8A9E),
        selectedFontSize: 12,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Patient',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            activeIcon: Icon(Icons.description),
            label: 'Prescription',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Demande',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }

  /// Méthode utilitaire pour naviguer vers une page spécifique
  static void navigateToPage(BuildContext context, int pageIndex) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainNavigation(initialIndex: pageIndex),
      ),
    );
  }
}
