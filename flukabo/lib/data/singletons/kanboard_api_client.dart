import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import '../../data/helpers/json_parser.dart';
import '../../data/models/abstract_model.dart';
import '../../data/models/board.dart';
import '../../data/singletons/user_preferences.dart';

/// Custom Error class
class Failure implements Exception {
  final String message;
  const Failure(this.message);
}

/// A singleton meant to handle all the API calls to the Kanbaord Server
class KanboardAPI {
  static final KanboardAPI _instance = KanboardAPI._constructor();
  factory KanboardAPI() => _instance;
  KanboardAPI._constructor();

  /// [_encodeAuth] encodes the user and token for the http header
  String _encodeAuth({@required String user, @required String token}) =>
      'Basic ${base64Encode(utf8.encode("$user:$token"))}';

  /// [_getBasicHeader] returns the header with the content type and auth only
  Map<String, String> _getBasicHeader(String user, String token) => {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: _encodeAuth(user: user, token: token),
      };

  ///
  /// [_getHttpClient] returns a custom http client with a 3sec timeout and
  /// custom badCertificateCallback method
  ///
  HttpClient _getHttpClient(bool acceptCerts) {
    final HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback = (_cert, _host, _port) => acceptCerts;
    httpClient.connectionTimeout = const Duration(seconds: 3);
    return httpClient;
  }

  ///
  /// [_sendRequest] handles sending a post request to the Kanboard Server
  /// and throws a [Failure] if an exception is caught
  ///
  Future<Response> _sendRequest({
    @required String url,
    @required String user,
    @required String token,
    @required bool acceptCerts,
    @required String command,
    @required Map<String, dynamic> params,
  }) async {
    final HttpClient httpClient = _getHttpClient(acceptCerts);
    final IOClient ioClient = IOClient(httpClient);
    final Map<String, String> headers = _getBasicHeader(user, token);
    final String body = jsonEncode(
        {"jsonrpc": "2.0", "method": command, "id": 1, "params": params});
    Response response;

    try {
      response = await ioClient.post(url, headers: headers, body: body);
      ioClient.close();
      switch (response.statusCode) {
        case 200:
          return response;
        case 401:
          throw const Failure('Authentication Failed.');
          break;
        case 403:
          throw const Failure('Operation not permitted.');
          break;
        case 404:
          throw const Failure('404 not found');
          break;
        default:
          throw const Failure('Unknown error');
          break;
      }
    } on SocketException catch (_) {
      throw const Failure('Socket Exception');
    } on TimeoutException catch (_) {
      throw const Failure('Timeout exception');
    } on HttpException catch (_) {
      throw const Failure('Http exception');
    } on HandshakeException catch (_) {
      throw const Failure('Handshake exception');
    } on FormatException catch (_) {
      throw const Failure('Format Exception');
    } on OSError catch (_) {
      throw const Failure('OS Exception');
    }
  }

  ///
  /// [testConnection] sends a dummy 'getVersion' request in order to see if
  /// the credentials and server address are right
  ///
  Future<Response> testConnection({
    @required String url,
    @required String user,
    @required String token,
    @required bool acceptCerts,
  }) =>
      _sendRequest(
        url: url,
        user: user,
        token: token,
        acceptCerts: acceptCerts,
        command: 'getVersion',
        params: null,
      );

  ///
  /// [getJson] embeds the [command] into the request and returns the raw json
  /// response body
  ///
  Future<String> getJson({
    @required String command,
    @required Map<String, dynamic> params,
  }) async {
    final Response response = await _sendRequest(
      url: UserPreferences().fullAddress,
      user: UserPreferences().userName,
      token: UserPreferences().token,
      acceptCerts: UserPreferences().acceptAllCerts,
      command: command,
      params: params,
    );
    return response.body;
  }

  Future<bool> getBool({
    @required String command,
    @required Map<String, dynamic> params,
  }) async {
    final String result = await getString(command: command, params: params);
    final bool value = parseToBool(result);
    return value;
  }

  Future<int> getInt({
    @required String command,
    @required Map<String, dynamic> params,
  }) async {
    final String result = await getString(command: command, params: params);
    final int value = parseToInt(result);
    return value;
  }

  Future<String> getString({
    @required String command,
    @required Map<String, dynamic> params,
  }) async {
    final Response response = await _sendRequest(
      url: UserPreferences().fullAddress,
      user: UserPreferences().userName,
      token: UserPreferences().token,
      acceptCerts: UserPreferences().acceptAllCerts,
      command: command,
      params: params,
    );
    final String body = jsonDecode(response.body)['result'].toString();
    if (body == 'false' || body == 'null' || body.isEmpty) {
      print('Request failed.');
      throw const Failure('Failed request for integer value.');
    } else {
      print('Request succeded.');
      return body;
    }
  }

  Future<Map<T1, T2>> getMap<T1, T2>({
    @required String command,
    @required Map<String, dynamic> params,
  }) async {
    final String json = await KanboardAPI().getJson(
      command: command,
      params: params,
    );
    final Map<dynamic, dynamic> result =
        jsonDecode(json)['result'] as Map<dynamic, dynamic>;
    if (result != null) {
      print('Request succeded.');
      return Map<T1, T2>.from(result);
    } else {
      print('Request failed.');
      throw const Failure('Failed request for map');
    }
  }

  Future<T> getObject<T extends AbstractDataModel>({
    @required String command,
    @required Map<String, dynamic> params,
  }) async {
    final Response response = await _sendRequest(
      url: UserPreferences().fullAddress,
      user: UserPreferences().userName,
      token: UserPreferences().token,
      acceptCerts: UserPreferences().acceptAllCerts,
      command: command,
      params: params,
    );
    final Map<String, dynamic> body =
        jsonDecode(response.body) as Map<String, dynamic>;
    if (body['result'] == null) {
      print('Request failed.');
      throw const Failure('Failed request to fetch object.');
    } else {
      T object;
      if (T == BoardModel) {
        object = parseToObject<T>(body);
      } else {
        object = parseToObject<T>(body['result'] as Map<String, dynamic>);
      }
      print('Successfully fetched ${object.type}');
      return object;
    }
  }

  Future<List<T>> getObjectList<T extends AbstractDataModel>({
    @required String command,
    @required Map<String, dynamic> params,
  }) async {
    final Response response = await _sendRequest(
      url: UserPreferences().fullAddress,
      user: UserPreferences().userName,
      token: UserPreferences().token,
      acceptCerts: UserPreferences().acceptAllCerts,
      command: command,
      params: params,
    );
    final List result = jsonDecode(response.body)['result'] as List;
    if (result == null) {
      print('Failed to fetch object list.');
      throw const Failure('Failed to fetch object list.');
    } else {
      if (result.isEmpty) {
        print('Successfully fetched an empty list.');
        return [];
      } else {
        final List<T> objects = parseToList<T>(result);
        print('Successfully fetched ${objects.length} ${objects[0].type}');
        return objects;
      }
    }
  }
}
