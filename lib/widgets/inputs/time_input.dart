import 'package:flutter/material.dart';

class CustomTimeInput extends StatefulWidget {
  final TextEditingController controller;
  const CustomTimeInput({Key? key, required this.controller}) : super(key: key);
  @override
  _CustomTimeInputState createState() => _CustomTimeInputState();
}

class _CustomTimeInputState extends State<CustomTimeInput> {
  String _selectedHour = '01';
  String _selectedMinute = '00';
  String _selectedPeriod = 'AM';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                // width: 240.0,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Row(children: [
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(12.0),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    value: _selectedHour,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedHour = newValue!;
                      });
                    },
                    items: List.generate(12, (index) {
                      String hour = (index + 1).toString().padLeft(2, '0');
                      return DropdownMenuItem<String>(
                        value: hour,
                        child: Text(hour),
                      );
                    }),
                  ),
                  const SizedBox(width: 8.0),
                  const Text('/',
                      style: TextStyle(color: Colors.grey, fontSize: 20.0)),
                  const SizedBox(width: 8.0),
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(12.0),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    value: _selectedMinute,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedMinute = newValue!;
                      });
                    },
                    items: List.generate(60, (index) {
                      String minute = index.toString().padLeft(2, '0');
                      return DropdownMenuItem<String>(
                        value: minute,
                        child: Text(minute),
                      );
                    }),
                  ),
                  const SizedBox(width: 8.0),
                  const Text('/',
                      style: TextStyle(color: Colors.grey, fontSize: 20.0)),
                  const SizedBox(width: 8.0),
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(12.0),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    value: _selectedPeriod,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedPeriod = newValue!;
                      });
                    },
                    items: ['AM', 'PM'].map((period) {
                      return DropdownMenuItem<String>(
                        value: period,
                        child: Text(period),
                      );
                    }).toList(),
                  )
                ])),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey,
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () {
                widget.controller.text =
                    '$_selectedHour:$_selectedMinute $_selectedPeriod';
                print('$_selectedHour:$_selectedMinute $_selectedPeriod');
              },
              child: const Text('Set Time',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff120D26))),
            ),
          ],
        ));
  }
}
