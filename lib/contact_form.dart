import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final VoidCallback validateForm;
  final bool isLoading;
  final bool isError;
  final bool isSuccess;

  ContactForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.validateForm,
    required this.isLoading,
    required this.isError,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFFFFF5E9),
              child: Icon(
                Icons.lock_open,
                color: Color(0xFFE5BE90),
              ),
            ),
            title: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: GoogleFonts.montserrat(fontSize: 14),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFFFFF5E9),
              child: Icon(
                Icons.lock_open,
                color: Color(0xFFE5BE90),
              ),
            ),
            title: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: GoogleFonts.montserrat(fontSize: 14),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@') || !value.contains('.')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFFFFF5E9),
              child: Icon(
                Icons.lock_open,
                color: Color(0xFFE5BE90),
              ),
            ),
            title: TextFormField(
              controller: messageController,
              decoration: InputDecoration(
                labelText: 'Message',
                labelStyle: GoogleFonts.montserrat(fontSize: 14),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a message';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: isLoading ? null : validateForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF986D8E),
              minimumSize: Size(120, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            child: Text(
              isLoading ? 'Please wait' : 'Send',
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
