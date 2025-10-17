import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/views/game_screen.dart';
import 'package:tic_tac_toe/views/game_screen_robot.dart';
import 'package:tic_tac_toe/views/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
            colors: [Colors.cyan, Colors.blue, Colors.deepPurpleAccent],
          ),
        ),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: GoogleFonts.mogra(fontSize: 60),
                children: [
                  TextSpan(
                    text: 'TIC-',
                    style: TextStyle(color: Colors.orange),
                  ),
                  TextSpan(
                    text: 'TAC-',
                    style: TextStyle(color: Colors.purple),
                  ),
                  TextSpan(
                    text: 'TOE',
                    style: TextStyle(color: Colors.yellow),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: GoogleFonts.mogra(fontSize: 60),
                children: [
                  TextSpan(
                    text: 'X-',
                    style: TextStyle(color: Colors.yellow),
                  ),
                  TextSpan(
                    text: 'O-',
                    style: TextStyle(color: Colors.purple),
                  ),
                  TextSpan(
                    text: 'X-',
                    style: TextStyle(color: Colors.yellow),
                  ),
                  TextSpan(
                    text: 'O',
                    style: TextStyle(color: Colors.purple),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Play with Robot
            CustomElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreenRobot()),
                );
              },
              buttonName: 'Play with Robot [AI]',
            ),
            // Play with Friends
            CustomElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
              buttonName: 'Play with Friend',
            ),
            // Settings
            CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              buttonName: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback? onPressed;
  const CustomElevatedButton({
    super.key,
    required this.buttonName,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: Colors.white, width: 2),
        fixedSize: Size(250, 50),
        backgroundColor: Colors.white12,
      ),
      child: Text(
        buttonName,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
