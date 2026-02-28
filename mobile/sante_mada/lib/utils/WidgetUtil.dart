import 'package:flutter/material.dart';
import 'package:sante_mada/patient_consultation/PatientConsultation.dart';

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
                      // ── Titre ──
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

                      // ── Gravité ──
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

                      // ── Symptômes ──
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

                      // ── Boutons ──
                      Row(
                        children: [
                          // Bouton "Voir consultation"
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
                          // Bouton "Enregistrer"
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
          // Header: avatar + nom + gravité + boutons action
          Row(
            children: [
              // Avatar
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
              // Infos patient
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
              // Badge gravité
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
              // Bouton œil (voir/modifier consultation)
              _ActionIconButton(
                icon: Icons.remove_red_eye_rounded,
                color: const Color(0xFF2196F3),
                tooltip: "Voir la consultation",
                onPressed: () => _showConsultationDialog(context),
              ),
              // Bouton supprimer
              _ActionIconButton(
                icon: Icons.delete_outline_rounded,
                color: const Color(0xFFE53935),
                tooltip: "Supprimer",
                onPressed: onDelete,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Symptômes
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
