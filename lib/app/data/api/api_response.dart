import 'package:flutter/foundation.dart';

enum ContentType { json, html, xml, text }

class ApiResponse {
  ApiResponse({
    required this.statusCode,
    this.headers = const {},
    this.cookies = const {},
    this.body,
  });

  final int statusCode;
  final Map<String, String> headers;
  final Map<String, String> cookies;
  final String? body;

  ContentType get contentType {
    final contentType = headers['content-type']?.toLowerCase() ?? '';
    if (contentType.contains('application/json')) {
      return ContentType.json;
    } else if (contentType.contains('text/html')) {
      return ContentType.html;
    } else if (contentType.contains('application/xml') ||
        contentType.contains('text/xml')) {
      return ContentType.xml;
    } else {
      return ContentType.text;
    }
  }

  ApiResponse copyWith({
    int? statusCode,
    Map<String, String>? headers,
    Map<String, String>? cookies,
    String? body,
  }) {
    return ApiResponse(
      statusCode: statusCode ?? this.statusCode,
      headers: headers ?? this.headers,
      cookies: cookies ?? this.cookies,
      body: body ?? this.body,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiResponse &&
        other.statusCode == statusCode &&
        mapEquals(other.headers, headers) &&
        mapEquals(other.cookies, cookies) &&
        other.body == body;
  }

  @override
  int get hashCode {
    return statusCode.hashCode ^
        headers.hashCode ^
        cookies.hashCode ^
        body.hashCode;
  }

  @override
  String toString() {
    return '''ApiResponse(statusCode: $statusCode, headers: $headers, cookies: $cookies, body: $body)''';
  }
}
