abstract class Personne {
  String nCIN;
  String nomComplet;
  int age;
  DateTime dateNaissance;
  String lieuNaissance;
  String adressLocal;
  String photo;
  String sexe;

  Personne({
    required this.nCIN,
    required this.nomComplet,
    required this.age,
    required this.dateNaissance,
    required this.lieuNaissance,
    required this.adressLocal,
    required this.photo,
    required this.sexe,
  });

  Map<String, dynamic> toMap() {
    return {
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
