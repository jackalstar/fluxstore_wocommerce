/// This library is customize from the woocommerce_api: ^0.0.8
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io' show HttpClient, X509Certificate;

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../../../common/constants.dart';
import '../../../common/packages.dart';

class VendorAdminAPI {
  String url;

  VendorAdminAPI({this.url});

  Uri _getOAuthURL(String requestMethod, String endpoint) {
    return '$url/wp-json/wcfm/v1/$endpoint'.toUri();
  }

  Future<dynamic> getAsync(String endPoint) async {
    var url = _getOAuthURL('GET', endPoint);
    var response;

    if (debugNetworkProxy) {
      var proxy = isAndroid ? '192.168.1.10:8888' : 'localhost:9090';
      var httpClient = HttpClient();
      httpClient.findProxy = (uri) => 'PROXY $proxy;';
      httpClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => isAndroid);
      var myClient = IOClient(httpClient);
      response = await myClient.get(url);
    } else {
      response = await http.get(url);
    }

    return json.decode(response.body);
  }
}
