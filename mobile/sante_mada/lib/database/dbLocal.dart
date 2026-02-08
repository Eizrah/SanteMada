import 'package:sante_mada/feedback_doctor/FeedBackDoctor.dart';
import 'package:sante_mada/models/Prescription.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sante_mada/models/AgentCommunautaire.dart';
import 'package:sante_mada/models/Consultation.dart';
import 'package:sante_mada/models/Demande.dart';
import 'package:sante_mada/models/Medicament.dart';
import 'package:sante_mada/models/Possession.dart';
import 'package:sante_mada/models/Patient.dart';
import 'package:sante_mada/models/Medecin.dart';
import 'package:path/path.dart';

class Dblocal {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initialisation();
    return _database!;
  }

  static Future<Database> _initialisation() async {
    return openDatabase(
      join(await getDatabasesPath(), 'santeMada.db'),
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE AgentCommunautaire(
nAgent varchar(50) PRIMARY KEY,
lieuTravail varchar(50),
password varchar(50),
isSynced int,
nCIN varchar(50),
nomComplet varchar(50),
age int,
dateNaissance varchar(50),
lieuNaissance varchar(50),
adressLocal varchar(50),
photo varchar(50),
sexe varchar(50)
)
''');
        await db.execute('''
CREATE TABLE Consultation(
idConsultation varchar(50) PRIMARY KEY,
dateConsultation varchar(50),
prescription varchar(50),
descMaladie varchar(50),
nCINPatient varchar(50),
numMatriculMedecin varchar(50),
isSynced int,
foreign key (nCINPatient) references Patient(nCIN),
foreign key (numMatriculMedecin) references Medecin(numMatriculMedecin)
)
''');
        await db.execute('''
CREATE TABLE Demande(
idDemande varchar(50) PRIMARY KEY,
idAgentCommunautaire varchar(50),
idMedecin varchar(50),
idMedon varchar(50),
dateDemande varchar(50),
description varchar(50),
statut varchar(50),
isSynced int,
foreign key (idMedecin) references Medecin(numMatriculMedecin),
foreign key (idAgentCommunautaire) references AgentCommunautaire(nAgent),
foreign key (idMedon) references Medicament(idMedicament)
)
''');
        //medicament
        await db.execute('''
CREATE TABLE Medicament(
idMedicament varchar(50) PRIMARY KEY,
nom varchar(50)
)
''');
        //Patient
        await db.execute('''
CREATE TABLE Patient(
nCIN varchar(50) PRIMARY KEY,
nomComplet varchar(50),
age int,
dateNaissance varchar(50),
lieuNaissance varchar(50),
adressLocal varchar(50),
photo varchar(50),
sexe varchar(50),
antecedentMaladie varchar(50),
maladieHereditaire varchar(50),
poids float,
taille int,
numeroAgent varchar(50),
foreign key (numeroAgent) references AgentCommunautaire(nAgent)
)
''');
        //prescription
        await db.execute('''
CREATE TABLE Prescription(
idPrescription varchar(50) PRIMARY KEY,
idAgentCommunautaire varchar(50),
idMedecin varchar(50),
idPatient varchar(50),
datePrescription varchar(50),
descPrescription varchar(50),
foreign key (idMedecin) references Medecin(numMatriculMedecin),
foreign key (idAgentCommunautaire) references AgentCommunautaire(nAgent),
foreign key (idPatient) references Patient(nCIN)
)
''');
        //Possession
        await db.execute('''
CREATE TABLE Possession(
idPossession varchar(50) PRIMARY KEY,
idPrescription varchar(50),
idMedicament varchar(50),
quantite int,
foreign key (idPrescription) references Prescription(idPrescription),
foreign key (idMedicament) references Medicament(idMedicament)
)
''');
        //medecin
        await db.execute('''
CREATE TABLE Medecin(
numMatriculMedecin varchar(50) PRIMARY KEY, 
lieuTravail varchar(50),
type varchar(50),
nCIN varchar(50),
nomComplet varchar(50),
age int,
dateNaissance varchar(50),
lieuNaissance varchar(50),
adressLocal varchar(50),
photo varchar(50),
sexe varchar(50)
)
''');
      },
      version: 1,
    );
  }

  //ajout d'un AC
  static Future<void> insertAgentCommunautaire(
    AgentCommunautaire agentCommunautaire,
  ) async {
    final db = await database;
    await db.insert('AgentCommunautaire', agentCommunautaire.toMap());
  }

  //ajout d'un patient
  static Future<void> insertPatient(Patient patient) async {
    final db = await database;
    await db.insert('Patient', patient.toMap());
  }

  //MAJ d'un patient
  static Future<void> MajPatient(Patient patient) async {
    final db = await database;
    await db.update(
      'Patient',
      patient.toMap(),
      where: 'nCIN = ?',
      whereArgs: [patient.nCIN],
    );
  }

  //suppression d'un patient
  static Future<void> supprimerPatient(String nCIN) async {
    final db = await database;
    await db.delete('Patient', where: 'nCIN = ?', whereArgs: [nCIN]);
  }

  //recuperation d'un patient
  static Future<Patient?> getPatient(String nCIN) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Patient',
      where: 'nCIN = ?',
      whereArgs: [nCIN],
    );
    if (maps.isEmpty) {
      return null;
    }
    return Patient.fromMap(maps.first);
  }

  //recuperation de tous les patients au cas où c'est necessaire
  static Future<List<Patient>> getAllPatients() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Patient');
    return maps.map((e) => Patient.fromMap(e)).toList();
  }

  //ajout d'une consultation
  static Future<void> insertConsultation(Consultation consultation) async {
    final db = await database;
    await db.insert('Consultation', consultation.toMap());
  }

  //ajout d'une presciprion
  static Future<void> insertPrescription(Prescription prescription) async {
    final db = await database;
    await db.insert('Prescription', prescription.toMap());
  }

  //ajout d'une demande
  static Future<void> insertDemande(Demande demande) async {
    final db = await database;
    await db.insert('Demande', demande.toMap());
  }

  //login
  static Future<AgentCommunautaire?> login(String nAgent, String mdp) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'AgentCommunautaire',
      where: 'nAgent = ? AND password = ?',
      whereArgs: [nAgent, mdp],
    );
    if (maps.isNotEmpty) {
      return AgentCommunautaire.fromMap(maps.first);
    }
    return null;
  }

  //recuperation des infos de "un AC"

  static Future<AgentCommunautaire?> getAgentCommunautaire(
    String nAgent,
  ) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'AgentCommunautaire',
      where: 'nAgent = ?',
      whereArgs: [nAgent],
    );
    if (maps.isEmpty) {
      return null;
    }
    return AgentCommunautaire.fromMap(maps.first);
  }

  //recuperer tout les prescription
  static Future<List<Prescription>> getAllPrescription() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Prescription');
    return maps.map((e) => Prescription.fromMap(e)).toList();
  }

  static Future <bool> acExist(String nAgent) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'AgentCommunautaire',
      where: 'nAgent = ?',
      whereArgs: [nAgent],
    );
    if (maps.isEmpty) {
      return false;
    }
    return true;
  }

  //MAJ password
  static Future<void> MajPassword(String nAgent, String mdp) async {
    final db = await database;
    await db.update(
      'AgentCommunautaire',
      {'password': mdp},
      where: 'nAgent = ?',
      whereArgs: [nAgent],
    );
  }
}
