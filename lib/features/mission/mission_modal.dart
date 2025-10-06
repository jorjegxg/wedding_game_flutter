import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedding_game_flutter/features/mission/mission.dart';

class MissionModal extends StatefulWidget {
  final String eventId;
  const MissionModal({super.key, required this.eventId});

  @override
  State<MissionModal> createState() => _MissionModalState();
}

class _MissionModalState extends State<MissionModal> {
  String textFieldValue = "";

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
            autofocus: true,
            decoration: InputDecoration(label: Text("Event name")),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: FilledButton(
              onPressed: () async =>
                  _saveMission(eventId: widget.eventId, name: textFieldValue),
              child: Text("Save mission"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveMission({
    required String eventId,
    required String name,
  }) async {
    var db = FirebaseFirestore.instance;

    final mission = Mission(name: textFieldValue);

    db
        .collection("events")
        .doc(eventId)
        .collection("missions")
        .add(mission.toMap())
        .then((doc) => {print('Am adaugat documentul ${doc.id}')});

    Navigator.pop(context);
  }
}
