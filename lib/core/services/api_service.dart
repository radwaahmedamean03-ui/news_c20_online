import 'package:dio/dio.dart';

class ApiService {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://newsapi.org/v2/",
      headers: {"x-api-key": "f556556720b043808f44291838842268"},
    ),
  );
}
