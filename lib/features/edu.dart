import 'package:flutter/material.dart';
import 'package:wdipl_interview_app/features/workexp.dart';

void main() {
  runApp(MaterialApp(
    home: DropdownPage(),
  ));
}

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

  final List<String> mastersOptions = ['MCA', 'M.Sc', 'M.Tech', 'ME'];

  final Map<String, String?> selectedValues = {};
  String? selectedQualification;
  String? selectedGraduation;
  String? selectedMasters;
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

  @override
  void dispose() {
    tenthPercentageController.dispose();
    twelfthPercentageController.dispose();
    diplomaPercentageController.dispose();
    graduationPercentageController.dispose();
    super.dispose();
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
                    ),
                  ),
                ],
              ),
            ),
            _buildQuestionCard(
              question: '2. Your 12th qualification',
              child: Row(
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
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
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
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Checkbox(
                            value: isPursuingGraduation,
                            onChanged: (bool? value) {
                              setState(() {
                                isPursuingGraduation = value!;
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
                      selectedGraduation != null) ...[
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
                      Row(
                        children: [
                          Checkbox(
                            value: isPursuingMasters,
                            onChanged: (bool? value) {
                              setState(() {
                                isPursuingMasters = value!;
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WorkExp()),
                          );
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
