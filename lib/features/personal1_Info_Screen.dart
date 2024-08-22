import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wdipl_interview_app/features/edu.dart' as edu;

import '../model/getsourcemodel.dart';
import '../model/source_drop.dart';
import '../shared/api/base_manager.dart';
import '../shared/api/repos/userdet_api.dart';

void main() {
  runApp(Form1Page());
}

// Main form page with state management
class Form1Page extends StatefulWidget {
  const Form1Page({super.key});

  @override
  State<Form1Page> createState() => _Form1PageState();
}

class _Form1PageState extends State<Form1Page> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation

  // Controllers for each input field
  final TextEditingController _nameController = TextEditingController();
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

  // Gender and Source selections
  String? _selectedGender;
  String? _selectedSource;
  List<Source> _sources = [];
  // int? _selectedSourceId;

  RxBool isLoading = true.obs;

  @override
  void initState() {
    super.initState();
    _getSource().then(
      (value) {},
    ); // Fetch source data when initializing the form
  }

  @override
  void dispose() {
    // Dispose of all controllers to prevent memory leaks
    _nameController.dispose();
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

  // Fetch the available sources for the dropdown menu
  Future<void> _getSource() async {
    try {
      final response = await PersonalInfoAPIServices().getSourceapi();

      if (response.status == ResponseStatus.SUCCESS && response.data != null) {
        final getSourceModel = Autogenerated.fromJson(response.data);
        final List<Source> sources = [];

        if (getSourceModel.data != null) {
          for (var item in getSourceModel.data!) {
            sources
                .add(Source(id: item.id!, title: item.principalSourceTitle!));
          }
        }

        log(sources.length.toString());

        setState(() {
          _sources = sources;
        });
        isLoading.value = false;
        _showSnackBar('Sources fetched successfully!', Colors.green);
      } else {
        isLoading.value = false;
        _handleError("Failed to fetch sources: ${response.message}");
      }
    } catch (e) {
      isLoading.value = false;
      _handleError("An error occurred: ${e.toString()}");
    }
  }

  // Handle form submission
  void _submitForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        Map<String, dynamic> formData = {
          "name": _nameController.text,
          "source": "2", // Static value, update if dynamic selection needed
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

        ResponseData response =
            await PersonalInfoAPIServices().sendPersonalDetails(formData);

        if (response.status == ResponseStatus.SUCCESS) {
          String token = response.data['data']['token'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("auth_token", token);

          _showSnackBar('Form submitted successfully!', Colors.green);

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => edu.DropdownPage(),
          ));
        } else {
          _showSnackBar('Failed to submit form. Please try again.', Colors.red);
        }
      }
    } catch (e) {
      _showSnackBar('An error occurred: ${e.toString()}', Colors.red);
    }
  }

  // Display a SnackBar for success or error messages
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  // Handle errors by displaying a SnackBar with an error message
  void _handleError(String errorMessage) {
    _showSnackBar(errorMessage, Colors.red);
  }

  // Select and format the date
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

  // Validate required fields
  String? _validateRequiredField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // Validate email format
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Validate phone number format
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final phoneRegex = RegExp(r'^[0-9]+$');
    if (!phoneRegex.hasMatch(value) || value.length != 10) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF134B70),
          title:
              Text('Personal Questions', style: TextStyle(color: Colors.white)),
        ),
        body: Obx(
          () => isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
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
                          _buildDropdownField(
                            label: 'Source *',
                            value: _selectedSource,
                            items:
                                _sources.map((source) => source.title).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedSource = value;
                              });
                            },
                            validator: (value) =>
                                value == null ? 'This field is required' : null,
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
                            validator: (value) =>
                                value == null ? 'This field is required' : null,
                          ),
                          _buildTextField(
                            label: 'Contact No. *',
                            icon: Icons.phone,
                            controller: _contactController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
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
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
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
      ),
    );
  }

  // Section title widget
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

  // Text field widget with validation and customization
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

  // Dropdown field widget with validation and customization
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

  // Submit button widget
  Widget _buildSubmitButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
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
