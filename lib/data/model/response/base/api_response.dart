import 'package:dio/dio.dart';

class ApiResponse {
  final Response? response;
  final dynamic message;

  ApiResponse(this.response, this.message);

  ApiResponse.withError(dynamic errorValue): response = null, message = errorValue;

  ApiResponse.withSuccess(Response responseValue)
      : response = responseValue,
        message = null;
}
