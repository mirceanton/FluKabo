import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flukabo/data/singletons/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class Failure {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;
}

class KanboardClient {
  static final KanboardClient _instance = KanboardClient._constructor();

  factory KanboardClient() => _instance;

  KanboardClient._constructor();

  bool _certCallback(X509Certificate certificate, String host, int port) =>
      UserPreferences().acceptAllCerts;

  HttpClient _createHttpClient() {
    final HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback = _certCallback;
    httpClient.connectionTimeout = const Duration(seconds: 5);
    return httpClient;
  }

  String _encodeAuth({@required String user, @required String token}) {
    final String auth = base64Encode(utf8.encode("$user: $token"));
    return 'Basic $auth';
  }

  Future<Response> sendRequest(String command) async {
    final String basicAuth = _encodeAuth(
      user: UserPreferences().userName,
      token: UserPreferences().token,
    );
    final HttpClient httpClient = _createHttpClient();
    final IOClient ioClient = IOClient(httpClient);
    Response response;

    final Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: basicAuth,
    };
    final String body = jsonEncode(
        {"jsonrpc": "2.0", "method": command, "id": Random().nextInt(123456)});

    try {
      response = await ioClient.post(
        UserPreferences().fullAddress,
        headers: header,
        body: body,
      );
      ioClient.close();
      switch (response.statusCode) {
        case 200:
          print('Response OK');
          return response;
        case 401:
          throw const Failure('Authentication failed. Incorrect credentials');
          break;
        case 403:
          throw const Failure('Action is forbidden');
          break;
        case 404:
          throw const Failure('404 not found');
          break;
        default:
          throw const Failure('Unknown error');
          break;
      }
    } on TimeoutException catch (e) {
      print('Timeout exception: $e');
      throw const Failure('Request timed out');
    } on SocketException catch (e) {
      print('Socket exception: $e');
      throw const Failure('No internet');
    } on HandshakeException catch (e) {
      print('Handshake exception: $e');
      throw const Failure('Certificate verification failed');
    } on FormatException catch (e) {
      print('Format exception: $e');
      throw const Failure('Bad format');
    }
  }
}
