import 'package:flutter/material.dart';

class authPage extends StatelessWidget {
  const authPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 0.5),
                  Color.fromRGBO(255, 188, 117, 0.9)
                ]
              )
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              children: [
                
              ],
            ),
          )
        ],
      ),
    );
  }
}