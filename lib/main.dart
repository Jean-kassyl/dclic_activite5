// ignore_for_file: avoid_print

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
        title: Text( "Gestion des rédacteurs", style: TextStyle(color: Colors.white)),
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
  final _updateNomController = TextEditingController();
  final _updatePrenomController = TextEditingController();
  final _updateEmailController = TextEditingController();

  DatabaseManager db = DatabaseManager();

  List<Redacteur> redacteurs = [];

  Future<void> _loadRedacteurs() async{
    final newRedacteurs = await db.getAllRedacteurs();
    setState(() => redacteurs = newRedacteurs);
  }

  Future<void> _createRedacteur() async{
    final Redacteur newRedacteur = Redacteur.sansId(nom: _nomController.text, prenom: _prenomController.text, email: _emailController.text);
    await db.insertRedacteur(newRedacteur);
    await _loadRedacteurs();
  }

  Future<void> _deleteRedacteur(int? id) async{
    await db.deleteRedacteur(id);
    await _loadRedacteurs();
  }


  Future<void> _updateRedacteur(Redacteur updatedRedacteur) async{
  
    await db.updateRedacteur(updatedRedacteur);
    await _loadRedacteurs();
  }
  
  
  @override
  void initState(){
    super.initState();
    _loadRedacteurs();
  }
  


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [TextField(
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
          _createRedacteur();
          _nomController.text = '';
          _prenomController.text = '';
          _emailController.text = '';
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
      Expanded(
        
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(shrinkWrap: true, itemCount:redacteurs.length, itemBuilder: (context, i){
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
          
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                  Column(crossAxisAlignment:CrossAxisAlignment.start,spacing: 5,children: [
                    Text("${redacteurs[i].nom} ${redacteurs[i].prenom}"),
                    Text(redacteurs[i].email)
                  ],),
                  Row(spacing: 20.0,children: [
                    IconButton(onPressed: (){
                      int? id = redacteurs[i].id;
                      _deleteRedacteur( id);
                    }, icon: Icon(Icons.delete, color: Colors.red)),
                    IconButton(onPressed: (){
                      final Redacteur currentRedacteur = redacteurs[i];
                      _updateNomController.text = currentRedacteur.nom;
                      _updatePrenomController.text = currentRedacteur.prenom;
                      _updateEmailController.text = currentRedacteur.email;
                      showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            content: Column(
                              children: [
                                TextField(
                                  controller: _updateNomController,
                                  decoration: InputDecoration(
                                    labelText: "Nom",
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                                TextField(
                                  controller: _updatePrenomController,
                                   decoration: InputDecoration(
                                    labelText: "Prenom",
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                                TextField(
                                  controller: _updateEmailController,
                                   decoration: InputDecoration(
                                    labelText: "Email",
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                              ]
                            ),
                            actions: [
                              OutlinedButton(onPressed: (){

                                Navigator.of(context).pop();
                              }, style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),child: Text('Cancel')),
                              ElevatedButton(onPressed: (){
                                Redacteur updatedRedacteur = Redacteur(id:redacteurs[i].id,nom: _updateNomController.text, prenom: _updatePrenomController.text, email: _updateEmailController.text);
                                _updateRedacteur(updatedRedacteur);
                              
                                Navigator.of(context).pop();

                              },  style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),child: Text('update', style: TextStyle(color: Colors.white)),),
                            ],
                          );
                        }
                      );



                    }, icon: Icon(Icons.edit, color: Colors.blue))
                  ], )
                ]
              )
            );
          }),
        ),
      ),
      ]
    );
  }
}