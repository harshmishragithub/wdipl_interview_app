import 'package:flutter/material.dart';
import 'package:wdipl_interview_app/features/test1info.dart';

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
  @override
  _TechnologySelectionPageState createState() =>
      _TechnologySelectionPageState();
}

class _TechnologySelectionPageState extends State<TechnologySelectionPage>
    with SingleTickerProviderStateMixin {
  final List<String> technologies = [
    'Laravel',
    'Python',
    'Java',
    'C#',
    'Flutter',
    'Website',
    'Fullstack',
    'SEO',
    'UI/UX'
  ];
  final List<String> experienceYears = [
    '0-1 years',
    '1-3 years',
    '3-5 years',
    '5+ years'
  ];

  String? selectedTechnology;
  String? selectedExperience;
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
            Text(
              'Select Technology',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Technology',
              ),
              value: selectedTechnology,
              items: technologies.map((tech) {
                return DropdownMenuItem<String>(
                  value: tech,
                  child: Text(tech),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTechnology = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Select Years of Experience',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Experience',
              ),
              value: selectedExperience,
              items: experienceYears.map((exp) {
                return DropdownMenuItem<String>(
                  value: exp,
                  child: Text(exp),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedExperience = value;
                });
              },
            ),
            Spacer(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExamInfoPage()),
                );
              },
              backgroundColor: Color(0xFF134B70),
              child: Icon(
                Icons.arrow_forward,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
