import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerInput extends StatefulWidget {
  final String labelText;
  final DateTime initialDate;
  final Function(DateTime)? onDateSelected;

  const DatePickerInput({
    required this.labelText,
    required this.initialDate,
    this.onDateSelected,
  });

  @override
  _DatePickerInputState createState() => _DatePickerInputState();
}

class _DatePickerInputState extends State<DatePickerInput> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(
                0xff4A43EC), // Change the primary color of the date picker
            hintColor:
                Colors.blue, // Change the accent color of the date picker
            colorScheme: const ColorScheme.light(
              primary:
                  Color(0xff4A43EC), // Change the color of the selected date
              onPrimary:
                  Colors.white, // Change the text color of the selected date
            ),
            dialogBackgroundColor: Colors.white, // Change the background color
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        if (widget.onDateSelected != null) {
          widget.onDateSelected!(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Row(
          children: [
            const Icon(CupertinoIcons.calendar, color: Color(0xff807A7A)),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                dateFormat.format(_selectedDate),
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
