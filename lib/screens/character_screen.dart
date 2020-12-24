import 'package:breaking_bad/models/players.dart';
import 'package:flutter/material.dart';
class CharacterScreen extends StatefulWidget {
  @override
  _CharacterScreen createState() => _CharacterScreen();
}

class _CharacterScreen extends State<CharacterScreen> {
  

  Future<PlayersList> data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkHelper networkHelper =
        NetworkHelper('https://breakingbadapi.com/api/characters');
    data = networkHelper.getPlayers();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BREAKING BAD CHARACTERS'),),
     

      body: Center(
        child: FutureBuilder(
            future: data,
            builder: (context, AsyncSnapshot<PlayersList> snapshots) {
              List<Players> allQuotes;
              if (snapshots.hasData) {
                allQuotes = snapshots.data.player;
                return griBuilder(allQuotes, context);
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  

  Widget griBuilder(List<Players> data, context) {
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .6, crossAxisCount: 2, mainAxisSpacing: 2),
        itemBuilder: (context, int index) {
          return Card(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Container(
                // width: 50,
                height: 200,
                decoration: BoxDecoration(
                  
                    image:
                        DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(data[index].img))),
              ),
              Text('Name: ${data[index].name}'),
              Text('Status: ${data[index].status}'),
              Text('Category: ${data[index].category}')
            ]),
          );
        });
  }
}
