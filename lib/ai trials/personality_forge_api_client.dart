import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class PersonalityForgeApiClient {
  final http.Client httpClient = http.Client();
  final String baseUrl = 'https://www.personalityforge.com/api/chat/';

  Future<String> sendMessage(String message, String apiKey) async {
    final response = await httpClient
        .get(Uri.parse('$baseUrl?apiKey=$apiKey&message=$message'));

    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }

    final decodedJson = jsonDecode(response.body);
    final responseMessage = decodedJson['message'] as String;
    return responseMessage;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

String _rm = 'Ask me a truth Question';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  String message = 'Ask me a truth Question';
  PersonalityForgeApiClient apiClient = PersonalityForgeApiClient();
  final responseMessage =
      await apiClient.sendMessage(message, '3akpQXoYss1pskhR');
  _rm = responseMessage;
  //_rm = 'ui';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Truth or Dare',
      home: Scaffold(
        appBar: AppBar(
          title: Text(_rm),
        ),
      ),
    );
  }
}
