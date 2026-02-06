import 'package:sante_mada/models/Personne.dart';

class AgentCommunautaire extends Personne {

  String nAgent;
  String lieuTravail;
  String password;
  int isSynced; // 0: Non synchro avec laBD Mysql, 1: Synchro avec la BD Mysql

  AgentCommunautaire({
    
    required this.nAgent,
    required this.lieuTravail,
    required this.password,
    this.isSynced = 0,
    required super.nCIN,
    required super.nomComplet,
    required super.age,
    required super.dateNaissance,
    required super.lieuNaissance,
    required super.adressLocal,
    required super.photo,
    required super.sexe,
  });

  factory AgentCommunautaire.fromJson(Map<String, dynamic> json) {
    return AgentCommunautaire(
    
      nAgent: json['nAgent'],
      lieuTravail: json['lieuTravail'],
      password: json['password'],
      isSynced: json['isSynced'] ?? 0,
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

  factory AgentCommunautaire.fromMap(Map<String, dynamic> map) {
    return AgentCommunautaire(
  
      nAgent: map['nAgent'],
      lieuTravail: map['lieuTravail'],
      password: map['password'],
      isSynced: map['isSynced'] ?? 0,
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
      'nAgent': nAgent,
      'lieuTravail': lieuTravail,
      'password': password,
      'isSynced': isSynced,
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

  void envoyerDemande() {
    print("Demande envoyée");
  }
}
