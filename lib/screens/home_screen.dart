import "package:flutter/material.dart";
import "home_body.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Head(),
      backgroundColor: Colors.blueGrey,
      body: HomeBody(),
    );
  }
}

AppBar Head() {
  return AppBar(
    title: Text(
      "Calculator",
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.amber,
    centerTitle: true,
  );
}
