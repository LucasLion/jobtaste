import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchJobImages(String job) async {
  // Remplacez 'YOUR_ACCESS_KEY' par votre clé d'accès API
  String accessKey = 'Nm9rcTcyxNe8_UC8X9aLWYnGA51pbXygCxq2CBWahOY';
  String baseUrl = 'https://api.unsplash.com/search/photos';
  String searchQuery = job; // Exemple : "engineer", "doctor"

  // Construisez l'URL de la requête
  Uri url = Uri.parse('$baseUrl?query=$searchQuery&client_id=$accessKey');

  // Faites la requête à l'API
  http.Response response = await http.get(url);

  // Vérifiez que la requête a réussi
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var images = data['results'];

    // Traitez les images obtenues ici
    // Par exemple, extrayez l'URL de chaque image et l'affichez dans votre application
    for (var image in images) {
      print(image['urls']['regular']); // Imprime l'URL de l'image
    }
    return images;
  } else {
    // Gérez l'erreur ici
    print('Failed to load images');
    return [];
  }
}
