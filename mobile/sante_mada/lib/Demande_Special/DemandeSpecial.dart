import 'package:flutter/material.dart';

class DemandeSpecial extends StatefulWidget {
  const DemandeSpecial({super.key});

  @override
  State<DemandeSpecial> createState() => _DemandeSpecialState();
}

class _DemandeSpecialState extends State<DemandeSpecial> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  // Liste des médicaments
  final List<Map<String, dynamic>> medicaments = [
    {
      'nom': 'Paracétamol 500mg',
      'description': 'Boîte de 20 tabs',
      'icon': Icons.medication,
      'color': Color(0xFF2196F3),
      'quantite': 4,
    },
    {
      'nom': 'Amoxicilline',
      'description': 'Sirop 250mg/5ml',
      'icon': Icons.water_drop,
      'color': Color(0xFF2196F3),
      'quantite': 0,
    },
  ];

  // Liste des kits
  final List<Map<String, dynamic>> kits = [
    {
      'nom': 'Kit Pansement Basic',
      'description': '10 bandages + antiseptique',
      'icon': Icons.medical_services,
      'color': Color(0xFFE53935),
      'quantite': 1,
    },
  ];

  // Médicaments fréquemment demandés
  final List<Map<String, dynamic>> medicamentsFrequents = [
    {'nom': 'Ibuprofène 400mg', 'description': 'Boîte de 30 tabs'},
    {'nom': 'Doliprane 1000mg', 'description': 'Boîte de 8 tabs'},
    {'nom': 'Vitamine C 500mg', 'description': 'Boîte de 30 tabs'},
    {'nom': 'Oméprazole 20mg', 'description': 'Boîte de 14 gélules'},
  ];

  // Kits fréquemment demandés
  final List<Map<String, dynamic>> kitsFrequents = [
    {
      'nom': 'Kit Urgence Complet',
      'description': 'Bandages, gaze, antiseptique',
    },
    {'nom': 'Kit Brûlures', 'description': 'Crème + pansements spéciaux'},
    {'nom': 'Kit Injection', 'description': 'Seringues, coton, alcool'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _showVoirTout(String title, List<Map<String, dynamic>> items) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF151C26),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Objets les plus fréquemment demandés",
              style: TextStyle(color: Color(0xFF7B8A9E), fontSize: 13),
            ),
            const SizedBox(height: 16),
            ...items
                .map(
                  (item) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF102D4A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.medication,
                        color: Color(0xFF2196F3),
                        size: 20,
                      ),
                    ),
                    title: Text(
                      item['nom'],
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    subtitle: Text(
                      item['description'],
                      style: const TextStyle(
                        color: Color(0xFF7B8A9E),
                        fontSize: 12,
                      ),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        debugPrint("Ajouter ${item['nom']}");
                      },
                      child: const Text(
                        "Ajouter",
                        style: TextStyle(color: Color(0xFF2196F3)),
                      ),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
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
          onPressed: () => debugPrint("Retour"),
        ),
        title: const Text(
          'Demandes Spéciales',
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
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                "Commandez des fournitures médicales essentielles pour votre zone rurale.",
                style: TextStyle(color: Color(0xFF7B8A9E), fontSize: 14),
              ),
              const SizedBox(height: 20),

              // Barre de recherche
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF151C26),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF232D3B)),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Rechercher un article...",
                    hintStyle: TextStyle(color: Color(0xFF3E4856)),
                    prefixIcon: Icon(Icons.search, color: Color(0xFF3E4856)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Section Médicaments
              _buildSectionHeader(
                Icons.medication,
                "Médicaments",
                () => _showVoirTout("Médicaments", medicamentsFrequents),
              ),
              const SizedBox(height: 12),
              ...medicaments.map((med) => _buildItemCard(med)).toList(),
              const SizedBox(height: 24),

              // Section Kits de Premier Secours
              _buildSectionHeader(
                Icons.medical_services,
                "Kits de Premier Secours",
                () => _showVoirTout("Kits de Premier Secours", kitsFrequents),
              ),
              const SizedBox(height: 12),
              ...kits.map((kit) => _buildItemCard(kit)).toList(),
              const SizedBox(height: 24),

              // Notes ou Précisions
              const Text(
                "Notes ou Précisions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF151C26),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF232D3B)),
                ),
                child: TextField(
                  controller: _notesController,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText:
                        "Ex: Urgent, besoin pour la clinique mobile de demain...",
                    hintStyle: TextStyle(color: Color(0xFF3E4856)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Bouton Valider la demande
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: () {
                    debugPrint("Valider la demande");
                    debugPrint("Notes: ${_notesController.text}");
                  },
                  icon: const Icon(Icons.send, color: Colors.white, size: 20),
                  label: const Text(
                    "Valider la demande",
                    style: TextStyle(
                      fontSize: 17,
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

  Widget _buildSectionHeader(
    IconData icon,
    String title,
    VoidCallback onVoirTout,
  ) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF2196F3), size: 22),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onVoirTout,
          child: const Text(
            "Voir tout",
            style: TextStyle(color: Color(0xFF2196F3), fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF151C26),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Icône
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: item['color'].withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item['icon'], color: item['color'], size: 26),
          ),
          const SizedBox(width: 14),
          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['nom'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item['description'],
                  style: const TextStyle(
                    color: Color(0xFF7B8A9E),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Quantité ou bouton Ajouter
          if (item['quantite'] > 0)
            Row(
              children: [
                _buildQtyButton(
                  Icons.remove,
                  () => setState(() => item['quantite']--),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "${item['quantite']}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildQtyButton(
                  Icons.add,
                  () => setState(() => item['quantite']++),
                  filled: true,
                ),
              ],
            )
          else
            TextButton(
              onPressed: () => setState(() => item['quantite'] = 1),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF1A2530),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "${item['quantite']}",
                    style: const TextStyle(
                      color: Color(0xFF7B8A9E),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Ajouter",
                    style: TextStyle(color: Color(0xFF7B8A9E), fontSize: 14),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQtyButton(
    IconData icon,
    VoidCallback onPressed, {
    bool filled = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: filled ? const Color(0xFF2196F3) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: filled ? null : Border.all(color: const Color(0xFF3E4856)),
        ),
        child: Icon(
          icon,
          color: filled ? Colors.white : const Color(0xFF3E4856),
          size: 18,
        ),
      ),
    );
  }
}
