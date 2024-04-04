import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchJobImages(String job) async {
  String accessKey = 'Nm9rcTcyxNe8_UC8X9aLWYnGA51pbXygCxq2CBWahOY';
  String baseUrl = 'https://api.unsplash.com/search/photos';
  String searchQuery = job;

  Uri url = Uri.parse('$baseUrl?query=$searchQuery&client_id=$accessKey');
  http.Response response = await http.get(url);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var images = data['results'] as List;
    List<String> imageUrls = images.map((image) => image['urls']['regular'].toString()).toList();
    return imageUrls;
  } else {
    print('Failed to load images');
    return [];
  }
}

