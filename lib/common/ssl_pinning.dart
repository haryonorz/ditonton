import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

class SSLPinning {
  static Future<HttpClient> customHttpClient() async {
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    try {
      final sslCert = await rootBundle.load('certificates/certificates.pem');
      securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
      log('createHttpClient() - cert added!');
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        log('createHttpClient() - cert already trusted! Skipping.');
      } else {
        log('createHttpClient().setTrustedCertificateBytes EXCEPTION: $e');
        rethrow;
      }
    } catch (e) {
      log('unexpected error $e');
      rethrow;
    }
    HttpClient httpClient = HttpClient(context: securityContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    return httpClient;
  }

  static Future<http.Client> createLEClient() async {
    IOClient client = IOClient(await SSLPinning.customHttpClient());
    return client;
  }
}
