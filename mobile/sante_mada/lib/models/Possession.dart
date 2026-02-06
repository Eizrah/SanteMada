//classe d'association entre Consultation et Medicament
import 'package:uuid/uuid.dart';
class Possession {
  String idPossession = const Uuid().v4();
  String idPrescription;
  String idMedicament;
  int quantite;

  Possession({required this.idPrescription, required this.idMedicament, required this.quantite});

  factory Possession.fromJson(Map<String, dynamic> json) {
    return Possession(
      idPrescription: json['idPrescription'],
      idMedicament: json['idMedicament'],
      quantite: json['quantite'],
    );
  }

  factory Possession.fromMap(Map<String, dynamic> map) {
    return Possession(
      idPrescription: map['idPrescription'],
      idMedicament: map['idMedicament'],
      quantite: map['quantite'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idPossession': idPossession,
      'idPrescription': idPrescription,
      'idMedicament': idMedicament,
      'quantite': quantite,
    };
  }
}