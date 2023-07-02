import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'api_service.dart';
import 'contact_form.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  bool _isError = false;
  bool _isSuccess = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      _sendDataToServer();
    }
  }

  Future<void> _sendDataToServer() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    final data = {
      'name': _nameController.text,
      'email': _emailController.text,
      'message': _messageController.text,
    };

    try {
      final response = await _apiService.sendDataToServer(data);

      if (response.statusCode == 201) {
        setState(() {
          _isLoading = false;
          _isSuccess = true;
        });
      } else {
        setState(() {
          _isLoading = false;
          _isError = true;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }

  void _handleClose() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Contact us',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 26),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: _handleClose,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ContactForm(
                formKey: _formKey,
                nameController: _nameController,
                emailController: _emailController,
                messageController: _messageController,
                validateForm: _validateForm,
                isLoading: _isLoading,
                isError: _isError,
                isSuccess: _isSuccess,
              ),
            ),
            SizedBox(height: 16.0),
            if (_isLoading)
              CircularProgressIndicator()
            else if (_isError)
              Text(
                'Error sending message. Please try again.',
                style: TextStyle(color: Colors.red),
              )
            else if (_isSuccess)
              Text(
                'Message sent successfully!',
                style: TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}
