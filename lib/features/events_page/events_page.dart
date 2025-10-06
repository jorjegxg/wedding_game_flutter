import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedding_game_flutter/features/events_page/event.dart';
import 'package:wedding_game_flutter/features/events_page/widgets/events_modal.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  Future<List<Event>> _getEvents() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("events")
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
      appBar: AppBar(title: Text("Events"), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => EventsModal(),
          );
        },
        label: Text("Add event"),
        icon: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => _getEvents(),
        child: FutureBuilder<List<Event>>(
          future: _getEvents(),
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
