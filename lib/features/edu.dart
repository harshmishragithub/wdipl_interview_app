import 'package:flutter/material.dart';
import 'package:wdipl_interview_app/features/workexp.dart';

import 'package:wdipl_interview_app/shared/api/api_endpoints.dart';

import 'package:wdipl_interview_app/shared/api/base_manager.dart';
import 'package:wdipl_interview_app/shared/api/network_api_services.dart'; // Add this for JSON encoding

class DropdownPage extends StatefulWidget {
  @override
  _DropdownPageState createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  final List<String> years = [
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023'
  ];

  final List<String> graduationOptions = [
    'B.Sc ',
    'BCA',
    'B.Tech',
  ];

  final List<String> mastersOptions = [
    'MCA',
    'M.Sc ',
    'M.Tech',
    'ME',
  ];

  final List<String> streamOptions = [
    'CS',
    'IT',
    'Mechanical',
    'Architecture',
    'Civil',
    'Electronics',
    'Electrical'
  ];

  final List<String> diplomaStreamOptions = ['IT', 'Cs', 'Civil'];

  final Map<String, String?> selectedValues = {};
  String? selectedQualification;
  String? selectedGraduation;
  String? selectedMasters;
  String? selectedGraduationStream;
  String? selectedMastersStream;
  String? selectedDiplomaStream;
  String? selectedDiplomaStreamOption;
  String selected12thOrDiploma = '12th';
  bool isPursuingGraduation = false;
  bool isPursuingDiploma = false;
  bool isPursuingMasters = false;

  // Define controllers
  final TextEditingController tenthPercentageController =
      TextEditingController();
  final TextEditingController twelfthPercentageController =
      TextEditingController();
  final TextEditingController diplomaPercentageController =
      TextEditingController();
  final TextEditingController graduationPercentageController =
      TextEditingController();

  // New TextEditingController for other text fields, if any

  @override
  void dispose() {
    tenthPercentageController.dispose();
    twelfthPercentageController.dispose();
    diplomaPercentageController.dispose();
    graduationPercentageController.dispose();
    super.dispose();
  }

