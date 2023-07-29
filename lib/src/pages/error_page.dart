import 'package:flutter/material.dart';

import '../commons/const.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image: const AssetImage('assets/images/conectar.png'),
                    width: screenSize.width * 0.5),
                    Text(
                      msgErrorInesperado,
                      style: TextStyle(
                          color: Colors.grey[350], fontFamily: font1),
                    )
                    
              ],
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: TextButton(
              onPressed: () => Navigator.pushNamed(context, '/home_products'),
              child: const Text(
                "Go Home",
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 100, 185),
                    fontFamily: font1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
