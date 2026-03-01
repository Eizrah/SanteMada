import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Ajoute intl dans ton pubspec.yaml pour le formatage de date
import 'package:sante_mada/screen/patient_consultation/PatientConsultation.dart';

/// Widget réutilisable pour un champ de texte normal avec icône

class CustomTextFieldReadOnly extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon; // Nouvelle icône
  final TextEditingController? controller;
  final bool readOnly;
  const CustomTextFieldReadOnly({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
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
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: const Color(0xFF3E4856),
            ), // Icône devant le hint
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF3E4856)),
            filled: true,
            fillColor: const Color(0xFF151C26),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
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

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon; // Nouvelle icône
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.controller,
    required TextInputType keyboardType,
  });

  @override
  Widget build(BuildContext context) {
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
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: const Color(0xFF3E4856),
            ), // Icône devant le hint
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF3E4856)),
            filled: true,
            fillColor: const Color(0xFF151C26),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
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

/// Widget Calendrier qui ouvre le sélecteur de date
class CustomCalendrier extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const CustomCalendrier({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  State<CustomCalendrier> createState() => _CustomCalendrierState();
}

class _CustomCalendrierState extends State<CustomCalendrier> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      // Personnalisation du thème du calendrier pour qu'il soit sombre
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF2196F3),
              onPrimary: Colors.white,
              surface: Color(0xFF151C26),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        // Formatage de la date (ex: 2024-05-20)
        widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: widget.controller,
          readOnly: true, // Empêche de taper manuellement
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.calendar_month,
              color: Color(0xFF3E4856),
            ),
            hintText: "Sélectionnez une date",
            hintStyle: const TextStyle(color: Color(0xFF3E4856)),
            filled: true,
            fillColor: const Color(0xFF151C26),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.calendar_today_outlined,
                color: Color(0xFF2196F3),
              ),
              onPressed: () => _selectDate(context), // Ouvre le calendrier
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF232D3B)),
            ),
          ),
          onTap: () => _selectDate(
            context,
          ), // Ouvre aussi le calendrier au clic sur le champ
        ),
      ],
    );
  }
}

/// Widget mot de passe avec icône de début
class CustomPasswordField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;

  const CustomPasswordField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: widget.controller,
          obscureText: !_isPasswordVisible,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xFF3E4856),
            ), // Icône cadenas devant
            hintText: widget.hint,
            hintStyle: const TextStyle(color: Color(0xFF3E4856)),
            filled: true,
            fillColor: const Color(0xFF151C26),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: const Color(0xFF3E4856),
              ),
              onPressed: () =>
                  setState(() => _isPasswordVisible = !_isPasswordVisible),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF232D3B)),
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget pour sélectionner le genre (Masculin, Féminin, Autre)
class CustomGenreSelector extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? initialValue;

  const CustomGenreSelector({
    super.key,
    required this.label,
    required this.controller,
    this.initialValue,
  });

  @override
  State<CustomGenreSelector> createState() => _CustomGenreSelectorState();
}

class _CustomGenreSelectorState extends State<CustomGenreSelector> {
  String? _selectedGenre;

  final List<String> _genres = ['Masculin', 'Féminin', 'Autre'];

  @override
  void initState() {
    super.initState();
    _selectedGenre = widget.initialValue ?? widget.controller.text;
    if (_selectedGenre != null && _selectedGenre!.isEmpty) {
      _selectedGenre = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF151C26),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF232D3B)),
          ),
          child: Row(
            children: _genres.map((genre) {
              final isSelected = _selectedGenre == genre;
              final isFirst = genre == _genres.first;
              final isLast = genre == _genres.last;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGenre = genre;
                      widget.controller.text = genre;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2196F3).withOpacity(0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.horizontal(
                        left: isFirst ? const Radius.circular(12) : Radius.zero,
                        right: isLast ? const Radius.circular(12) : Radius.zero,
                      ),
                      border: isSelected
                          ? Border.all(
                              color: const Color(0xFF2196F3),
                              width: 1.5,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        genre,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF2196F3)
                              : const Color(0xFF707E8D),
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

/// Widget pour capturer une photo de patient
class CustomPhotoCapture extends StatelessWidget {
  final String label;
  final String hint;
  final VoidCallback? onTap;

  const CustomPhotoCapture({
    super.key,
    required this.label,
    required this.hint,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD4B896), width: 3),
                ),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF5F0EB),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: Color(0xFFD4B896),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2196F3),
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
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          hint,
          style: const TextStyle(fontSize: 14, color: Color(0xFF2196F3)),
        ),
      ],
    );
  }
}

