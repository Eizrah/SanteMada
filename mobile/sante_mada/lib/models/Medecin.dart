import 'package:sante_mada/models/Personne.dart';

class Medecin extends Personne {
  String numMatricul;
  String LieuTravail;
  String type;

  Medecin({
    required this.numMatricul,
    required this.LieuTravail,
    required this.type,
    required super.nCIN,
    required super.nomComplet,
    required super.age,
    required super.dateNaissance,
    required super.lieuNaissance,
    required super.adressLocal,
    required super.photo,
    required super.sexe,
  });

  factory Medecin.fromJson(Map<String, dynamic> json) {
    return Medecin(
      numMatricul: json['numMatricul'],
      LieuTravail: json['LieuTravail'],
      type: json['type'],
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

  factory Medecin.fromMap(Map<String, dynamic> map) {
    return Medecin(
      numMatricul: map['numMatricul'],
      LieuTravail: map['LieuTravail'],
      type: map['type'],
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
      'numMatricul': numMatricul,
      'LieuTravail': LieuTravail,
      'type': type,
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