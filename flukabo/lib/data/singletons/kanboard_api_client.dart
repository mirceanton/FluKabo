import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class Failure implements Exception {
  final String message;

  const Failure(this.message);
}

class KanboardAPI {
  static final KanboardAPI _instance = KanboardAPI._constructor();

  factory KanboardAPI() => _instance;

  KanboardAPI._constructor();

  String _encodeAuth({@required String user, @required String token}) =>
      'Basic ${base64Encode(utf8.encode("$user:$token"))}';

  Map<String, String> _getHeaders(String user, String token) => {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: _encodeAuth(user: user, token: token),
      };

  HttpClient _customClient(bool acceptCerts) {
    final HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback = (_cert, _host, _port) => acceptCerts;
    httpClient.connectionTimeout = const Duration(seconds: 3);
    return httpClient;
  }

  Future<Response> _sendRequest({
    @required String url,
    @required String user,
    @required String token,
    @required bool acceptCerts,
    @required String command,
  }) async {
    final HttpClient httpClient = _customClient(acceptCerts);
    final IOClient ioClient = IOClient(httpClient);
    final Map<String, String> headers = _getHeaders(user, token);
    final String body =
        jsonEncode({"jsonrpc": "2.0", "method": command, "id": 1});
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
      );
}
