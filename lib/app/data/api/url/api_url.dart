import 'package:odu_api/app/data/api/url/methods.dart';

class ApiUrl {
  const ApiUrl({
    required this.base,
    required this.path,
    required this.method,
  });

  final String base;
  final HttpMethod method;
  final String path;

  @override
  String toString() => '''RequestUrl(method: $method, path: $path)''';

  Uri get value {
    var baseRaw = base;
    if (base.endsWith('/')) {
      baseRaw = base.substring(0, base.length - 1);
    }
    var pathRaw = path;
    if (path.startsWith('/')) {
      pathRaw = path.substring(1);
    }
    return Uri.parse('$baseRaw/$pathRaw');
  }

  ApiUrl copyWith({
    String? baseUrl,
    HttpMethod? method,
    String? path,
  }) {
    return ApiUrl(
      base: baseUrl ?? base,
      method: method ?? this.method,
      path: path ?? this.path,
    );
  }
}
