import 'package:flutter/material.dart';
import 'package:dclic_activite5/modele/models.dart';

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
      home: Scaffold(
      appBar: AppBar(
        title: Text( "Gestion des rédacteurs"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.menu, color: Colors.white)
        ),
        actions: [
          IconButton(
           onPressed: (){},
           icon: Icon(Icons.search, color: Colors.white)
          ),
        ],
      ),
      body: RedacteurInterface()
    )
    );
  }
}


class RedacteurInterface extends StatefulWidget {
  const RedacteurInterface({super.key});


  @override
  State<RedacteurInterface> createState() => _RedacteurInterfaceState();
}

class _RedacteurInterfaceState extends State<RedacteurInterface> {
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();

  DatabaseManager db = DatabaseManager();

  List<Map<String, dynamic>> redactors = [
    {
      'id': 1,
      'nom': 'Roberto',
      'prenom': 'Talio',
      'email': 'taliro@ymail.com'
    },
    {
      'id': 2,
      'nom': 'Roberta',
      'prenom': 'Sansa',
      'email': 'sansaro@ymail.com'
    }
  ];

  

  


  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [Column(
        children: [
          TextField(
            controller: _nomController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Nom'
            ),
          ),
          TextField(
            controller: _prenomController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Prenom'
            ),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Email'
            ),
          ),
          ElevatedButton.icon(
            onPressed: (){
              
              
            }, 
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              backgroundColor: Colors.pinkAccent
            ),
            icon: Icon(Icons.add, color: Colors.white),
            
            label: Text(
              'Ajouter un rédacteur',
              style: TextStyle(
                color: Colors.white
              ),
            ),
            
          ),
          
        ],
      ),
      Expanded(
        child: ListView.builder(itemCount: redactors.length, itemBuilder: (context, i){
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: ListTile(
                            title:  Text("${redactors[i]['nom']} ${redactors[i]['prenom']}"),
                            subtitle: Text("${redactors[i]['email']}")
                          ),
              ),
          Row(
            children: [
              Icon(Icons.delete),
              Icon(Icons.edit)
            ],
          ),
            ],
          );
        }),
      ),
      ]
    );
  }
}