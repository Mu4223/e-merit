import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event.dart';
import '/widgets/add_event.dart';
import '/widgets/event_detail.dart';

void main() {
  runApp(MeritApp());
}

class MeritApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      title: 'e-Merit',
      home: EventList(),
    );
  }
}

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List<Event> events = []; // Placeholder for events

  void _updateEvent(Event event, int index) async {
    final updatedEvent = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEvent(
          event: event,
          state: true,
        ),
      ),
    );

    if (updatedEvent != null && updatedEvent is Event) {
      setState(() {
        events[index] = updatedEvent;
      });
    }
  }

  void _deleteEvent(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this?'),
          actions: <Widget>[
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  events.removeAt(index); // Delete event from the list
                  Navigator.of(context).pop();
                });
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('e-Merit'),
        leading: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/3/3e/Logo_Rasmi_UMT.png',
        ),
        backgroundColor: const Color.fromARGB(255, 52, 0, 61),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purpleAccent,
              Colors.deepPurpleAccent,
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final formattedDate =
                DateFormat('dd/MM/yyyy').format(events[index].date);

            // Extract hours and minutes from TimeOfDay (24hrs format)
            final formattedTime =
                '${events[index].time.hour.toString().padLeft(2, '0')}:${events[index].time.minute.toString().padLeft(2, '0')}';

            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              elevation: 4.0,
              child: ListTile(
                title: Text(events[index].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Place: ${events[index].place}'),
                    Text('Date: $formattedDate'),
                    Text('Time: $formattedTime'),
                    Text('Merit: ${events[index].merit}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _updateEvent(events[index], index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteEvent(index);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetail(event: events[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEvent(
                      state: false,
                    )),
          );
          if (result != null && result is Event) {
            setState(() {
              events.add(result);
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 52, 0, 61),
      ),
    );
  }
}
