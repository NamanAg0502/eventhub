import 'package:eventhub/widgets/buttons/navigate_button.dart';
import 'package:eventhub/widgets/inputs/image_upload_input.dart';
import 'package:eventhub/widgets/inputs/text_input.dart';
import 'package:eventhub/widgets/inputs/text_input_textarea.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Profile Info',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff120D26),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              ImageUploadScreen(),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      CustomTextInput(
                          prefixIcon: CupertinoIcons.person_solid,
                          label: 'Full name',
                          controller: nameController),
                      const SizedBox(height: 20),
                      CustomTextInput(
                          prefixIcon: CupertinoIcons.mail_solid,
                          label: 'Email',
                          controller: emailController),
                      const SizedBox(height: 20),
                      CustomTextAreaInput(
                        prefixIcon: CupertinoIcons.line_horizontal_3_decrease,
                        label: 'About',
                        controller: aboutController,
                      ),
                    ],
                  )),
            ]),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: NavigateButton(
            label: 'Create Profile',
            icon: CupertinoIcons.arrow_right,
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ));
  }
}
