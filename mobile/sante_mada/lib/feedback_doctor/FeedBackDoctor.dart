import 'package:flutter/material.dart';

class FeedBackDoctor extends StatefulWidget {
  const FeedBackDoctor({super.key});

  @override
  State<FeedBackDoctor> createState() => _FeedBackDoctorState();
}

class _FeedBackDoctorState extends State<FeedBackDoctor> {
  // Données simulées des feedbacks
  final List<Map<String, dynamic>> feedbacks = [
    {
      'patientName': 'Emma Wilson',
      'patientId': 'PT-2024-001',
      'age': 34,
      'sexe': 'Female',
      'consultationDate': 'Jan 24, 2024',
      'status': 'REVIEWED',
      'avatar': 'EW',
      'diagnosis':
          'Patient presents with elevated blood pressure readings (145/95 mmHg). Symptoms include occasional headaches and fatigue.',
      'recommendations': [
        'Lisinopril 10mg once daily',
        'Low-sodium diet (less than 2,300mg/day)',
        'Monitor BP daily, keep log',
      ],
      'medications': [
        {
          'name': 'Lisinopril 10mg',
          'posologie': 'Once daily, morning',
          'duree': 'Duration: 3 months',
        },
        {
          'name': 'Aspirin 81mg',
          'posologie': 'Once daily, with food',
          'duree': 'Duration: Ongoing',
        },
      ],
      'doctorName': 'Dr. Sarah Johnson',
    },
    {
      'patientName': 'Michael Chen',
      'patientId': 'PT-2024-002',
      'age': 45,
      'sexe': 'Male',
      'consultationDate': 'Jan 23, 2024',
      'status': 'PENDING REVIEW',
      'avatar': 'MC',
      'diagnosis':
          'HbA1c level at 8.2% indicates suboptimal glucose control. Suggesting immediate adjustment of insulin regimen.',
      'recommendations': [
        'Increase Metformin to 1000mg twice daily',
        'Carbohydrate counting education',
      ],
      'medications': [
        {
          'name': 'Metformin 1000mg',
          'posologie': 'Twice daily, with meals',
          'duree': 'Duration: Ongoing',
        },
      ],
      'doctorName': 'Dr. Jennifer Lee',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => debugPrint("Retour"),
        ),
        title: const Text(
          'Doctor Feedbacks',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Stats Cards
              Row(
                children: [
                  _buildStatCard("TOTAL", "47", const Color(0xFF151C26)),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    "NEW TODAY",
                    "15",
                    const Color(0xFF102D4A),
                    labelColor: const Color(0xFF2196F3),
                  ),
                  const SizedBox(width: 12),
                  _buildStatCard(
                    "PENDING",
                    "8",
                    const Color(0xFF1A2D1A),
                    labelColor: const Color(0xFF4CAF50),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Liste des feedbacks
              ...feedbacks
                  .map((feedback) => _buildFeedbackCard(feedback))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    Color bgColor, {
    Color labelColor = const Color(0xFF7B8A9E),
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackCard(Map<String, dynamic> feedback) {
    final bool isReviewed = feedback['status'] == 'REVIEWED';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151C26),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar + Infos + Badge
          Row(
            children: [
              // Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF102D4A),
                  border: Border.all(color: const Color(0xFF2196F3), width: 2),
                ),
                child: Center(
                  child: Text(
                    feedback['avatar'],
                    style: const TextStyle(
                      color: Color(0xFF2196F3),
                      fontWeight: FontWeight.bold,
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
                      feedback['patientName'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${feedback['patientId']} • Age: ${feedback['age']} • ${feedback['sexe']}",
                      style: const TextStyle(
                        color: Color(0xFF7B8A9E),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Consultation: ${feedback['consultationDate']}",
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isReviewed
                      ? const Color(0xFF1A3A2A)
                      : const Color(0xFF3A2A1A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  feedback['status'],
                  style: TextStyle(
                    color: isReviewed
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFFF9800),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Section: Doctor's Diagnosis
          _buildSectionHeader(
            Icons.description_outlined,
            "DOCTOR'S DIAGNOSIS",
            const Color(0xFF2196F3),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF1A2530),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              feedback['diagnosis'],
              style: const TextStyle(
                color: Color(0xFFB8C5D3),
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Section: Recommended Treatment (Recommandations du docteur)
          _buildSectionHeader(
            Icons.check_circle_outline,
            "RECOMMENDED TREATMENT",
            const Color(0xFF4CAF50),
          ),
          const SizedBox(height: 10),
          ...(feedback['recommendations'] as List)
              .map(
                (rec) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "•  ",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Expanded(
                        child: Text(
                          rec,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          const SizedBox(height: 18),

          // Section: Prescribed Medications
          _buildSectionHeader(
            Icons.medication_outlined,
            "PRESCRIBED MEDICATIONS",
            const Color(0xFF2196F3),
          ),
          const SizedBox(height: 10),
          Row(
            children: (feedback['medications'] as List)
                .map<Widget>(
                  (med) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            med['name'],
                            style: const TextStyle(
                              color: Color(0xFF2196F3),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            med['posologie'],
                            style: const TextStyle(
                              color: Color(0xFF7B8A9E),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            med['duree'],
                            style: const TextStyle(
                              color: Color(0xFF7B8A9E),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),

          // Footer: Docteur + Bouton Contact
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF102D4A),
                  border: Border.all(color: const Color(0xFF2196F3), width: 1),
                ),
                child: const Icon(
                  Icons.person,
                  size: 16,
                  color: Color(0xFF2196F3),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  feedback['doctorName'],
                  style: const TextStyle(
                    color: Color(0xFF7B8A9E),
                    fontSize: 13,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () =>
                    debugPrint("Contacter ${feedback['doctorName']}"),
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  size: 16,
                  color: Colors.white,
                ),
                label: const Text(
                  "Contact Doctor",
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title, Color color) {
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
