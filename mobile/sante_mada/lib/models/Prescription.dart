//classe d'association entre AC, Medecin et Patient

import 'package:uuid/uuid.dart';

class Prescription {
  String idPrescription = const Uuid().v4();
  String idAgentCommunautaire;
  String idMedecin;
  String idPatient;
  DateTime datePrescription;
  String descPrescription;



  Prescription({required this.idAgentCommunautaire, required this.idMedecin, required this.idPatient, required this.datePrescription, required this.descPrescription});

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      idAgentCommunautaire: json['idAgentCommunautaire'],
      idMedecin: json['idMedecin'],
      idPatient: json['idPatient'],
      datePrescription: DateTime.parse(json['datePrescription']),
      descPrescription: json['descPrescription'],
    );
  }

  factory Prescription.fromMap(Map<String, dynamic> map) {
    return Prescription(
      idAgentCommunautaire: map['idAgentCommunautaire'],
      idMedecin: map['idMedecin'],
      idPatient: map['idPatient'],
      datePrescription: DateTime.parse(map['datePrescription']),
      descPrescription: map['descPrescription'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idPrescription': idPrescription,
      'idAgentCommunautaire': idAgentCommunautaire,
      'idMedecin': idMedecin,
      'idPatient': idPatient,
      'datePrescription': datePrescription.toIso8601String(),
      'descPrescription': descPrescription,
    };
  }
}