import 'package:flutter/material.dart';

import 'package:wdipl_interview_app/features/techselect.dart';
import 'package:wdipl_interview_app/shared/api/api_endpoints.dart';
import 'package:wdipl_interview_app/shared/api/base_manager.dart';
import 'package:wdipl_interview_app/shared/api/network_api_services.dart';

class WorkExp extends StatefulWidget {
  const WorkExp({super.key});

  @override
  _WorkExpState createState() => _WorkExpState();
}

class _WorkExpState extends State<WorkExp> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, TextEditingController>> _controllersList = [];
  late AnimationController _controller;
  String _experienceLevel = 'Experienced';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _initializeController();
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controllers in _controllersList) {
      controllers.values.forEach((controller) => controller.dispose());
    }
    super.dispose();
  }

  void _initializeController() {
    _controllersList.add({
      'companyName': TextEditingController(),
      'role': TextEditingController(),
      'duration': TextEditingController(),
      'reason': TextEditingController(),
      'salary': TextEditingController(),
    });
  }

  void _addCompany() {
    if (_experienceLevel == 'Experienced' && _controllersList.length < 8) {
      setState(() {
        _controllersList.add({
          'companyName': TextEditingController(),
          'role': TextEditingController(),
          'duration': TextEditingController(),
          'reason': TextEditingController(),
          'salary': TextEditingController(),
        });
      });
    }
  }

  void _removeCompany(int index) {
    setState(() {
      _controllersList[index]
          .values
          .forEach((controller) => controller.dispose());
      _controllersList.removeAt(index);
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Collect the work experience data
      List<Map<String, String>> companyData =
          _controllersList.map((controllerMap) {
        return {
          'company_name': controllerMap['companyName']!.text,
          'role': controllerMap['role']!.text,
          'duration': controllerMap['duration']!.text,
          'reason_of_living': controllerMap['reason']!.text,
          'salary': controllerMap['salary']!.text,
        };
      }).toList();

      // Prepare the data to be sent to the API
      Map<String, dynamic> formData = {
        'work_experience': companyData,
      };

      try {
        // Send the data using the sendWorkExperience function
        ResponseData response = await sendWorkExperience(formData);

        if (response.status == ResponseStatus.SUCCESS) {
          _showSnackBar('Form submitted successfully!', Colors.green);
          _showConfirmationDialog(companyData);
        } else {
          _showSnackBar('Failed to submit form. Please try again.', Colors.red);
        }
      } catch (e) {
        _showSnackBar('An error occurred: ${e.toString()}', Colors.red);
      }
    }
  }

  Future<ResponseData> sendWorkExperience(Map<String, dynamic> data) async {
    String url = ApiEndpoints.sendweapi;
    final response = await NetworkApiService().post(url, data);
    return response;
  }

  // Helper method to show SnackBar messages
  void _showSnackBar(String message, MaterialColor color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Method to show a confirmation dialog with the work experience data
  void _showConfirmationDialog(List<Map<String, String>> companyData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Work Experience'),
          content: SingleChildScrollView(
            child: ListBody(
              children: companyData.map((company) {
                return Text(
                  'Company Name: ${company['companyName']}\n'
                  'Role: ${company['role']}\n'
                  'Duration: ${company['duration']}\n'
                  'Reason: ${company['reason']}\n'
                  'Salary: ${company['salary']}\n\n',
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TechnologySelectionPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFFfefffe),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF3e474d),
          title: Text(
            'Work Experience',
            style: TextStyle(color: Color(0xFFf0413f), fontSize: 30),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  'Are you experienced or a fresher?',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFf0413f)),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text(
                          'Experienced',
                          style:
                              TextStyle(fontSize: 28, color: Color(0xFFf0413f)),
                        ),
                        value: 'Experienced',
                        groupValue: _experienceLevel,
                        onChanged: (value) {
                          setState(() {
                            _experienceLevel = value!;
                            _controllersList.clear();
                            _initializeController();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text(
                          'Fresher',
                          style:
                              TextStyle(fontSize: 28, color: Color(0xFFf0413f)),
                        ),
                        value: 'Fresher',
                        groupValue: _experienceLevel,
                        onChanged: (value) {
                          setState(() {
                            _experienceLevel = value!;
                            _controllersList.clear();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                if (_experienceLevel == 'Experienced')
                  ..._controllersList.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, TextEditingController> controllers =
                        entry.value;

                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Company ${index + 1}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (index > 0)
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removeCompany(index),
                                  ),
                              ],
                            ),
                            _buildTextFormField(
                              label: 'Company Name',
                              controller: controllers['companyName']!,
                            ),
                            _buildTextFormField(
                              label: 'Role',
                              controller: controllers['role']!,
                            ),
                            _buildTextFormField(
                              label: 'Duration',
                              controller: controllers['duration']!,
                            ),
                            _buildTextFormField(
                              label: 'Reason for Leaving',
                              controller: controllers['reason']!,
                            ),
                            _buildTextFormField(
                              label: 'Salary',
                              controller: controllers['salary']!,
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                if (_experienceLevel == 'Experienced' &&
                    _controllersList.length < 8)
                  SizedBox(height: 80), // Add space for the FAB
              ],
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FadeTransition(
              opacity: _controller,
              child: Text(
                'Submit and Continue',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 90,
              width: 90,
              child: FloatingActionButton(
                onPressed: _submitForm,
                shape: CircleBorder(),
                backgroundColor: Color(0xFFf0413f),
                child: Icon(
                  Icons.arrow_forward,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // Helper method to create a TextFormField with common settings
  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
