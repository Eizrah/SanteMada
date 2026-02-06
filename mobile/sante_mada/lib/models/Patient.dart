import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:sante_mada/models/Personne.dart';

class Patient extends Personne {
  String antecedentMaladie;
  String maladieHereditaire;
  Float poids;
  Float taille; //en cm
  String numeroAgent;

  Patient({
    required this.antecedentMaladie,
    required this.maladieHereditaire,
    required this.poids,
    required this.taille,
    required this.numeroAgent,
    required super.nCIN,
    required super.nomComplet,
    required super.age,
    required super.dateNaissance,
    required super.lieuNaissance,
    required super.adressLocal,
    required super.photo,
    required super.sexe,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      antecedentMaladie: json['antecedentMaladie'],
      maladieHereditaire: json['maladieHereditaire'],
      poids: json['poids'],
      taille: json['taille'],
      numeroAgent: json['numeroAgent'],
      nCIN: json['nCIN'],
      nomComplet: json['nomComplet'],
      age: json['age'],
      dateNaissance: DateTime.parse(json['dateNaissance']),
      lieuNaissance: json['lieuNaissance'],
      adressLocal: json['adressLocal'],
      photo: json['photo'],
      sexe: json['sexe'],
    );
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      antecedentMaladie: map['antecedentMaladie'],
      maladieHereditaire: map['maladieHereditaire'],
      poids: map['poids'],
      taille: map['taille'],
      numeroAgent: map['numeroAgent'],
      nCIN: map['nCIN'],
      nomComplet: map['nomComplet'],
      age: int.parse(map['age'].toString()),
      dateNaissance: DateTime.parse(map['dateNaissance']),
      lieuNaissance: map['lieuNaissance'],
      adressLocal: map['adressLocal'],
      photo: map['photo'],
      sexe: map['sexe'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'antecedentMaladie': antecedentMaladie,
      'maladieHereditaire': maladieHereditaire,
      'poids': poids,
      'taille': taille,
      'numeroAgent': numeroAgent,
      'nCIN': nCIN,
      'nomComplet': nomComplet,
      'age': age,
      'dateNaissance': dateNaissance.toIso8601String(),
      'lieuNaissance': lieuNaissance,
      'adressLocal': adressLocal,
      'photo': photo,
      'sexe': sexe,
    };
  }
}
