import 'dart:io';

import 'package:http/http.dart' as http;

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      if (error is HttpException) {
        errorDescription = error.message;
      } else if (error is FormatException) {
        errorDescription = error.message;
      } else if (error is SocketException) {
        errorDescription = error.message;
      } else {
        errorDescription = "Unexpected error occured";
      }
    } else if (error is http.Response) {
      switch (error.statusCode) {
        case 401:
          errorDescription = "UN Authorized";
          break;
        case 404:
          errorDescription = "Not found";
          break;
        case 500:
        case 503:
          errorDescription = "Server Error";
          break;
        default:
          errorDescription = "Server Error";
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}
