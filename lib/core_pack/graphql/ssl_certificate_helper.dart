import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';

const String _kDevCertificate = "assets/certificate/dev_certificate.pem";
const String _kAlphaCertificate = "assets/certificate/alpha_certificate.pem";
const String _kPtCertificate = "assets/certificate/pt_certificate.pem";
const String _kStagingCertificate =
    "assets/certificate/staging_certificate.pem";

const String _kDevInternalCertificate =
    "assets/certificate/dev_internal_certificate.pem";
const String _kAlphaInternalCertificate =
    "assets/certificate/alpha_internal_certificate.pem";

const String _kPtInternalCertificate =
    "assets/certificate/pt_internal_certificate.pem";
const String _kStagingInternalCertificate =
    "assets/certificate/staging_internal_certificate.pem";

///TODO: change prod certificate once available
const String _kProdCertificate = "assets/certificate/alpha_certificate.pem";

class SslCertificateHelper {
  SslCertificateHelper._internal(
      {this.byteData, this.ioClient, this.securityContext, this.httpClient});
  static SslCertificateHelper shared = SslCertificateHelper._internal();
  final ByteData? byteData;
  final SecurityContext? securityContext;
  final HttpClient? httpClient;
  final IOClient? ioClient;

  IOClient? _cachedIOClient;

  factory SslCertificateHelper(
      {byteData, ioClient, securityContext, httpClient}) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return SslCertificateHelper._internal(
        byteData: byteData,
        httpClient: httpClient,
        ioClient: ioClient,
        securityContext: securityContext,
      );
    }
    return shared;
  }

  Future<IOClient> getIOClient({bool isExternal = true}) async {
    return _cachedIOClient ?? await _getHttpClient(isExternal: isExternal);
  }

  Future<IOClient> _getHttpClient({bool isExternal = true}) async {
    ByteData bytes = byteData ??
        await rootBundle.load(isExternal
            ? _getPublicCertificateUrl()
            : _getInternalCertificateUrl());
    SecurityContext sc =
        securityContext ?? SecurityContext(withTrustedRoots: false);
    sc.setTrustedCertificatesBytes(bytes.buffer.asInt8List());
    HttpClient http = this.httpClient ?? HttpClient(context: sc);
    final httpClient = ioClient ?? IOClient(http);
    _cachedIOClient = httpClient;
    printDebug("--------------ssl pinnning --------------------");
    return httpClient;
  }

  String _getPublicCertificateUrl() {
    switch (getLoginProvider().env) {
      case Environment.dev:
        return _kDevCertificate;
      case Environment.alpha:
        return _kAlphaCertificate;
      case Environment.prod:
        return _kProdCertificate;
      case Environment.pt:
        return _kPtCertificate;
      case Environment.staging:
        return _kStagingCertificate;
      case Environment.preprod:
        return _kProdCertificate;
    }
  }

  String _getInternalCertificateUrl() {
    switch (getLoginProvider().env) {
      case Environment.dev:
        return _kDevInternalCertificate;
      case Environment.alpha:
        return _kAlphaInternalCertificate;
      case Environment.prod:
        return _kProdCertificate;
      case Environment.pt:
        return _kPtInternalCertificate;
      case Environment.staging:
        return _kStagingInternalCertificate;
      case Environment.preprod:
        return _kPtInternalCertificate;
    }
  }
}
