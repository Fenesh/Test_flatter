import 'package:flutter/material.dart';


class TwoMyapp extends StatefulWidget {
  const TwoMyapp({super.key});

  @override
  State<TwoMyapp> createState() => _MyappState();
}

class _MyappState extends State<TwoMyapp> {
  double _left = 0.0;
  double _top = 0.0;
  bool isButtonDisabled = false;

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
          title: Text("Mini game_2"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body:
        SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
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
                          backgroundColor: Colors.amber,
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
                          _top += details.delta.dy;
                        });
                      },

                      child: Stack(
                          children: [

                            Positioned(
                              left: _left,
                              top: _top,
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
                        onPressed: (){
                          if(_left > 0 ) {
                            setState(() {
                              _left -=30;
                            });
                          }else{
                            isButtonDisabled;
                          }

                        },
                        child: Text('Кнопка 1'),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 16),
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          elevation: 5.0,
                          minimumSize: Size(100, 120), // задаем минимальный размер кнопок
                        ),
                      ),

                      ElevatedButton(
                        onPressed: (){
                          if(_left < screenWidth - 50  ) {
                            setState(() {
                              _left +=30;
                            });
                          }else{
                            null;
                          }
                        },
                        child: Text('Кнопка 2'),
                        style:ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 16),
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          elevation: 5.0,
                          minimumSize: Size(100, 120),
                        ),
                      ),
                      ElevatedButton(onPressed: (){
                            if(_top < screenHeight -50){
                              _top -= 50;
                            } else if(_top > 0){
                              _top += 50;
                            }else{
                              null;
                            }
                          }
                          ,
                          child: Text("Вверх"))
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