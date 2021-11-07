import 'package:dribbble_challenges/challenge_1/home.dart';
import 'package:dribbble_challenges/sliver.dart';
import 'package:dribbble_challenges/utils/model.dart';
import 'package:flutter/material.dart';

import 'chatapp/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dribbble Challenges',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: "ITC"
      ),
      home: const Challenges(),
    );
  }
}

class Challenges extends StatelessWidget {
  const Challenges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Dribbble Challenges"),),
        body: SafeArea(
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          ListTile(
            title: Text("Challenge 1", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieOrderHome(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Challenge 2", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SliverDemo(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Challenge 3", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginView(),
                ),
              );
            },
          ),
          // Image.asset(
          //   movie_model[0].poster,
          //   fit: BoxFit.cover,
          //   height: 500,
          //   width: 300,
          // ),
          // ShaderMask(
          //   shaderCallback: (rect) {
          //     return const LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [Colors.transparent, Colors.black,],
          //     ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          //   },
          //   blendMode: BlendMode.dst,
          //   child: Image.asset(
          //     movie_model[0].poster,
          //     height: 400,
          //     fit: BoxFit.contain,
          //   ),
          // ),
        ],
      ),
    ));
  }
}
