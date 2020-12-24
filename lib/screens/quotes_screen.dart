import 'package:breaking_bad/models/quotes.dart';
import 'package:flutter/material.dart';

class QuotesScreen extends StatefulWidget {
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  Future<QuoteList> data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Network network = Network('https://breakingbadapi.com/api/quotes');

    data = network.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('QUOTES'),),
      body: Center(
        child: FutureBuilder(
            future: data,
            builder: (context, AsyncSnapshot<QuoteList> snapshots) {
              List<Quotes> allQuotes;
              if (snapshots.hasData) {
                allQuotes = snapshots.data.quotes;
                return createList(allQuotes, context);
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}

Widget createList(List<Quotes> data, context) {
  TextStyle textStyle =
      Theme.of(context).textTheme.headline2.copyWith(fontSize: 18);
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, int index) {
        return ExpansionTile(
          title: Text(data[index].author),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data[index].quote,
                style: textStyle,
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Text(data[index].series)),
            Text('${data[index].quoteId}')
          ],
        );
      });
}
