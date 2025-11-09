import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
enum CircleSide { left, right}

 extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;

    switch(this){
      case CircleSide.left :
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(offset,
     radius: Radius.elliptical(size.width/2, size.height/2),
      clockwise: clockwise
     );
    path.close();
    return path;
  }
 }

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
   late AnimationController _counterClockwiseRotationController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipPath(
                clipper:  HalfCircleClipper(side: CircleSide.left),
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.blue,
                ),
              ),
              ClipPath(
                clipper: HalfCircleClipper(side: CircleSide.right),
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.yellow,
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path>{
  final CircleSide side;
  HalfCircleClipper({required this.side});


  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)=> true;

}
