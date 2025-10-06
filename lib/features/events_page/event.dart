import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String name;
  final DateTime lastDate;

  Event({required this.name, required this.lastDate});

  // 🔹 Convertire din Map (ex: venit din Firestore)
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      name: map['name'],

      // dacă e Timestamp din Firestore:
      lastDate: map['lastDate'] is DateTime
          ? map['lastDate']
          : (map['lastDate'] as Timestamp).toDate(),
    );
  }

  // 🔹 Convertire în Map (pentru salvare în Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastDate': lastDate, // Firestore acceptă direct DateTime
    };
  }
}
