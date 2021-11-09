import 'package:crew_brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/models/Quiz.dart';
import 'brew_tile.dart';

// ! This widget is responsible for outputting different brews on the page
class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    // ~ We access the brews. It's updated when some changes to the database occur
    // ~ The provider is defined in home.dart class
    final brews = Provider.of<List<Quiz>?>(context);
    if (brews != null) {
      brews.forEach((brew) {
        print(brew.quizOwner);
        print(brew.quizTitle);
        print(brew.strength);
      });

      return ListView.builder(
        itemCount: brews.length,
        // ~ itemBuilder is the function in itself which is going to return some kind of template or a widget tree for each item inside the list
        itemBuilder: (context, index) {
          return BrewTile(brew: brews[index]);
        },
      );
    } else {
      return Loading();
    }

//print(brews?.docs.toString());
/* final brews = Provider.of<QuerySnapshot?>(context);
    if(brews?.docs != null ){
      for(var doc in brews!.docs){
        print(doc.data());
      }
    }
     */
  }
}
