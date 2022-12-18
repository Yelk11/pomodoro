import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:vibration/vibration.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Icon icon = const Icon(Icons.play_arrow);
  final CountDownController _controller = CountDownController();
  int phase = 0;
  final List<int> _duration = [
    1500,
    300,
    1500,
    300,
    1500,
    300,
    1500,
    300,
    1500,
    1800
  ];

  @override
  void initState() {
    _controller.pause();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            color: const Color(0xFFF7D799),
            child:
                const Image(image: AssetImage('lib/images/deer_in_field.jpg')),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    child: CircularCountDownTimer(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 2,
                      duration: _duration[phase].toInt(),
                      strokeWidth: 30,
                      isReverse: true,
                      fillColor: const Color(0xFF99B9F7),
                      ringColor: const Color(0xFFF7D799),
                      controller: _controller,
                      autoStart: false,
                      strokeCap: StrokeCap.round,
                      textStyle: const TextStyle(
                          fontSize: 33.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      onComplete: () {
                        setState(() {
                          if (phase >= 9) {
                            phase = 0;
                          } else {
                            phase++;
                          }
                          _controller.restart(
                              duration: _duration[phase].toInt());
                        });
                        FlutterRingtonePlayer.playNotification();
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _controller.pause();
                          });
                        },
                        child: const Icon(Icons.pause),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            if (_controller.isPaused) {
                              _controller.resume();
                            } else {
                              _controller.start();
                            }
                          });
                        },
                        child: icon,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _controller.restart(
                                duration: _duration[phase].toInt());
                          });
                        },
                        child: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                ),
                Expanded(flex: 2, child: Container())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
