import 'package:http/http.dart' as http;
import 'package:odu_api/app/data/api/api_response.dart';
import 'package:odu_api/app/data/api/url/api_url.dart';
import 'package:odu_api/core/data/result.dart';

class ApiRequest {
  final client = http.Client();

  AsyncResult<ApiResponse> execute(ApiUrl url) async {
    final request = http.Request(url.method.name, url.value);
    final response = await client.send(request);
    final body = await response.stream.bytesToString();

    final cookies = <String, String>{};
    final setCookieHeaders = response.headers['set-cookie'];
    if (setCookieHeaders != null) {
      final cookieList = setCookieHeaders.split(',');
      for (final cookie in cookieList) {
        final parts = cookie.trim().split(';')[0].split('=');
        if (parts.length == 2) {
          cookies[parts[0].trim()] = parts[1].trim();
        }
      }
    }

    final data = ApiResponse(
      statusCode: response.statusCode,
      headers: response.headers,
      cookies: cookies,
      body: body,
    );
    return Result.ok(data);
  }
}
