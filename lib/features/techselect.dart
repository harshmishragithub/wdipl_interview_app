import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wdipl_interview_app/model/gettech.dart';
import 'package:wdipl_interview_app/model/techdrop.dart';
import 'package:wdipl_interview_app/shared/api/base_manager.dart';
import 'package:wdipl_interview_app/shared/api/repos/userdet_api.dart';

import 'package:wdipl_interview_app/testoverview/testov1.dart';

class TechnologySelectionPage extends StatefulWidget {
  const TechnologySelectionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TechnologySelectionPageState createState() =>
      _TechnologySelectionPageState();
}

class _TechnologySelectionPageState extends State<TechnologySelectionPage>
    with SingleTickerProviderStateMixin {
  List<String> _technologies = [
    'Laravel',
    'Flutter',
    'React Js',
    'Node Js',
    'Mern Stack',
    'hasbdj'
  ];
  final List<String> _experienceYears = [
    '0-1 years',
    '1-3 years',
    '3-5 years',
    '5+ years'
  ];

  String? _selectedTechnology;
  String? _selectedExperience;
  late AnimationController _controller;

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

  void _handleError(String errorMessage) {
    _showSnackBar(errorMessage, Colors.red);
  }

  Future<void> _getTechnology(dynamic isLoading) async {
    try {
      final response = await PersonalInfoAPIServices().getTechnology();

      if (response.status == ResponseStatus.SUCCESS && response.data != null) {
        final getTechModel = GetTechModel.fromJson(response.data);
        final List<Technology> technologies = [];

        if (getTechModel.data != null) {
          for (var item in getTechModel.data!) {
            technologies.add(
              Technology(
                id: item.id!,
                techName: item.techName!, // Ensure this is a valid String
              ),
            );
          }
        }

        log(technologies.length.toString() as num);

        setState(() {
          _technologies = technologies.cast<
              String>(); // Ensure _technologies is not final or handle it differently
        });
        isLoading.value = false;
        _showSnackBar('Technologies fetched successfully!', Colors.green);
      } else {
        isLoading.value = false;
        _handleError("Failed to fetch technologies: ${response.message}");
      }
    } catch (e) {
      isLoading.value = false;
      _handleError("An error occurred: ${e.toString()}");
    }
  }

  // Method to handle the form submission
  Future<void> _submitData() async {
    try {
      // Ensure both technology and experience are selected
      if (_selectedTechnology == null || _selectedExperience == null) {
        _showSnackBar(
            'Please select both technology and experience', Colors.red);
        return;
      }

      // Prepare the data to be sent
      Map<String, dynamic> data = {
        "technology": _selectedTechnology!,
        "experience": _selectedExperience!,
      };

      // Make the API call
      ResponseData response =
          await PersonalInfoAPIServices().sendTechselection(data);

      if (response.status == ResponseStatus.SUCCESS) {
        String token = response.data['data']['token'];

        _showSnackBar('Data submitted successfully!', Colors.green);

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UpcomingTestPage(),
        ));
      } else {
        _showSnackBar('Failed to submit data. Please try again.', Colors.red);
      }
    } catch (e) {
      // Handle errors
      _showSnackBar('An error occurred: ${e.toString()}', Colors.red);
    }
  }

  // Method to show a confirmation dialog
  void _showConfirmationDialog(BuildContext context) {
    if (_selectedTechnology == null || _selectedExperience == null) {
      _showSnackBar('Please select both technology and experience', Colors.red);
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Selection'),
          content: Text(
            'You have selected:\n\nTechnology: $_selectedTechnology\nExperience: $_selectedExperience',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Proceed'),
              onPressed: () {
                Navigator.of(context).pop();
                _submitData();
              },
            ),
          ],
        );
      },
    );
  }

  // Method to show a snackbar
  void _showSnackBar(String message, MaterialColor green) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        title: Text('Technology Selection'),
        backgroundColor: Color(0xff508C9B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Choose Your Technology',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            SizedBox(height: 30),
            _buildDropdown(
              label: 'Select Technology',
              value: _selectedTechnology,
              items: _technologies,
              onChanged: (value) => setState(() => _selectedTechnology = value),
            ),
            SizedBox(height: 20),
            _buildDropdown(
              label: 'Select Years of Experience',
              value: _selectedExperience,
              items: _experienceYears,
              onChanged: (value) => setState(() => _selectedExperience = value),
            ),
            Spacer(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  // Method to build a dropdown form field
  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
          ),
          value: value,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  // Method to build the floating action button with the fade effect
  Widget _buildFloatingActionButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FadeTransition(
          opacity: _controller,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Submit and Start Test',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 90,
          width: 90,
          child: FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () => _showConfirmationDialog(context),
            backgroundColor: Color(0xFF134B70),
            child: Icon(
              Icons.arrow_forward,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
