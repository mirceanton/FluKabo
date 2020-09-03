import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flukabo/data/singletons/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

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
    @required Map<String, String> params,
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
    @required Map<String, String> params,
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
}
