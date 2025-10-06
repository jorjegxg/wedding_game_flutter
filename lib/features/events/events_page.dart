import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedding_game_flutter/features/events/event.dart';
import 'package:wedding_game_flutter/features/events/widgets/events_modal.dart';
import 'package:wedding_game_flutter/features/mission/mission_page.dart';

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
              return Center(child: Text("Loading..."));
            }

            return ListView.builder(
              itemCount: asyncSnapshot.data!.length,
              itemBuilder: (context, index) {
                final event = asyncSnapshot.data![index];
                return Card(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      print("Apasat");
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => MissionPage(eventId: event.id),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(children: [Flexible(child: Text(event.name))]),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
