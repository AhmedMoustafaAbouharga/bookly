import 'dart:html';

import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});
  factory ServerFailure.fromDioErro(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        return ServerFailure(
            errorMessage: 'Connection time out with apiServer');

      case DioErrorType.sendTimeout:
        return ServerFailure(errorMessage: 'Send time out with apiServer');

      case DioErrorType.receiveTimeout:
        return ServerFailure(errorMessage: 'Recieve time out with apiServer');

      case DioErrorType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);

      case DioErrorType.cancel:
        return ServerFailure(
            errorMessage: 'Request to api server was canceled');

      case DioErrorType.connectionError:
        return ServerFailure(errorMessage: 'No iternet connection');

      case DioErrorType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure(errorMessage: 'No internet connection');
        } else {
          return ServerFailure(
              errorMessage: 'Unexpected error ,please try again later');
        }

      case DioExceptionType.badCertificate:
        return ServerFailure(errorMessage: 'There is incorrect certificat');
      default:
        return ServerFailure(
            errorMessage: 'Opps there was an error , please try agian');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errorMessage: response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure(
          errorMessage: 'Your request not found, please try again later');
    } else if (statusCode == 500) {
      return ServerFailure(errorMessage: 'Internal server error, try later');
    } else {
      return ServerFailure(
          errorMessage: 'Opps there was an error , please try agian');
    }
  }
}
