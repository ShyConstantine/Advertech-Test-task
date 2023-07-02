import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final VoidCallback validateForm;

  ContactForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.validateForm,
  });

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    widget.nameController.addListener(_updateFormValidity);
    widget.emailController.addListener(_updateFormValidity);
    widget.messageController.addListener(_updateFormValidity);
  }

  @override
  void dispose() {
    widget.nameController.removeListener(_updateFormValidity);
    widget.emailController.removeListener(_updateFormValidity);
    widget.messageController.removeListener(_updateFormValidity);
    super.dispose();
  }

  void _updateFormValidity() {
    setState(() {
      _isFormValid = widget.formKey.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: widget.nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: widget.emailController,
            decoration: InputDecoration(labelText: 'Email'),
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
          TextFormField(
            controller: widget.messageController,
            decoration: InputDecoration(labelText: 'Message'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a message';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _isFormValid ? widget.validateForm : null,
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}
