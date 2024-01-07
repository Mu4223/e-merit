import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import '../models/event.dart';

class EventDetail extends StatelessWidget {
  final Event event;

  EventDetail({required this.event});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(event.date);

    // Extract hours and minutes from TimeOfDay (24hrs format)
    final formattedTime =
        '${event.time.hour.toString().padLeft(2, '0')
        }:${event.time.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        backgroundColor: const Color.fromARGB(255, 52, 0, 61),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Title: ${event.title}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Description:',
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              '${event.description}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Place: ${event.place}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Date: $formattedDate',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Time: $formattedTime',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Merit: ${event.merit}',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