/// Widget TextArea multiligne
class CustomTextArea extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final int maxLines;

  const CustomTextArea({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.maxLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Color(0xFF1A1A2E)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
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

/// TextField style clair
class CustomTextFieldLight extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? icon;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const CustomTextFieldLight({
    super.key,
    required this.label,
    required this.hint,
    this.icon,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Color(0xFF1A1A2E)),
          decoration: InputDecoration(
            prefixIcon: icon != null
                ? Icon(icon, color: const Color(0xFF9E9E9E))
                : null,
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
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

/// Calendrier style clair
class CustomCalendrierLight extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const CustomCalendrierLight({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  State<CustomCalendrierLight> createState() => _CustomCalendrierLightState();
}

class _CustomCalendrierLightState extends State<CustomCalendrierLight> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF2196F3),
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(
        () => widget.controller.text = DateFormat('dd/MM/yyyy').format(picked),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: widget.controller,
          readOnly: true,
          style: const TextStyle(color: Color(0xFF1A1A2E)),
          decoration: InputDecoration(
            hintText: "JJ/MM/AAAA",
            hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.calendar_today_outlined,
                color: Color(0xFF2196F3),
              ),
              onPressed: () => _selectDate(context),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
          onTap: () => _selectDate(context),
        ),
      ],
    );
  }
}

