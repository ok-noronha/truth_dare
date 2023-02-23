import 'dart:convert';
import 'package:http/http.dart' as http;

class TriviaService {
  static const String apiUrl =
      'https://opentdb.com/api.php?amount=10&category=21&type=boolean';

  static Future<List<String>> fetchQuestions() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List<dynamic>;
      return results.map((result) => result['question'] as String).toList();
    } else {
      throw Exception('Failed to fetch questions');
    }
  }
}
