import 'package:flutter/material.dart';

class DoctorInscriptionTest extends StatefulWidget {
  const DoctorInscriptionTest({Key? key}) : super(key: key);

  @override
  State<DoctorInscriptionTest> createState() => _DoctorInscriptionTestState();
}

class _DoctorInscriptionTestState extends State<DoctorInscriptionTest> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Inscription',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: const Center(
        child: Text('Doctor Incription Test'),
      ),
    );
  }
}