import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/launch_model.dart';

class ApiService {
  final String _baseUrl = "https://api.spacexdata.com/v4/launches/past";

  Future<List<Launch>> fetchLaunches() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);

        return body.map((item) => Launch.fromJson(item)).toList().reversed.toList();
      } else {
        throw Exception("Falha ao carregar lançamentos: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Erro de conexão: $e");
    }
  }
}