import 'package:flutter/material.dart';
//import 'acceuil_login/acceuil/acceuil.dart';
//import 'acceuil_login/login/Login.dart';
//import 'acceuil_login/inscription/Inscription.dart';
//import 'patient_consultation/PatientConsultation.dart';
//import 'feedback_doctor/FeedBackDoctor.dart';
//import 'setting_AC/SettingAC.dart';
import 'Demande_Special/DemandeSpecial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DemandeSpecial());
  }
}
