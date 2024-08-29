import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:wdipl_interview_app/model/gettech.dart';
import 'package:wdipl_interview_app/model/techdrop.dart';
import 'package:wdipl_interview_app/shared/api/base_manager.dart';
import 'package:wdipl_interview_app/shared/api/repos/userdet_api.dart';
import 'package:wdipl_interview_app/testoverview/testov1.dart';

class ExperienceYear {
  final int id;
  final String label;

  ExperienceYear({required this.id, required this.label});
}

class TechnologySelectionPage extends StatefulWidget {
  final String experienceLevel;

  const TechnologySelectionPage({super.key, required this.experienceLevel});

  @override
  _TechnologySelectionPageState createState() =>
      _TechnologySelectionPageState();
}

class _TechnologySelectionPageState extends State<TechnologySelectionPage>
    with SingleTickerProviderStateMixin {
  List<Technology> _technologies = [];
  List<ExperienceYear> _experienceYears = [];

  Technology? _selectedTechnology;
  ExperienceYear? _selectedExperience;
  late AnimationController _controller;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _getTechnology(); // Fetch technology data when initializing the form
    _filterExperienceYears(); // Filter experience years based on experience level
  }

  void _filterExperienceYears() {
    if (widget.experienceLevel == 'Fresher') {
      _experienceYears = [
        ExperienceYear(id: 1, label: 'Fresher'),
      ];
    } else {
      _experienceYears = [
        ExperienceYear(id: 1, label: 'Fresher'),
        ExperienceYear(id: 2, label: '0-1 years'),
        ExperienceYear(id: 3, label: '1-3 years'),
        ExperienceYear(id: 4, label: '3-5 years'),
        ExperienceYear(id: 5, label: '5+ years'),
      ];
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _getTechnology() async {
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
                techName: item.techName!,
              ),
            );
          }
        }

        log(technologies.length.toString());

        setState(() {
          _technologies = technologies;
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

  void _handleError(String errorMessage) {
    _showSnackBar(errorMessage, Colors.red);
  }

  Future<void> _submitData() async {
    try {
      if (_selectedTechnology == null || _selectedExperience == null) {
        _showSnackBar(
            'Please select both technology and experience', Colors.red);
        return;
      }

      Map<String, dynamic> data = {
        "tech_masters_xid": _selectedTechnology!.id,
        "year_of_experience": _selectedExperience!.id,
      };

      ResponseData response =
          await PersonalInfoAPIServices().sendTechselection(data);

      if (response.status == ResponseStatus.SUCCESS) {
        _showSnackBar('Data submitted successfully!', Colors.green);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UpcomingTestPage(),
        ));
      } else {
        _showSnackBar('Failed to submit data. Please try again.', Colors.red);
      }
    } catch (e) {
      _showSnackBar('An error occurred: ${e.toString()}', Colors.red);
    }
  }

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
            'You have selected:\n\nTechnology: ${_selectedTechnology!.techName}\nExperience: ${_selectedExperience!.label}',
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

  void _showSnackBar(String message, MaterialColor color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
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
          title: Text(
            'Technology Selection',
            style: TextStyle(color: Color(0xFF2c94c1), fontSize: 30),
          ),
          backgroundColor: Color(0xFF252324),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('Choose Your Technology',
                    style: TextStyle(color: Color(0xFF2c94c1), fontSize: 55)),
              ),
              SizedBox(height: 30),
              ValueListenableBuilder<bool>(
                valueListenable: isLoading,
                builder: (context, value, child) {
                  return value
                      ? Center(child: CircularProgressIndicator())
                      : _buildDropdown<Technology>(
                          label: 'Select Technology',
                          value: _selectedTechnology,
                          items: _technologies,
                          onChanged: (value) =>
                              setState(() => _selectedTechnology = value),
                        );
                },
              ),
              SizedBox(height: 20),
              _buildDropdown<ExperienceYear>(
                label: 'Select Years of Experience',
                value: _selectedExperience,
                items: _experienceYears,
                onChanged: (value) =>
                    setState(() => _selectedExperience = value),
              ),
              Spacer(),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold, color: Color(0xFF2c94c1)),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<T>(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
          ),
          value: value,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item is Technology
                  ? item.techName
                  : (item as ExperienceYear).label),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

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
                color: Color(0xFF2c94c1),
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
            backgroundColor: Color(0xFFe21f88),
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
