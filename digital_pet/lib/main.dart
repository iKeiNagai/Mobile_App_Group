import 'dart:async'; // Import dart:async for Timer

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DigitalPetApp(),
  ));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Peter";
  int happinessLevel = 50;
  int hungerLevel = 50;
  Color textColor = Colors.black;
  String currentMood = "";
  TextEditingController nameController = TextEditingController();
  List<String> mood = ["Happy", "Neutral", "Unhappy"];
  Timer? hungerTimer;

  @override
  void initState() {
    super.initState();
    // Start the timer to increase hunger every 30 seconds
    hungerTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        hungerLevel = (hungerLevel + 5).clamp(0, 100);
        if (hungerLevel >= 100) {
          hungerLevel = 100;
          happinessLevel = (happinessLevel - 20).clamp(0, 100);
        }
        _updateMood(happinessLevel);
      });
    });
  }

  @override
  void dispose() {
    hungerTimer?.cancel(); // Cancel the timer when widget is disposed
    super.dispose();
  }

  // Function to increase happiness and update hunger when playing with the pet
  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateHunger();
      _updateMood(happinessLevel);
    });
  }

  void _changePetName() {
    setState(() {
      petName = nameController.text.isNotEmpty ? nameController.text : petName;
    });
  }

  // Function to decrease hunger and update happiness when feeding the pet
  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      _updateHappiness();
      _updateMood(happinessLevel);
    });
  }

  void _updateMood(int happinessLevel) {
    if (happinessLevel > 70) {
      currentMood = mood[0];
      textColor = Colors.green;
    } else if (happinessLevel < 70 && happinessLevel > 30) {
      currentMood = mood[1];
      textColor = Colors.yellow;
    } else if (happinessLevel <= 30) {
      currentMood = mood[2];
      textColor = Colors.red;
    }
  }

  // Update happiness based on hunger level
  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    } else {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
    }
  }

  // Increase hunger level slightly when playing with the pet
  void _updateHunger() {
    hungerLevel = (hungerLevel + 5).clamp(0, 100);
    if (hungerLevel >= 100) {
      hungerLevel = 100;
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Name: $petName',
              style: TextStyle(fontSize: 20.0, color: textColor),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Enter new pet name'),
            ),
            TextButton(
              onPressed: _changePetName,
              child: Text('Change Name'),
            ),
            Text('Current Mood: $currentMood'),
            SizedBox(height: 16.0),
            Text(
              'Happiness Level: $happinessLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Hunger Level: $hungerLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _playWithPet,
              child: Text('Play with Your Pet'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _feedPet,
              child: Text('Feed Your Pet'),
            ),
          ],
        ),
      ),
    );
  }
}
