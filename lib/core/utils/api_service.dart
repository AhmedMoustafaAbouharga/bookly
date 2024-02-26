import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://www.googleapis.com/books/v1/';
  ApiService(this.dio);
  Dio dio = Dio();
  Future<Map<String, dynamic>> getData(String url) async {
    var response = await dio.get('$_baseUrl$url');
    return response.data;
  }
}
