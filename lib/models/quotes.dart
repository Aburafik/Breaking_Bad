import 'dart:convert';

import 'package:http/http.dart';

class Quotes {
  int quoteId;
  String quote;
  String author;
  String series;
  Quotes({this.quoteId, this.quote, this.author, this.series});
  factory Quotes.fromjson(Map<String, dynamic> json) {
    return Quotes(
        quoteId: json["quote_id"],
        quote: json["quote"],
        author: json["author"],
        series: json["series"]);
  }
}

class QuoteList {
  List<Quotes> quotes;
  QuoteList({this.quotes});

  factory QuoteList.fromjson(List<dynamic> parsedjson) {
    List<Quotes> quotes = List<Quotes>();
    quotes = parsedjson.map((e) => Quotes.fromjson(e)).toList();

    return QuoteList(quotes: quotes);
  }
}

class Network {
  String url;
  Network(this.url);

  Future<QuoteList> fetchData() async {
    final response = await get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      //0k
      print(response.body);
    } else {
      print(response.statusCode);
    }
    return QuoteList.fromjson(jsonDecode(response.body));
  }
}
