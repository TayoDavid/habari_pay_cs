import 'package:dio/dio.dart';
import 'package:habari_pay_cs/utils/env_config.dart';
import 'package:tuple/tuple.dart';

const successCode = [200, 201];

class NetworkClient {
  late final Dio _dio;

  late var logInterceptor = LogInterceptor(
    error: true,
    request: true,
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
  );

  NetworkClient({
    required String baseUrl,
    required String privateKey,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        responseType: ResponseType.json,
        headers: {'Authorization': privateKey},
      ),
    )..interceptors.add(logInterceptor);
  }

  Future<Tuple2<Response?, Exception?>> post(String endpoint, {required dynamic body}) async {
    try {
      Response response = await _dio.post(endpoint, data: body);
      return Tuple2(response, null);
    } on Exception catch (e) {
      return Tuple2(null, e);
    }
  }

  Future<Tuple2<Response?, Exception?>> get(
    String endpoint, {
    Map<String, dynamic> param = const {},
  }) async {
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://sandbox-api-d.squadco.com/',
          responseType: ResponseType.json,
          headers: {'Authorization': Environment.secretKey},
        ),
      )..interceptors.add(logInterceptor);
      Response response = await dio.get(endpoint, queryParameters: param);
      return Tuple2(response, null);
    } on Exception catch (e) {
      return Tuple2(null, e);
    }
  }
}
