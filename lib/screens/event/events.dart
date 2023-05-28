import 'package:eventhub/models/event_model.dart';
import 'package:eventhub/widgets/cards/event_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Events',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            ),
          )),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                EventCard(
                  event: event,
                ),
                const SizedBox(height: 20),
                EventCard(
                  event: event,
                ),
                const SizedBox(height: 20),
                EventCard(
                  event: event,
                ),
                const SizedBox(height: 20),
                EventCard(
                  event: event,
                ),
                const SizedBox(height: 20),
                EventCard(
                  event: event,
                ),
                const SizedBox(height: 20),
                EventCard(
                  event: event,
                ),
              ],
            ),
          )),
    );
  }

  Event event = Event(
    id: '1',
    title: 'Sample Event',
    dateTime: DateTime.now(),
    location: 'Sample Location',
    imageUrl: 'https://example.com/sample-image.jpg',
  );
}
