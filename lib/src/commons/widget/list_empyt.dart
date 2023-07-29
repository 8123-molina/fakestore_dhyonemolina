import 'package:flutter/material.dart';

import '../const.dart';

class ListEmpyt extends StatefulWidget {
  const ListEmpyt({super.key});

  @override
  State<ListEmpyt> createState() => _ListEmpytState();
}

class _ListEmpytState extends State<ListEmpyt> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;  
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: const AssetImage('assets/images/list_empty.png'), width: screenSize.width * 0.5),
          Text('The list is empty', style: TextStyle(color: Colors.grey[350],fontFamily: font1),),
        ],
      ),
    );
  }
}