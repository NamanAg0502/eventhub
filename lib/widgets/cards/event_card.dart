import 'package:eventhub/models/event_model.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 255,
        width: MediaQuery.of(context).size.width * 0.6,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xff505588).withOpacity(0.06),
                spreadRadius: 0,
                blurRadius: 30,
                offset: const Offset(0, 8),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                // Add additional widgets or content here
              ),
            ),
          ],
        ));
  }
}
