enum HttpMethodOptions {
  get,
  post,
  put,
  delete,
  patch,
  head,
  options;

  const HttpMethodOptions();
}

abstract interface class HttpMethod {
  String get name;
}

class CustomHttpMethod implements HttpMethod {
  const CustomHttpMethod(this.name);

  @override
  final String name;

  @override
  String toString() => name;
}

class ClassicHttpMethod implements HttpMethod {
  const ClassicHttpMethod(this.method);

  final HttpMethodOptions method;

  @override
  String get name => method.name.toUpperCase();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassicHttpMethod && other.method == method;
  }

  @override
  int get hashCode => method.hashCode;

  @override
  String toString() => name;
}
