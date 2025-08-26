import 'package:odu_api/app/data/endpoints/endpoint.dart';
import 'package:odu_api/core/data/json_file_collection/json_file_collection.dart';

class EndpointJsonConverter implements JsonFileConverter<Endpoint> {
  @override
  Endpoint fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson(Endpoint object) {
    return {
      'title': object.title,
      'description': object.description,
      'url': {
        'base': object.url.base,
        'path': object.url.path,
        'method': object.url.method.name,
      },
    };
  }
}
