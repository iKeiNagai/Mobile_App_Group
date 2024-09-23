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
  Timer? _winTimer;         
  Timer? _lossCheckTimer;   // Timer to check loss condition
  Timer? hungerTimer;
  int happinessLevel = 50;
  int hungerLevel = 50;
  Color textColor = Colors.black;
  String currentMood = "";
  TextEditingController nameController = TextEditingController();
  List<String> mood = ["Happy", "Neutral", "Unhappy"];
  bool hasWon = false;       // Track win condition
  bool isGameOver = false;   // Track loss condition

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

    // Start loss condition check timer
    _lossCheckTimer = Timer.periodic(Duration(seconds: 1), _checkLossCondition);
  }

  @override
  void dispose() {
    hungerTimer?.cancel(); // Cancel the hunger timer when widget is disposed
    _winTimer?.cancel();   // Cancel the win timer
    _lossCheckTimer?.cancel(); // Cancel the loss check timer
    super.dispose();
  }

  // Function to increase happiness and update hunger when playing with the pet
  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateHunger();
      _updateMood(happinessLevel);
      _checkWinCondition(happinessLevel); // Check win condition after playing
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

  // Check if the win condition is met
  void _checkWinCondition(int happinessLevel) {
    if (happinessLevel > 80 && _winTimer == null) {
      // Start a timer if happiness level stays above 80
      _winTimer = Timer(Duration(seconds: 3), () {
        setState(() {
          hasWon = true;  // Set win condition to true
        });
      });
    } else if (happinessLevel <= 80 && _winTimer != null) {
      // Reset the timer if happiness level drops below 80
      _winTimer!.cancel();
      _winTimer = null;
    }
  }

  // Check for loss condition
  void _checkLossCondition(Timer timer) {
    if (hungerLevel >= 100 && happinessLevel <= 10) {
      setState(() {
        isGameOver = true;  // Set game over condition
        _lossCheckTimer?.cancel(); // Stop loss checking
        _winTimer?.cancel(); // Stop win timer if active
      });
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
            // Display win/loss condition messages
            if (hasWon)
              Text(
                'You Win!',
                style: TextStyle(fontSize: 32, color: Colors.green),
              )
            else if (isGameOver)
              Text(
                'Game Over!',
                style: TextStyle(fontSize: 32, color: Colors.red),
              )
            else
              Text(
                'Keep happiness level above 80 for 3 minutes to win! \nAvoid hunger level reaching 100 with happiness at 10!',
                style: TextStyle(fontSize: 18, color: Colors.red),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
