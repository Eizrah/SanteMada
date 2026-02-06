//classe d'association entre AgentCommunautaire et Medecin
import 'package:uuid/uuid.dart';

class Demande {
  String idDemande = const Uuid().v4();
  String idAgentCommunautaire;
  String idMedecin;
  DateTime dateDemande;
  String description;
  String statut;
  bool isSynced;
  String idMedoc;

  Demande({
    required this.idAgentCommunautaire,
    required this.idMedecin,
    required this.dateDemande,
    required this.description,
    required this.statut,
    required this.isSynced,
    required this.idMedoc,
  });

  factory Demande.fromJson(Map<String, dynamic> json) {
    return Demande(
      idAgentCommunautaire: json['idAgentCommunautaire'],
      idMedecin: json['idMedecin'],
      dateDemande: DateTime.parse(json['dateDemande']),
      description: json['description'],
      statut: json['statut'],
      isSynced: json['isSynced'],
      idMedoc: json['idMedoc'],
    );
  }

  factory Demande.fromMap(Map<String, dynamic> map) {
    return Demande(
      idAgentCommunautaire: map['idAgentCommunautaire'],
      idMedecin: map['idMedecin'],
      dateDemande: DateTime.parse(map['dateDemande']),
      description: map['description'],
      statut: map['statut'],
      isSynced: map['isSynced'],
      idMedoc: map['idMedoc']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idDemande': idDemande,
      'idAgentCommunautaire': idAgentCommunautaire,
      'idMedecin': idMedecin,
      'dateDemande': dateDemande.toIso8601String(),
      'description': description,
      'statut': statut,
      'isSynced': isSynced,
      'idMedoc': idMedoc,
    };
  }
}
