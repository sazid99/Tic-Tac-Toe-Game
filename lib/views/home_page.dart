import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/views/game_screen.dart';
import 'package:tic_tac_toe/views/game_screen_robot.dart';
import 'package:tic_tac_toe/views/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer bgPlayer = AudioPlayer();
  final String bgAudio = 'game_audio_1';

  Future<void> playBackgroundMusic() async {
    await bgPlayer.play(AssetSource('audio/$bgAudio.mp3'), volume: 1);
    bgPlayer.setReleaseMode(ReleaseMode.loop);
  }

  @override
  void initState() {
    super.initState();
    playBackgroundMusic();
  }

  @override
  void dispose() {
    bgPlayer.stop();
    bgPlayer.dispose();
    super.dispose();
  }

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
            Text(
              'TIC-TAC-TOE',
              style: TextStyle(fontFamily: 'BungeeSpice', fontSize: 40),
            ),
            Text(
              'O-X-O',
              style: TextStyle(fontFamily: 'BungeeSpice', fontSize: 60),
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
              buttonName: 'Play with Robot',
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
