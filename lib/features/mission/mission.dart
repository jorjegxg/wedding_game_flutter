class Mission {
  final String name;

  Mission({required this.name});

  // 🔹 Convertire din Map (ex: venit din Firestore)
  factory Mission.fromMap(Map<String, dynamic> map) {
    return Mission(name: map['name']);
  }

  // 🔹 Convertire în Map (pentru salvare în Firestore)
  Map<String, dynamic> toMap() {
    return {'name': name};
  }
}
