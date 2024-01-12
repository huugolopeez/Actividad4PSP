import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpAdmin {
  Future<String> getCatData() async {
    final apiUrl = 'https://api.thecatapi.com/v1/images/search';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final String imageUrl = data[0]['url'];
      return(imageUrl);
    } else {
      throw Exception('Error al obtener datos de gatos');
    }
  }

  Future<String> getDadJoke() async {
    final apiUrl = 'https://icanhazdadjoke.com/';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String joke = data['joke'];
      return('Chiste de padre: \n$joke');
    } else {
      throw Exception('Error al obtener el chiste del papá');
    }
  }
}