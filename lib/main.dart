import 'package:flutter/material.dart';

void main() {
  runApp(MonApp());
}

class MonApp extends StatelessWidget {
  const MonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gestion des rédacteurs",
      debugShowCheckedModeBanner: false,
      home: MonAccueil()
    );
  }
}


class MonAccueil extends StatelessWidget {
  const MonAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( "Gestion des rédacteurs"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.menu, color: Colors.white)
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.white,
            
          ),
        ],
      ),
    );
  }
}