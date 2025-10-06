import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedding_game_flutter/features/events/event.dart';
import 'package:wedding_game_flutter/features/events/widgets/events_modal.dart';
import 'package:wedding_game_flutter/features/mission/mission_modal.dart';

class MissionPage extends StatefulWidget {
  final String eventId;

  const MissionPage({super.key, required this.eventId});

  @override
  State<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  Future<List<Event>> _getMissions() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("missions")
        .get();
    final events = snapshot.docs
        .map((doc) => Event.fromMap(doc.data()))
        .toList();
    setState(() {});
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Missions"), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => MissionModal(),
          );
        },
        label: Text("Add mission"),
        icon: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => _getMissions(),
        child: FutureBuilder<List<Event>>(
          future: _getMissions(),
          builder: (context, asyncSnapshot) {
            if (!asyncSnapshot.hasData) {
              return Text("Loading...");
            }

            return ListView.builder(
              itemCount: asyncSnapshot.data!.length,
              itemBuilder: (context, index) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(children: [Text(asyncSnapshot.data![index].name)]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
