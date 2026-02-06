// classe d'association entre Medecin et PatientidConsult
import 'package:uuid/uuid.dart';

class Consultation {
  String idConsultation = const Uuid().v4();
  DateTime dateConsultation;

  String descMaladie;
  String nCINPatient;
  String numMatriculMedecin;
  bool isSynced;
  String vocal; //peuvent etre null
  String photo; //peuvent etre null
  Consultation({
    required this.dateConsultation,

    required this.descMaladie,
    required this.nCINPatient,
    required this.numMatriculMedecin,
    required this.isSynced,
    required this.vocal,
    required this.photo,
  });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      dateConsultation: DateTime.parse(json['dateConsultation']),

      descMaladie: json['descMaladie'],
      nCINPatient: json['nCINPatient'],
      numMatriculMedecin: json['numMatriculMedecin'],
      isSynced: json['isSynced'],
      vocal: json['vocal'],
      photo: json['photo'],
    );
  }

  factory Consultation.fromMap(Map<String, dynamic> map) {
    return Consultation(
      dateConsultation: DateTime.parse(map['dateConsultation']),

      descMaladie: map['descMaladie'],
      nCINPatient: map['nCINPatient'],
      numMatriculMedecin: map['numMatriculMedecin'],
      isSynced: map['isSynced'],
      vocal: map['vocal'],
      photo: map['photo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idConsultation': idConsultation,
      'dateConsultation': dateConsultation.toIso8601String(),

      'descMaladie': descMaladie,
      'nCINPatient': nCINPatient,
      'numMatriculMedecin': numMatriculMedecin,
      'isSynced': isSynced,
      'vocal': vocal,
      'photo': photo,
    };
  }
}
