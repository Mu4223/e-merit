import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../models/event.dart';

class AddEvent extends StatefulWidget {
  final Event? event;
  final bool state;

  AddEvent({Key? key, this.event, required this.state}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey for the Form
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _meritController = TextEditingController();
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.event?.date ?? DateTime.now();
    _selectedTime = widget.event?.time ?? TimeOfDay.now();

    if (widget.state && widget.event != null) {
      _titleController.text = widget.event!.title;
      _descriptionController.text = widget.event!.description;
      _placeController.text = widget.event!.place;
      _meritController.text = widget.event!.merit.toString();
    }
  }

  String _formatTime(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _presentTimePicker() {
    showTimePicker(
      context: context,
      initialTime: _selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _selectedTime = pickedTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event != null ? 'Update Event' : 'Add Event'),
        backgroundColor: const Color.fromARGB(255, 52, 0, 61),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Event Title',
                      hintText: 'Enter event title',
                      hintStyle: TextStyle(fontSize: 18),
                      labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter event title';
                      }
                      return null;
                    }),
                SizedBox(height: 20),
                TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Event Description',
                      hintText: 'Enter event description',
                      hintStyle: TextStyle(fontSize: 18),
                      labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter event description';
                      }
                      return null;
                    }),
                SizedBox(height: 20),
                TextFormField(
                    controller: _placeController,
                    decoration: InputDecoration(
                      labelText: 'Event Place',
                      hintText: 'Enter event place',
                      hintStyle: TextStyle(fontSize: 18),
                      labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter event place';
                      }
                      return null;
                    }),
                SizedBox(height: 20),
                TextFormField(
                    controller: _meritController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Merit Amount',
                      hintText: 'Enter merit amount',
                      hintStyle: TextStyle(fontSize: 18),
                      labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter merit amount';
                      }
                      return null;
                    }),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          // ignore: unnecessary_null_comparison
                          _selectedDate == null
                              ? 'No Date Chosen'
                              : 'Event Date: ${DateFormat.yMd().format(_selectedDate)}',
                        ),
                      ),
                      TextButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          // ignore: unnecessary_null_comparison
                          _selectedTime == null
                              ? 'No Time Chosen'
                              : 'Event Time: ${_formatTime(_selectedTime)}',
                        ),
                      ),
                      TextButton(
                        onPressed: _presentTimePicker,
                        child: Text(
                          'Choose Time',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.event != null) {
                        widget.event!.title = _titleController.text;
                        widget.event!.description = _descriptionController.text;
                        widget.event!.place = _placeController.text;
                        widget.event!.date = _selectedDate;
                        widget.event!.time = _selectedTime;
                        widget.event!.merit = int.parse(_meritController.text);
                        Navigator.pop(context, widget.event);
                      } else {
                        Event newEvent = Event(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          place: _placeController.text,
                          date: _selectedDate,
                          time: _selectedTime,
                          merit: int.parse(_meritController.text),
                        );
                        Navigator.pop(context, newEvent);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(200, 40),
                  ),
                  child:
                      Text(widget.event != null ? 'Update Event' : 'Add Event'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
