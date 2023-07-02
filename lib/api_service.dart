import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://api.byteplex.info/api/test/contact/';

  Future<Response> sendDataToServer(Map<String, String> data) async {
    try {
      return await _dio.post(baseUrl, data: data);
    } catch (e) {
      rethrow;
    }
  }
}
