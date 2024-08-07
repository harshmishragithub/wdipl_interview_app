import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../shared/api/base_manager.dart';
import '../shared/api/repos/userdet_api.dart';

void main() {
  runApp(Form1Page());
}

class Form1Page extends StatefulWidget {
  const Form1Page({super.key});

  @override
  State<Form1Page> createState() => _Form1PageState();
}

class _Form1PageState extends State<Form1Page> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each input field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _presentAddressController =
      TextEditingController();
  final TextEditingController _permanentAddressController =
      TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _fatherOccupationController =
      TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _motherOccupationController =
      TextEditingController();
  final TextEditingController _siblingsController = TextEditingController();

  String? _selectedGender;
  bool _isCompulsory = true; // State variable for the switch

  @override
  void dispose() {
    // Dispose of all controllers
    _nameController.dispose();
    _sourceController.dispose();
    _dateController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _presentAddressController.dispose();
    _permanentAddressController.dispose();
    _fatherNameController.dispose();
    _fatherOccupationController.dispose();
    _motherNameController.dispose();
    _motherOccupationController.dispose();
    _siblingsController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy/MM/dd').format(picked);
      });
    }
  }

  String? _validateRequiredField(String? value) {
    if (_isCompulsory && (value == null || value.isEmpty)) {
      return 'This field is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (_isCompulsory && (value == null || value.isEmpty)) {
      return 'This field is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value!)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (_isCompulsory && (value == null || value.isEmpty)) {
      return 'This field is required';
    }
    final phoneRegex = RegExp(r'^[0-9]+$');
    if (!phoneRegex.hasMatch(value!) || value.length != 10) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  void _submitForm() async {
    try {
      Map<String, dynamic> biometricLoginData = {
        "name": _nameController.text,
        "source": _sourceController.text,
        "date_of_birth": _dateController.text,
        "gender": _selectedGender,
        "contact_no": _contactController.text,
        "email_address": _emailController.text,
        "present_address": _presentAddressController.text,
        "permenent_address": _permanentAddressController.text,
        "father_name": _fatherNameController.text,
        "father_occupation": _fatherOccupationController.text,
        "mother_name": _motherNameController.text,
        "mother_occupation": _motherOccupationController.text,
        "no_of_siblings": _siblingsController.text,
      };

      ResponseData response = await PersonalInfoAPIServices()
          .sendPersonalDetails(biometricLoginData);
      if (response.status == ResponseStatus.SUCCESS) {
        print("SUCCESS");
      } else {
        print("FAILED");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF134B70),
          title: Text('Questions', style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [Color(0xFFE3F2FD), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Switch Button for Compulsory Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Compulsory Fields',
                        style: TextStyle(fontSize: 18),
                      ),
                      Switch(
                        value: _isCompulsory,
                        onChanged: (value) {
                          setState(() {
                            _isCompulsory = value;
                          });
                        },
                      ),
                    ],
                  ),
                  _sectionTitle('Personal Info'),
                  _buildTextField(
                    label: 'Name *',
                    icon: Icons.person,
                    controller: _nameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[a-zA-Z\s]+$'))
                    ],
                    validator: _validateRequiredField,
                  ),
                  _buildTextField(
                    label: 'Source *',
                    icon: Icons.source,
                    controller: _sourceController,
                    validator: _validateRequiredField,
                  ),
                  _buildTextField(
                    label: 'Date of Birth *',
                    icon: Icons.calendar_today,
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    validator: _validateRequiredField,
                  ),
                  _buildDropdownField(
                    label: 'Gender *',
                    value: _selectedGender,
                    items: ['Male', 'Female', 'Other'],
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    validator: (value) => _isCompulsory && value == null
                        ? 'This field is required'
                        : null,
                  ),
                  _buildTextField(
                    label: 'Contact No. *',
                    icon: Icons.phone,
                    controller: _contactController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: _validatePhoneNumber,
                  ),
                  _buildTextField(
                    label: 'Email ID *',
                    icon: Icons.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),
                  _buildTextField(
                    label: 'Present Address *',
                    icon: Icons.home,
                    controller: _presentAddressController,
                    maxLines: 2,
                    validator: _validateRequiredField,
                  ),
                  _buildTextField(
                    label: 'Permanent Address *',
                    icon: Icons.home,
                    controller: _permanentAddressController,
                    maxLines: 2,
                    validator: _validateRequiredField,
                  ),
                  _sectionTitle('Family Background'),
                  _buildTextField(
                    label: 'Father\'s Name *',
                    icon: Icons.person,
                    controller: _fatherNameController,
                    validator: _validateRequiredField,
                  ),
                  _buildTextField(
                    label: 'Father\'s Occupation *',
                    icon: Icons.work,
                    controller: _fatherOccupationController,
                    validator: _validateRequiredField,
                  ),
                  _buildTextField(
                    label: 'Mother\'s Name *',
                    icon: Icons.person,
                    controller: _motherNameController,
                    validator: _validateRequiredField,
                  ),
                  _buildTextField(
                    label: 'Mother\'s Occupation *',
                    icon: Icons.work,
                    controller: _motherOccupationController,
                    validator: _validateRequiredField,
                  ),
                  _buildTextField(
                    label: 'Number of Siblings *',
                    icon: Icons.people,
                    controller: _siblingsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: _validateRequiredField,
                  ),
                  SizedBox(height: 30),
                  _buildSubmitButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF134B70),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
    void Function()? onTap,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        readOnly: readOnly,
        onTap: onTap,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF134B70)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(Icons.arrow_drop_down, color: Color(0xFF134B70)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate() || !_isCompulsory) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) =>
            //           DropdownPage()), // replace with your destination page
            // );
            _submitForm();
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          backgroundColor: Color(0xFF134B70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(
          'Submit',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
