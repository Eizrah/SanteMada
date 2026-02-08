import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Ajoute intl dans ton pubspec.yaml pour le formatage de date

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
    this.readOnly=false,
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
