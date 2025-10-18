import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/views/home_page.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> displayValues = ['', '', '', '', '', '', '', '', ''];

  bool moveOfX = true;
  int _counter = 10;
  Timer? _timer;

  final AudioPlayer bgPlayer = AudioPlayer();
  final String bgAudio = 'game_audio_1';

  Future<void> playBackgroundMusic() async {
    await bgPlayer.play(AssetSource('audio/$bgAudio.mp3'), volume: 1);
    bgPlayer.setReleaseMode(ReleaseMode.loop);
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer!.cancel();
      }
    });
  }

  void _gestureTap(int index) {
    setState(() {
      if (moveOfX) {
        displayValues[index] = 'X';
      } else {
        displayValues[index] = '0';
      }
      moveOfX = !moveOfX;
      _counter = 10;
      checkWinner();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    playBackgroundMusic();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
    bgPlayer.stop();
    bgPlayer.dispose();
  }

  void checkWinner() {
    if (displayValues[0] == displayValues[1] &&
        displayValues[0] == displayValues[2] &&
        displayValues[0] != '') {
      showDashBoard(displayValues[0]);
    }
    if (displayValues[3] == displayValues[4] &&
        displayValues[3] == displayValues[5] &&
        displayValues[3] != '') {
      showDashBoard(displayValues[3]);
    }
    if (displayValues[6] == displayValues[7] &&
        displayValues[6] == displayValues[8] &&
        displayValues[6] != '') {
      showDashBoard(displayValues[6]);
    }
    if (displayValues[0] == displayValues[3] &&
        displayValues[0] == displayValues[6] &&
        displayValues[0] != '') {
      showDashBoard(displayValues[0]);
    }
    if (displayValues[1] == displayValues[4] &&
        displayValues[1] == displayValues[7] &&
        displayValues[1] != '') {
      showDashBoard(displayValues[1]);
    }
    if (displayValues[2] == displayValues[5] &&
        displayValues[2] == displayValues[8] &&
        displayValues[2] != '') {
      showDashBoard(displayValues[2]);
    }
    if (displayValues[0] == displayValues[4] &&
        displayValues[0] == displayValues[8] &&
        displayValues[0] != '') {
      showDashBoard(displayValues[0]);
    }
    if (displayValues[2] == displayValues[4] &&
        displayValues[2] == displayValues[6] &&
        displayValues[2] != '') {
      showDashBoard(displayValues[2]);
    }
  }

  void showDashBoard(String winner) {
    showDialog(
      context: context,
      builder: (context) => SizedBox(
        height: 400,
        child: AlertDialog(
          title: Center(
            child: Text(
              'DashBoard',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.green[400],
          content: SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Winner!',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'BungeeSpice',
                  ),
                ),
                Text(
                  winner,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BungeeSpice',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Play Again', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
            colors: [Colors.deepPurpleAccent, Colors.green, Colors.blue],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white10,
                    ),
                    icon: Icon(
                      Icons.music_note,
                      color: Colors.yellow,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white10,
                    ),
                    icon: Icon(
                      Icons.home_filled,
                      color: Colors.yellow,
                      size: 30,
                    ),
                  ),
                ],
              ),
              // =======================Player 1 ======================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomPlayerContainer(
                    playerName: 'X',
                    borderColor: moveOfX ? Colors.red : Colors.transparent,
                  ),
                  CustomTimerContainer(timerVal: moveOfX ? _counter : 10),
                ],
              ),
              // =======================Grid View ======================
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GridView.builder(
                  itemCount: 9,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(15),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 120,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _gestureTap(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            displayValues[index],
                            style: TextStyle(
                              fontSize: 90,
                              fontFamily: 'BungeeSpice',
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // =======================Player 2 ======================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTimerContainer(timerVal: moveOfX ? 10 : _counter),
                  CustomPlayerContainer(
                    playerName: '0',
                    borderColor: moveOfX ? Colors.transparent : Colors.red,
                  ),
                ],
              ),
              // =======================Player Turn Container=====
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    '\'${moveOfX ? 'X'.toString() : '0'.toString()}\' Turn Now',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================Custom Player Container===================
class CustomPlayerContainer extends StatelessWidget {
  final Color borderColor;
  final String playerName;
  const CustomPlayerContainer({
    super.key,
    required this.playerName,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor, width: 3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          spacing: 5,
          children: [
            CircleAvatar(child: Icon(Icons.person)),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  playerName,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'BungeeSpice',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================Custom Timer Container=======================
class CustomTimerContainer extends StatefulWidget {
  final int timerVal;
  const CustomTimerContainer({super.key, required this.timerVal});

  @override
  State<CustomTimerContainer> createState() => _CustomTimerContainerState();
}

class _CustomTimerContainerState extends State<CustomTimerContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          '${widget.timerVal.toString()} S',
          style: TextStyle(
            fontSize: 20,
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