/// Genre selector style clair
class CustomGenreSelectorLight extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const CustomGenreSelectorLight({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  State<CustomGenreSelectorLight> createState() =>
      _CustomGenreSelectorLightState();
}

class _CustomGenreSelectorLightState extends State<CustomGenreSelectorLight> {
  String? _selectedGenre;
  final List<String> _genres = ['Masculin', 'Féminin', 'Autre'];

  @override
  void initState() {
    super.initState();
    _selectedGenre = widget.controller.text.isNotEmpty
        ? widget.controller.text
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Row(
            children: _genres.map((genre) {
              final isSelected = _selectedGenre == genre;
              final isFirst = genre == _genres.first;
              final isLast = genre == _genres.last;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    _selectedGenre = genre;
                    widget.controller.text = genre;
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2196F3).withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.horizontal(
                        left: isFirst ? const Radius.circular(12) : Radius.zero,
                        right: isLast ? const Radius.circular(12) : Radius.zero,
                      ),
                      border: isSelected
                          ? Border.all(
                              color: const Color(0xFF2196F3),
                              width: 1.5,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        genre,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF2196F3)
                              : const Color(0xFF707E8D),
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Carte statistique (Demandes / Patients / Urgents)
// ─────────────────────────────────────────────────────────────
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color bgColor;
  final IconData icon;
  final Color iconColor;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.bgColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: iconColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  En-tête de section (icône + titre coloré)
// ─────────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const SectionHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Carte demande spéciale
// ─────────────────────────────────────────────────────────────
class DemandeCard extends StatelessWidget {
  final Map<String, dynamic> demande;

  const DemandeCard({super.key, required this.demande});

  @override
  Widget build(BuildContext context) {
    final bool isEnvoye = demande['status'] == 'ENVOYÉ';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF151C26),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Icône
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: (demande['color'] as Color).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(demande['icon'], color: demande['color'], size: 24),
          ),
          const SizedBox(width: 14),
          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  demande['nom'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "Qté: ${demande['quantite']} • ${demande['date']}",
                  style: const TextStyle(
                    color: Color(0xFF7B8A9E),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Badge status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: isEnvoye
                  ? const Color(0xFF1A3A2A)
                  : const Color(0xFF3A2A1A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              demande['status'],
              style: TextStyle(
                color: isEnvoye
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFFF9800),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Carte patient consulté (avec boutons œil & supprimer)
// ─────────────────────────────────────────────────────────────
class PatientSymptomeCard extends StatelessWidget {
  final Map<String, dynamic> patient;
  final VoidCallback onDelete;

  const PatientSymptomeCard({
    super.key,
    required this.patient,
    required this.onDelete,
  });

  Color get _graviteColor {
    switch (patient['gravite']) {
      case 'Urgent':
        return const Color(0xFFE53935);
      case 'Modéré':
        return const Color(0xFFFF9800);
      default:
        return const Color(0xFF4CAF50);
    }
  }

  Color get _graviteBgColor {
    switch (patient['gravite']) {
      case 'Urgent':
        return const Color(0xFF3A1A1A);
      case 'Modéré':
        return const Color(0xFF3A2A1A);
      default:
        return const Color(0xFF1A3A2A);
    }
  }

  void _showConsultationDialog(BuildContext context) {
    final TextEditingController symptomesCtrl = TextEditingController(
      text: patient['symptomes'] ?? '',
    );
    String gravite = patient['gravite'] ?? 'Léger';

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setStateDialog) {
            return Dialog(
              backgroundColor: const Color(0xFF151C26),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF102D4A),
                              border: Border.all(
                                color: const Color(0xFF2196F3),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                patient['initiales'] ?? '?',
                                style: const TextStyle(
                                  color: Color(0xFF2196F3),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  patient['nom'] ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${patient['age']} ans • ${patient['sexe']}",
                                  style: const TextStyle(
                                    color: Color(0xFF7B8A9E),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Color(0xFF7B8A9E),
                            ),
                            onPressed: () => Navigator.of(ctx).pop(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFF232D3B)),
                      const SizedBox(height: 12),
                      const Text(
                        "GRAVITÉ",
                        style: TextStyle(
                          color: Color(0xFF7B8A9E),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: ['Léger', 'Modéré', 'Urgent'].map((g) {
                          final bool selected = gravite == g;
                          Color chipColor;
                          switch (g) {
                            case 'Urgent':
                              chipColor = const Color(0xFFE53935);
                              break;
                            case 'Modéré':
                              chipColor = const Color(0xFFFF9800);
                              break;
                            default:
                              chipColor = const Color(0xFF4CAF50);
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () => setStateDialog(() => gravite = g),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? chipColor.withOpacity(0.2)
                                      : const Color(0xFF1A2530),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: selected
                                        ? chipColor
                                        : const Color(0xFF232D3B),
                                  ),
                                ),
                                child: Text(
                                  g,
                                  style: TextStyle(
                                    color: selected
                                        ? chipColor
                                        : const Color(0xFF7B8A9E),
                                    fontSize: 13,
                                    fontWeight: selected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "SYMPTÔMES",
                        style: TextStyle(
                          color: Color(0xFF7B8A9E),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A2530),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF232D3B)),
                        ),
                        child: TextField(
                          controller: symptomesCtrl,
                          maxLines: 4,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Décrivez les symptômes...",
                            hintStyle: TextStyle(color: Color(0xFF3E4856)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const PatientConsultation(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.open_in_new,
                                size: 16,
                                color: Color(0xFF2196F3),
                              ),
                              label: const Text(
                                "Consultation",
                                style: TextStyle(
                                  color: Color(0xFF2196F3),
                                  fontSize: 13,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF2196F3),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                patient['symptomes'] = symptomesCtrl.text;
                                patient['gravite'] = gravite;
                                Navigator.of(ctx).pop(true);
                              },
                              icon: const Icon(
                                Icons.save,
                                size: 16,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Enregistrer",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2196F3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151C26),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF102D4A),
                  border: Border.all(color: const Color(0xFF2196F3), width: 2),
                ),
                child: Center(
                  child: Text(
                    patient['initiales'],
                    style: const TextStyle(
                      color: Color(0xFF2196F3),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient['nom'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${patient['age']} ans • ${patient['sexe']} • ${patient['date']}",
                      style: const TextStyle(
                        color: Color(0xFF7B8A9E),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: _graviteBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  patient['gravite'],
                  style: TextStyle(
                    color: _graviteColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _ActionIconButton(
                icon: Icons.remove_red_eye_rounded,
                color: const Color(0xFF2196F3),
                tooltip: "Voir la consultation",
                onPressed: () => _showConsultationDialog(context),
              ),
              _ActionIconButton(
                icon: Icons.delete_outline_rounded,
                color: const Color(0xFFE53935),
                tooltip: "Supprimer",
                onPressed: onDelete,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A2530),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.notes_rounded,
                  color: Color(0xFF7B8A9E),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    patient['symptomes'],
                    style: const TextStyle(
                      color: Color(0xFFB8C5D3),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Petit bouton icône pour les actions (interne)
// ─────────────────────────────────────────────────────────────
class _ActionIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onPressed;

  const _ActionIconButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Badge de connexion (En ligne / Hors ligne)
// ─────────────────────────────────────────────────────────────
class ConnectionBadge extends StatelessWidget {
  final bool isConnected;

  const ConnectionBadge({super.key, required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isConnected ? const Color(0xFF1A3A2A) : const Color(0xFF3A1A1A),
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
              color: isConnected
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFFE53935),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            isConnected ? 'En ligne' : 'Hors ligne',
            style: TextStyle(
              color: isConnected
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFFE53935),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