  void _validatePercentage(TextEditingController controller) {
    final text = controller.text;
    if (text.isNotEmpty) {
      final percentage = double.tryParse(text);
      if (percentage == null || percentage < 0 || percentage > 100) {
        controller.text = percentage != null && percentage > 100 ? '100' : '0';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid percentage (0-100).'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _submitData() async {
    try {
      // Build the education list
      final List<Map<String, dynamic>> education = [];

      // Add 10th (SSC) education details
      education.add({
        "level": "ssc",
        "course_name": "10th",
        "year_of_passing": selectedValues['tenthYear'],
        "percentage": double.tryParse(tenthPercentageController.text) ?? 0.0,
      });

      // Add 12th or Diploma (HSC) education details based on the selection
      if (selected12thOrDiploma == '12th') {
        education.add({
          "level": "hsc",
          "course_name": "12th",
          "year_of_passing": selectedValues['twelfthYear'],
          "percentage":
              double.tryParse(twelfthPercentageController.text) ?? 0.0,
        });
      } else if (selected12thOrDiploma == 'Diploma') {
        education.add({
          "level": "diploma",
          "course_name": "Diploma",
          "stream": selectedDiplomaStream,
          "year_of_passing": selectedValues['diplomaYear'],
          "percentage":
              double.tryParse(diplomaPercentageController.text) ?? 0.0,
        });
      }

      // Add Graduation education details if selected
      if (selectedQualification == 'Graduation') {
        education.add({
          "level": "graduate",
          "course_name": selectedGraduation,
          "stream": selectedGraduationStream,
          "year_of_passing": selectedValues['graduationYear'],
          "percentage":
              double.tryParse(graduationPercentageController.text) ?? 0.0,
        });
      }

      // Add Masters education details if selected
      if (selectedMasters != null) {
        education.add({
          "level": "postgraduate",
          "course_name": selectedMasters,
          "stream": selectedMastersStream,
          "year_of_passing": selectedValues['mastersYear'],
          "percentage": 0.0, // Add master's percentage if applicable
        });
      }

      // Final data structure
      final Map<String, dynamic> data = {
        "education": education,
      };

      // Send the data using the sendEducation function
      ResponseData response = await sendEducation(data);

      if (response.status == ResponseStatus.SUCCESS) {
        _showSnackBar('Education data submitted successfully!', Colors.green);
      } else {
        _showSnackBar(
            'Failed to submit education data. Please try again.', Colors.red);
      }
    } catch (e) {
      _showSnackBar('An error occurred: ${e.toString()}', Colors.red);
    }
  }

// This method sends the education data to the server
  Future<ResponseData> sendEducation(Map<String, dynamic> data) async {
    String url = ApiEndpoints.sendeduapi;
    final response = await NetworkApiService().post(url, data);
    return response;
  }

// Helper method to show SnackBar messages
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(seconds: 3),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      ),
      value: value,
      onChanged: onChanged,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildQuestionCard({
    required String question,
    required Widget child,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            child,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFFe7f1ee),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF3e474d),
          title: Text(
            'Educational Details',
            style: TextStyle(color: Color(0xFFf0413f), fontSize: 30),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildQuestionCard(
                question: '1. Your 10th qualification',
                child: Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        hint: 'Select passing year',
                        value: selectedValues['tenthYear'],
                        items: years,
                        onChanged: (value) {
                          setState(() {
                            selectedValues['tenthYear'] = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextField(
                        controller: tenthPercentageController,
                        decoration: InputDecoration(
                          labelText: 'Percentage',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (_) {
                          _validatePercentage(tenthPercentageController);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _buildQuestionCard(
                question: '2. Your higher secondary education',
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text('12th'),
                            value: '12th',
                            groupValue: selected12thOrDiploma,
                            onChanged: (value) {
                              setState(() {
                                selected12thOrDiploma = value!;
                                twelfthPercentageController.clear();
                                diplomaPercentageController.clear();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text('Diploma'),
                            value: 'Diploma',
                            groupValue: selected12thOrDiploma,
                            onChanged: (value) {
                              setState(() {
                                selected12thOrDiploma = value!;
                                twelfthPercentageController.clear();
                                diplomaPercentageController.clear();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    if (selected12thOrDiploma == '12th') ...[
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdown(
                              hint: 'Select passing year',
                              value: selectedValues['twelfthYear'],
                              items: years,
                              onChanged: (value) {
                                setState(() {
                                  selectedValues['twelfthYear'] = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: TextField(
                              controller: twelfthPercentageController,
                              decoration: InputDecoration(
                                labelText: 'Percentage',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (_) {
                                _validatePercentage(
                                    twelfthPercentageController);
                              },
                            ),
                          ),
                        ],
                      ),
                    ] else if (selected12thOrDiploma == 'Diploma') ...[
                      SizedBox(height: 16.0),
                      _buildDropdown(
                        hint: 'Select stream',
                        value: selectedDiplomaStream,
                        items: streamOptions,
                        onChanged: (value) {
                          setState(() {
                            selectedDiplomaStream = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: diplomaPercentageController,
                        decoration: InputDecoration(
                          labelText: 'Diploma Percentage',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (_) {
                          _validatePercentage(diplomaPercentageController);
                        },
                      ),
                      SizedBox(height: 16.0),
                      _buildDropdown(
                        hint: 'Select passing year',
                        value: selectedValues['diplomaYear'],
                        items: years,
                        onChanged: (value) {
                          setState(() {
                            selectedValues['diplomaYear'] = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Checkbox(
                            value: isPursuingDiploma,
                            onChanged: (bool? value) {
                              setState(() {
                                isPursuingDiploma = value!;
                              });
                            },
                          ),
                          Text('Pursuing the course'),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              _buildQuestionCard(
                question: '3. Your higher education',
                child: Column(
                  children: [
                    _buildDropdown(
                      hint: 'Select qualification',
                      value: selectedQualification,
                      items: ['Diploma', 'Graduation'],
                      onChanged: (value) {
                        setState(() {
                          selectedQualification = value;
                          selectedGraduation = null;
                          selectedMasters = null;
                          selectedGraduationStream = null;
                          selectedMastersStream = null;
                          selectedDiplomaStream = null;
                          selectedDiplomaStreamOption = null;
                          diplomaPercentageController.clear();
                          graduationPercentageController.clear();
                          isPursuingDiploma = false;
                          isPursuingGraduation = false;
                          isPursuingMasters = false;
                        });
                      },
                    ),
                    if (selectedQualification == 'Graduation') ...[
                      SizedBox(height: 16.0),
                      _buildDropdown(
                        hint: 'Select course',
                        value: selectedGraduation,
                        items: graduationOptions,
                        onChanged: (value) {
                          setState(() {
                            selectedGraduation = value;
                            selectedValues['graduationYear'] = null;
                          });
                        },
                      ),
                      if (selectedGraduation != null) ...[
                        SizedBox(height: 16.0),
                        _buildDropdown(
                          hint: 'Select stream',
                          value: selectedGraduationStream,
                          items: streamOptions,
                          onChanged: (value) {
                            setState(() {
                              selectedGraduationStream = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        _buildDropdown(
                          hint: 'Select passing year',
                          value: selectedValues['graduationYear'],
                          items: years,
                          onChanged: (value) {
                            setState(() {
                              selectedValues['graduationYear'] = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextField(
                          controller: graduationPercentageController,
                          decoration: InputDecoration(
                            labelText: 'Percentage',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (_) {
                            _validatePercentage(graduationPercentageController);
                          },
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Checkbox(
                              value: isPursuingGraduation,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    isPursuingGraduation = true;
                                    isPursuingMasters = false;
                                  } else {
                                    isPursuingGraduation = false;
                                  }
                                });
                              },
                            ),
                            Text('Pursuing the course'),
                          ],
                        ),
                      ],
                    ] else if (selectedQualification == 'Diploma') ...[
                      SizedBox(height: 16.0),
                      _buildDropdown(
                        hint: 'Select stream',
                        value: selectedDiplomaStream,
                        items: streamOptions,
                        onChanged: (value) {
                          setState(() {
                            selectedDiplomaStream = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      _buildDropdown(
                        hint: 'Select stream (1, 2, 3)',
                        value: selectedDiplomaStreamOption,
                        items: diplomaStreamOptions,
                        onChanged: (value) {
                          setState(() {
                            selectedDiplomaStreamOption = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: diplomaPercentageController,
                        decoration: InputDecoration(
                          labelText: 'Percentage',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (_) {
                          _validatePercentage(diplomaPercentageController);
                        },
                      ),
                      SizedBox(height: 16.0),
                      _buildDropdown(
                        hint: 'Select passing year',
                        value: selectedValues['diplomaYear'],
                        items: years,
                        onChanged: (value) {
                          setState(() {
                            selectedValues['diplomaYear'] = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Checkbox(
                            value: isPursuingDiploma,
                            onChanged: (bool? value) {
                              setState(() {
                                isPursuingDiploma = value!;
                              });
                            },
                          ),
                          Text('Pursuing the course'),
                        ],
                      ),
                    ],
                    if (selectedQualification == 'Graduation' &&
                        selectedGraduation != null &&
                        !isPursuingGraduation) ...[
                      SizedBox(height: 16.0),
                      _buildDropdown(
                        hint: 'Select masters course',
                        value: selectedMasters,
                        items: mastersOptions,
                        onChanged: (value) {
                          setState(() {
                            selectedMasters = value;
                            selectedValues['mastersYear'] = null;
                          });
                        },
                      ),
                      if (selectedMasters != null) ...[
                        SizedBox(height: 16.0),
                        _buildDropdown(
                          hint: 'Select stream',
                          value: selectedMastersStream,
                          items: streamOptions,
                          onChanged: (value) {
                            setState(() {
                              selectedMastersStream = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        _buildDropdown(
                          hint: 'Select passing year',
                          value: selectedValues['mastersYear'],
                          items: years,
                          onChanged: (value) {
                            setState(() {
                              selectedValues['mastersYear'] = value;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Checkbox(
                              value: isPursuingMasters,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    isPursuingMasters = true;
                                    isPursuingGraduation = false;
                                  } else {
                                    isPursuingMasters = false;
                                  }
                                });
                              },
                            ),
                            Text('Pursuing the course'),
                          ],
                        ),
                      ],
                    ],
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                          height: 90,
                          width: 90,
                          child: FloatingActionButton(
                            onPressed: () {
                              // Check if the required fields are filled based on the qualification selected
                              bool canProceed = false;
                              if (selectedQualification == 'Graduation' &&
                                  selectedGraduation != null) {
                                canProceed =
                                    selectedValues['graduationYear'] != null &&
                                        graduationPercentageController
                                            .text.isNotEmpty &&
                                        (selectedMasters == null ||
                                            (selectedMasters != null &&
                                                selectedValues['mastersYear'] !=
                                                    null));
                              } else if (selectedQualification == 'Diploma') {
                                canProceed =
                                    selectedValues['diplomaYear'] != null &&
                                        diplomaPercentageController
                                            .text.isNotEmpty &&
                                        selectedDiplomaStreamOption != null;
                              } else {
                                canProceed = selectedValues['tenthYear'] !=
                                        null &&
                                    tenthPercentageController.text.isNotEmpty &&
                                    ((selected12thOrDiploma == '12th' &&
                                            selectedValues['twelfthYear'] !=
                                                null &&
                                            twelfthPercentageController
                                                .text.isNotEmpty) ||
                                        (selected12thOrDiploma == 'Diploma' &&
                                            selectedValues['diplomaYear'] !=
                                                null &&
                                            diplomaPercentageController
                                                .text.isNotEmpty));
                              }

                              if (!canProceed) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Please fill all the required fields before proceeding.'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                                return;
                              }

                              // Submit data to API
                              _submitData();

                              // Show the confirmation dialog if all required fields are filled
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Confirm Details"),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                              "10th Passing Year: ${selectedValues['tenthYear']}"),
                                          Text(
                                              "10th Percentage: ${tenthPercentageController.text}"),
                                          if (selected12thOrDiploma ==
                                              '12th') ...[
                                            Text(
                                                "12th Passing Year: ${selectedValues['twelfthYear']}"),
                                            Text(
                                                "12th Percentage: ${twelfthPercentageController.text}"),
                                          ] else if (selected12thOrDiploma ==
                                              'Diploma') ...[
                                            Text(
                                                "Diploma Stream: $selectedDiplomaStream"),
                                            Text(
                                                "Diploma Passing Year: ${selectedValues['diplomaYear']}"),
                                            Text(
                                                "Diploma Percentage: ${diplomaPercentageController.text}"),
                                          ],
                                          Text(
                                              "Qualification: $selectedQualification"),
                                          if (selectedQualification ==
                                              'Graduation') ...[
                                            Text(
                                                "Graduation Course: $selectedGraduation"),
                                            Text(
                                                "Graduation Stream: $selectedGraduationStream"),
                                            Text(
                                                "Graduation Year: ${selectedValues['graduationYear']}"),
                                            Text(
                                                "Graduation Percentage: ${graduationPercentageController.text}"),
                                          ],
                                          if (selectedQualification ==
                                              'Diploma') ...[
                                            Text(
                                                "Diploma Stream: $selectedDiplomaStream"),
                                            Text(
                                                "Diploma Stream Option: $selectedDiplomaStreamOption"),
                                            Text(
                                                "Diploma Year: ${selectedValues['diplomaYear']}"),
                                            Text(
                                                "Diploma Percentage: ${diplomaPercentageController.text}"),
                                          ],
                                          if (selectedMasters != null) ...[
                                            Text(
                                                "Masters Course: $selectedMasters"),
                                            Text(
                                                "Masters Stream: $selectedMastersStream"),
                                            Text(
                                                "Masters Year: ${selectedValues['mastersYear']}"),
                                          ],
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Confirm'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WorkExp()),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(Icons.arrow_forward,
                                size: 50, color: Colors.white),
                            shape: CircleBorder(),
                            backgroundColor: Color(0xfff0413f),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
