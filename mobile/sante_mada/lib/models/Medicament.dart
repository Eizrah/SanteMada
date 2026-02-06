import 'package:uuid/uuid.dart';

class Medicament {
  String idMedicament = const Uuid().v4();
  String nom;

  Medicament({required this.nom});

  factory Medicament.fromJson(Map<String, dynamic> json) {
    return Medicament(
      nom: json['nom'],
    );
  }

  factory Medicament.fromMap(Map<String, dynamic> map) {
    return Medicament(
      nom: map['nom'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idMedicament': idMedicament,
      'nom': nom,
    };
  }
}
