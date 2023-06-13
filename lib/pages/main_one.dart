import 'package:flutter/material.dart';
import 'dart:async';


class OneMyapp extends StatefulWidget {
  const OneMyapp({super.key});

  @override
  State<OneMyapp> createState() => _MyappState();
}

class _MyappState extends State<OneMyapp> {
  double _left = 0.0;
  double _right = 0.0;
  final _animationDuration = Duration(milliseconds: 10); // не знаю почему миллисекунды, так как в 1s = 1000ms, но я считал время движения с помощью секундмера)

  bool isButtonOneDisabled = false;
  bool isButtonTwoDisabled = false;

  void _oneButton() {
    if (!isButtonOneDisabled) {
      setState(() {
        isButtonOneDisabled = true;
      });

      if (_left > 0) {
        final timer = Timer.periodic(_animationDuration, (timer) {
          if (_left - 30 < 0) {
            timer.cancel();
            setState(() {
              isButtonOneDisabled = false;
              isButtonTwoDisabled = false;
            });
          } else {
            setState(() {
              _left -= 30;
            });
          }
        });
      }

      setState(() {
        isButtonTwoDisabled = true;
      });
    }
  }

  void _twoButton() {
    if (!isButtonTwoDisabled) {
      setState(() {
        isButtonTwoDisabled = true;
      });

      final screenWidth = MediaQuery.of(context).size.width;
      if (_left < screenWidth - 65) {
        final timer = Timer.periodic(_animationDuration, (timer) {
          if (_left + 30 > screenWidth - 65) {
            timer.cancel();
            setState(() {
              isButtonTwoDisabled = false;
              isButtonOneDisabled = false;
            });
          } else {
            setState(() {
              _left += 30;
            });
          }
        });
      }

      setState(() {
        isButtonOneDisabled = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenCount = screenWidth / screenHeight;

    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.cyan),
      home: Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          title: Text("Mini game"),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body:
        SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/two');
                  },
                  child: Text('Перейти'),

                ),
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text('Vanik Fenesh'),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10)
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('image/Ava.jpg'),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20)),
                      const Text('Screen Count:'),
                      Text(screenCount.toString()),
                      Padding(padding: EdgeInsets.only(top: 100)),

                    ],
                  )

                ),

                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _left -= details.delta.dx;
                          _right += details.delta.dx;
                        });
                      },

                      child: Stack(
                          children: [
                            Positioned(
                              left: _left,
                              right: _right,
                              child: ClipPath(
                                clipper: MyCustomClipper(),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ]
                      ),
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _oneButton,
                        child: Text('Кнопка 1'),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 16),
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          disabledForegroundColor: Colors.black,
                          disabledBackgroundColor: Colors.black,
                          elevation: 5.0,
                          minimumSize: Size(100, 120), // задаем минимальный размер кнопок
                        ),
                      ),

                      ElevatedButton(
                        onPressed: _twoButton,
                        child: Text('Кнопка 2'),
                        style:ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 16),
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          elevation: 5.0,
                          minimumSize: Size(100, 120),
                        ),
                      ),
                    ]
                )


              ],
            )
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.height, size.height)
      ..lineTo(size.height, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}