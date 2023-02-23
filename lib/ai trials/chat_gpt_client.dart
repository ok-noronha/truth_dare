import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> generateQuestion(String prompt, String apiKey) async {
  var response = await http.post(
    Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      'prompt': prompt,
      'max_tokens': 50,
      'n': 1,
      'stop': ['\n']
    }),
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data['choices'][0]['text'];
  } else {
    throw Exception('Failed to generate question');
  }
}
