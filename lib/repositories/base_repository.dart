import 'dart:convert';
import 'dart:io';

import 'package:exception_handling/models/model.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:logger/logger.dart';

typedef JsonMap = Map<String, dynamic>;

abstract class BaseRepository<T> {
  static String? _baseUrl;
  static http.Client _client = RetryClient(http.Client());

  String get serviceURL;

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  static Future<void> configure({
    String? baseUrl,
    String? accessToken,
  }) async {
    if (baseUrl != null) {
      _client = http.Client();
      BaseRepository._baseUrl = baseUrl;

      if (_baseUrl != null) {
        await _client.head(
          Uri.https(_baseUrl!),
          headers: _headers(accessToken ?? ""),
        );
      }
    }
  }

  static Map<String, String> _headers(String? accessToken) {
    accessToken ??= "";

    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    };
  }

  BaseRepository() {
    if (_baseUrl == null) {
      throw Exception(
        "URL not provided before creating Repository"
        " Did you forget to BaseRepository.configure(baseUrl: 'url_here')",
      );
    }
  }

  T toT(JsonMap data) {
    Model m = ModelFactory.getModel(T, data);
    return (m as T);
  }

  Future<List<T>> get({Map<String, dynamic>? query}) async {
    String accessToken = '';

    try {
      final uri = Uri.https(_baseUrl!, serviceURL, query);

      final response = await _client.get(uri, headers: _headers(accessToken));

      _logger.d(response.body);

      var body = json.decode(response.body) as List<dynamic>;
      var jsonList = (body).map((e) => JsonMap.from(e)).toList();
      List<T> data = jsonList.map(toT).toList();
      return data;
    } on HttpException catch (e) {
      _logger.e(e.message);
      throw e.message;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<T> getById(String id, {Map<String, dynamic>? query}) async {
    try {
      final uri = Uri.https(_baseUrl!, "$serviceURL/$id", query);

      final response = await _client.get(uri, headers: _headers(null));

      _logger.d(response.body);

      T data = toT(jsonDecode(response.body));
      return data;
    } on HttpException catch (e) {
      _logger.e(e.message);
      throw e.message;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<T> create(T model) async {
    model as Model;
    try {
      final uri = Uri.https(_baseUrl!, serviceURL);

      final response = await _client.post(
        uri,
        body: model.toJson(),
        headers: _headers(null),
      );
      _logger.d(response.body);

      T data = toT(jsonDecode(response.body));
      return data;
    } on HttpException catch (e) {
      _logger.e(e.message);
      throw e.message;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<T> update(T model) async {
    model as Model;
    try {
      final uri = Uri.https(_baseUrl!, "$serviceURL/${model.id}");

      final response = await _client.patch(
        uri,
        body: model.toJson(),
        headers: _headers(null),
      );
      _logger.i(response.body);

      T data = toT(jsonDecode(response.body));
      return data;
    } on HttpException catch (e) {
      _logger.e(e.message);
      throw e.message;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<void> delete(T model) async {
    model as Model;
    try {
      final uri = Uri.https(_baseUrl!, "$serviceURL/${model.id}");

      final response = await _client.delete(uri, headers: _headers(null));

      _logger.i(jsonDecode(response.body));
    } on HttpException catch (e) {
      _logger.e(e.message);
      throw e.message;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}
