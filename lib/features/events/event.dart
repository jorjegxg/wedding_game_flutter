import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String name;
  final String link;
  final DateTime lastDate;

  Event({
    required this.link,
    required this.id,
    required this.name,
    required this.lastDate,
  });

  // 🔹 Convertire din Map (ex: venit din Firestore)
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map["id"],
      name: map['name'],

      // dacă e Timestamp din Firestore:
      lastDate: map['lastDate'] is DateTime
          ? map['lastDate']
          : (map['lastDate'] as Timestamp).toDate(),
      link: map['link'],
    );
  }

  // 🔹 Convertire în Map (pentru salvare în Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'link': link,
      'lastDate': lastDate, // Firestore acceptă direct DateTime
    };
  }
}
