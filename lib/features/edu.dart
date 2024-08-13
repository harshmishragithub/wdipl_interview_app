import 'package:flutter/material.dart';
import 'package:wdipl_interview_app/features/workexp.dart';
import 'package:wdipl_interview_app/shared/api/base_manager.dart';
import 'package:wdipl_interview_app/shared/api/repos/userdet_api.dart';

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
    'B.Sc IT',
    'B.Sc CS',
    'BCA',
    'B.Tech'
  ];
  final List<String> mastersOptions = [
    'MCA',
    'M.Sc IT',
    'M.Tech',
    'ME',
    'M.Sc CS'
  ];

  final Map<String, String?> selectedValues = {};
  String? selectedQualification;
  String? selectedGraduation;
  String? selectedMasters;
  String selected12thOrDiploma = '12th';
  bool isPursuingGraduation = false;
  bool isPursuingDiploma = false;
  bool isPursuingMasters = false;

  final TextEditingController tenthPercentageController =
      TextEditingController();
  final TextEditingController twelfthPercentageController =
      TextEditingController();
  final TextEditingController diplomaPercentageController =
      TextEditingController();
  final TextEditingController graduationPercentageController =
      TextEditingController();
  final TextEditingController mastersPercentageController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    tenthPercentageController.dispose();
    twelfthPercentageController.dispose();
    diplomaPercentageController.dispose();
    graduationPercentageController.dispose();
    mastersPercentageController.dispose();
    super.dispose();
  }

  void _validatePercentage(TextEditingController controller) {
    final text = controller.text;
    if (text.isNotEmpty) {
      final percentage = double.tryParse(text);
      if (percentage == null || percentage < 0 || percentage > 100) {
        controller.text = percentage != null && percentage > 100 ? '100' : '0';
        _showSnackBar('Please enter a valid percentage (0-100).', Colors.red);
      }
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _handleSubmit() async {
    try {
      // Assuming you have a form key and validation logic
      if (_formKey.currentState!.validate()) {
        // Create the list of education details
        final List<Map<String, dynamic>> education = [];

        // SSC (10th) details
        education.add({
          "level": "ssc",
          "course_name": "10th",
          "year_of_passing": selectedValues['tenthYear'],
          "percentage": double.tryParse(tenthPercentageController.text) ?? 0,
        });

        // HSC (12th) or Diploma details
        if (selected12thOrDiploma == '12th') {
          education.add({
            "level": "hsc",
            "course_name": "12th",
            "year_of_passing": selectedValues['twelfthYear'],
            "percentage":
                double.tryParse(twelfthPercentageController.text) ?? 0,
          });
        } else if (selected12thOrDiploma == 'Diploma') {
          education.add({
            "level": "diploma",
            "course_name": "Diploma",
            "year_of_passing": selectedValues['diplomaYear'],
            "percentage":
                double.tryParse(diplomaPercentageController.text) ?? 0,
          });
        }

        // Graduation details
        if (selectedQualification == 'Graduation') {
          final graduationDetails = {
            "level": "graduate",
            "course_name": selectedGraduation,
            "year_of_passing": selectedValues['graduationYear'],
            "percentage":
                double.tryParse(graduationPercentageController.text) ?? 0,
          };

          // Add stream if available
          if (selectedGraduation != null &&
              selectedGraduation!.toLowerCase().contains('btech')) {
            graduationDetails["stream"] =
                "electronics"; // Example stream, replace as necessary
          }

          education.add(graduationDetails);

          // Masters details if applicable
          if (!isPursuingGraduation) {
            education.add({
              "level": "masters",
              "course_name": selectedMasters,
              "year_of_passing": selectedValues['mastersYear'],
              "percentage":
                  double.tryParse(mastersPercentageController.text) ?? 0,
            });
          }
        }

        // Prepare the complete data structure
        final Map<String, dynamic> educationalDetails = {
          "education": education,
        };

        // Debugging
        print(educationalDetails);

        // API call (replace with your actual API service)
        ResponseData response =
            await PersonalInfoAPIServices().sendEducation(educationalDetails);

        if (response.status == ResponseStatus.SUCCESS) {
          _showSnackBar(
              'Educational details submitted successfully!', Colors.green);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WorkExp()),
          );
        } else {
          _showSnackBar(
              'Failed to submit educational details. Please try again.',
              Colors.red);
        }
      }
    } catch (e) {
      _showSnackBar('An error occurred: ${e.toString()}', Colors.red);
    }
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
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF508C9B),
        title: Text('Educational Details'),
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
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                              _validatePercentage(twelfthPercentageController);
                            },
                          ),
                        ),
                      ],
                    ),
                  ] else if (selected12thOrDiploma == 'Diploma') ...[
                    TextField(
                      controller: diplomaPercentageController,
                      decoration: InputDecoration(
                        labelText: 'Diploma Percentage',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                        diplomaPercentageController.clear();
                        graduationPercentageController.clear();
                        mastersPercentageController.clear();
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
                    TextField(
                      controller: diplomaPercentageController,
                      decoration: InputDecoration(
                        labelText: 'Percentage',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                      TextField(
                        controller: mastersPercentageController,
                        decoration: InputDecoration(
                          labelText: 'Percentage',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (_) {
                          _validatePercentage(mastersPercentageController);
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
                          // Validate and proceed
                          _handleSubmit();
                        },
                        child: Icon(Icons.arrow_forward,
                            size: 50, color: Colors.white),
                        shape: CircleBorder(),
                        backgroundColor: Color(0xFF134B70),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
