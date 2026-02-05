import 'package:flutter/material.dart';
import 'acceuil_login/acceuil/acceuil.dart';
//import 'acceuil_login/login/Login.dart';
//import 'acceuil_login/inscription/Inscription.dart';
//import 'patient_consultation/PatientConsultation.dart';
//import 'feedback_doctor/FeedBackDoctor.dart';
//import 'setting_AC/SettingAC.dart';
//import 'Demande_Special/DemandeSpecial.dart';
import 'acceuil_login/mdp_forget/ForgetMdp.dart';
import 'acceuil_login/mdp_forget/VerificationCode.dart';
import 'acceuil_login/mdp_forget/NewMdp.dart';
import 'navbar/NavBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Acceuil());
  }
}
