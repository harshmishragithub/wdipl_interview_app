import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:wdipl_interview_app/testoverview/testov1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Technology Selection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18.0),
        ),
      ),
      home: TechnologySelectionPage(),
    );
  }
}

class TechnologySelectionPage extends StatefulWidget {
  const TechnologySelectionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TechnologySelectionPageState createState() =>
      _TechnologySelectionPageState();
}

class _TechnologySelectionPageState extends State<TechnologySelectionPage>
    with SingleTickerProviderStateMixin {
  final List<String> _technologies = [
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

  // Method to handle the form submission
  Future<void> _submitData() async {
    if (_selectedTechnology == null || _selectedExperience == null) {
      _showSnackBar('Please select both technology and experience');
      return;
    }

    try {
      // Example API call using the selected data
      final response = await http.post(
        Uri.parse('https://example.com/api/submit'),
        body: {
          'technology': _selectedTechnology!,
          'experience': _selectedExperience!,
        },
      );

      if (response.statusCode == 200) {
        // Navigate to the next page on success
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UpcomingTestPage()),
        );
      } else {
        _showSnackBar('Failed to submit data');
      }
    } catch (e) {
      _showSnackBar('An error occurred. Please try again.');
    }
  }

  // Method to show a confirmation dialog
  void _showConfirmationDialog(BuildContext context) {
    if (_selectedTechnology == null || _selectedExperience == null) {
      _showSnackBar('Please select both technology and experience');
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
  void _showSnackBar(String message) {
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
