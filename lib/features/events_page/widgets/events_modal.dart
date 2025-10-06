import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventsModal extends StatefulWidget {
  const EventsModal({super.key});

  @override
  State<EventsModal> createState() => _EventsModalState();
}

class _EventsModalState extends State<EventsModal> {
  DateTime lastDate = DateTime(2099);
  String textFieldValue = "";

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2026, 10, 5),
      firstDate: DateTime(2025),
      lastDate: DateTime(2099),
    );

    setState(() {
      if (pickedDate != null) {
        lastDate = pickedDate;
      }
    });
  }

  void _ontextFieldChange(String value) {
    textFieldValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            onChanged: _ontextFieldChange,
            decoration: InputDecoration(label: Text("Event name")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: _selectDate,
                  child: const Text('Select Last Active Date'),
                ),
                Text('${lastDate.day}/${lastDate.month}/${lastDate.year}'),
              ],
            ),
          ),
          //          Spacer(),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: FilledButton(
              onPressed: () async => _saveEvent(textFieldValue, lastDate),
              child: Text("Save event"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveEvent(String name, DateTime lastDate) async {
    var db = FirebaseFirestore.instance;

    final event = <String, dynamic>{"name": name, "lastDate": lastDate};

    db
        .collection("events")
        .add(event)
        .then((doc) => {print('Am adaugat documentul ${doc.id}')});

    Navigator.pop(context);
  }
}
