import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quote_day/model/quote_model.dart';

List<QuoteModel> quoteList = [];
Future<List<QuoteModel>> getUserApi() async {
  final response = await http.get(Uri.parse('https://type.fit/api/quotes'));
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    for (Map<String, dynamic> i in data) {
      quoteList.add(QuoteModel.fromJson(i));
    }
    return quoteList;
  } else {
    return quoteList;
  }
}
