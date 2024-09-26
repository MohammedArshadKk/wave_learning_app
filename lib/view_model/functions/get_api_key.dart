import 'package:flutter_dotenv/flutter_dotenv.dart';

String getApiKey(String key) {
  final apiKeyFromDefine = String.fromEnvironment(key, defaultValue: '');

  if (apiKeyFromDefine.isNotEmpty) {
    return apiKeyFromDefine;
  }

  return dotenv.env[key] ?? '';
}
