import 'package:appwrite/appwrite.dart';
import 'package:eventhub/main.dart';
import 'package:eventhub/widgets/buttons/navigate_button.dart';
import 'package:eventhub/widgets/inputs/date_picker_input.dart';
import 'package:eventhub/widgets/inputs/image_upload_input.dart';
import 'package:eventhub/widgets/inputs/text_input.dart';
import 'package:eventhub/widgets/inputs/text_input_textarea.dart';
import 'package:eventhub/widgets/inputs/time_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final TextEditingController eventNameController = TextEditingController();
  DateTime? eventDateController;
  final TextEditingController eventTimeController = TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final client = AppwriteProvider.of(context)!.client;
    Databases database = Databases(client);

    print('eventDateController: $eventDateController');
    print('eventTimeController: $eventTimeController');
    print('eventLocationController: ${eventLocationController.text}');
    print('eventDescriptionController: ${eventDescriptionController.text}');
    print('eventNameController: ${eventNameController.text}');

    void createEvent() async {
      try {
        final response = await database.createDocument(
            databaseId: '646f118d206ca5a1a4c0',
            collectionId: '646f11d4db11af3fc21b',
            documentId: ID.unique(),
            data: {
              'event_image': 'https://picsum.photos/200/300',
              'event_title': eventNameController.text,
              'event_description': eventDescriptionController.text,
              'event_date': eventDateController,
              'event_time': eventTimeController.text,
              'event_location': eventLocationController.text,
            });
        print(
            'Document created successfully. Document ID: ${response.data['\$id']}');
      } catch (e) {
        print('Failed to create document: $e');
        print('eventDateController: $eventDateController');
        print('eventTimeController: $eventTimeController');
        print('eventLocationController: ${eventLocationController.text}');
        print('eventDescriptionController: ${eventDescriptionController.text}');
        print('eventNameController: ${eventNameController.text}');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event',
            style: TextStyle(color: Color(0xff120D26))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            CupertinoIcons.chevron_left,
            color: Color(0xff120D26),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            const ImageUploadScreen(),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextInput(
                      prefixIcon: CupertinoIcons.textformat,
                      label: 'Event Title',
                      controller: eventNameController),
                  const SizedBox(height: 20),
                  DatePickerInput(
                    labelText: 'Select Date',
                    initialDate: DateTime.now(),
                    onDateSelected: (DateTime selectedDate) {
                      // Do something with the selected date
                      eventDateController = selectedDate;
                      print('Selected Date: $selectedDate');
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTimeInput(
                    controller: eventTimeController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextInput(
                      prefixIcon: CupertinoIcons.location,
                      label: 'Event Location',
                      controller: eventLocationController),
                  const SizedBox(height: 20),
                  CustomTextAreaInput(
                      prefixIcon: CupertinoIcons.textformat,
                      label: 'Event Description',
                      lines: 5,
                      controller: eventDescriptionController),
                ],
              ),
            )
          ],
        )),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: NavigateButton(
            label: 'Create Event',
            icon: CupertinoIcons.add,
            onTap: createEvent),
      ),
    );
  }
}
