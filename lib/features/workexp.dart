import 'package:flutter/material.dart';
import 'package:wdipl_interview_app/features/techselect.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Experience Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WorkExp(),
    );
  }
}

class WorkExp extends StatefulWidget {
  @override
  _WorkExpState createState() => _WorkExpState();
}

class _WorkExpState extends State<WorkExp> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, String>> companyList = [
    {'companyName': '', 'role': '', 'duration': '', 'reason': '', 'salary': ''}
  ];
  bool _isBlinking = true;
  late AnimationController _controller;
  String _experienceLevel = 'Experienced';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addCompany() {
    if (_experienceLevel == 'Experienced' && companyList.length < 8) {
      setState(() {
        companyList.add({
          'companyName': '',
          'role': '',
          'duration': '',
          'reason': '',
          'salary': ''
        });
      });
    }
  }

  void _removeCompany(int index) {
    setState(() {
      companyList.removeAt(index);
    });
  }

  void _submitForm() {
    _formKey.currentState!.save();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Work Experience'),
          content: SingleChildScrollView(
            child: ListBody(
              children: companyList.map((company) {
                return Text(
                  'Company Name: ${company['companyName']}\nRole: ${company['role']}\nDuration: ${company['duration']}\nReason: ${company['reason']}\nSalary: ${company['salary']}\n\n',
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
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xff508C9B),
        title: Text('Work Experience'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Are you experienced or a fresher?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text(
                        'Experienced',
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      ),
                      value: 'Experienced',
                      groupValue: _experienceLevel,
                      onChanged: (value) {
                        setState(() {
                          _experienceLevel = value!;
                          companyList.clear();
                          companyList.add({
                            'companyName': '',
                            'role': '',
                            'duration': '',
                            'reason': '',
                            'salary': ''
                          });
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text(
                        'Fresher',
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      ),
                      value: 'Fresher',
                      groupValue: _experienceLevel,
                      onChanged: (value) {
                        setState(() {
                          _experienceLevel = value!;
                          companyList.clear();
                          companyList.add({
                            'companyName': '',
                            'role': '',
                            'duration': '',
                            'reason': '',
                            'salary': ''
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
              if (_experienceLevel == 'Experienced')
                ...companyList.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> company = entry.value;

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
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Company Name'),
                            onSaved: (value) {
                              company['companyName'] = value ?? '';
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Role'),
                            onSaved: (value) {
                              company['role'] = value ?? '';
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a role';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Duration'),
                            onSaved: (value) {
                              company['duration'] = value ?? '';
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Reason for Leaving'),
                            onSaved: (value) {
                              company['reason'] = value ?? '';
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Salary'),
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              company['salary'] = value ?? '';
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              if (_experienceLevel == 'Experienced' && companyList.length < 7)
                SizedBox(height: 30),
              if (_experienceLevel == 'Experienced' && companyList.length < 8)
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xff508C9B),
                    ),
                    onPressed: _addCompany,
                    child: Text(
                      'Add Company',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              SizedBox(height: 80), // Add space for the FAB
            ],
          ),
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
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
            child: Icon(
              Icons.arrow_forward,
              size: 50,
              color: Colors.white,
            ),
            backgroundColor: Color(0xFF134B70),
          ),
        ),
        SizedBox(
          height: 100,
        )
      ]),
    );
  }
}
