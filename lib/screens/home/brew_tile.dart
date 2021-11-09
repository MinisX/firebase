import 'package:flutter/material.dart';
import 'package:crew_brew/models/Quiz.dart';

class BrewTile extends StatelessWidget {
  const BrewTile({Key? key, required this.brew}) : super(key: key);

  final Quiz brew;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                // ! The intensity of the color depends on the strength of the brew ( coffee )
                backgroundColor: Colors.brown[brew.strength],
                backgroundImage: AssetImage('assets/coffee_icon.png'),
              ),
              title: Text(brew.quizOwner),
              subtitle: Text('Takes ${brew.quizTitle} sugar(s)')),
        ));
  }
}
