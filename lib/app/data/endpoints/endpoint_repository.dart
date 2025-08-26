import 'package:odu_api/app/data/endpoints/endpoint.dart';
import 'package:odu_api/app/data/endpoints/json_converters/endpoint_json_converter.dart';
import 'package:odu_api/core/data/json_file_collection/json_file_collection.dart';
import 'package:odu_api/core/data/result.dart';

class EndpointRepository {
  EndpointRepository({
    required JsonFileStorage jsonFileStorage,
  }) : _jsonFileStorage = jsonFileStorage;

  final JsonFileStorage _jsonFileStorage;

  AsyncResult<Unit> store(Endpoint endpoint) async {
    await _jsonFileStorage
        .ref('endpoints/${endpoint.id}')
        .withConverter(EndpointJsonConverter())
        .set(endpoint, merge: true);
    return Result.ok(unit);
  }
}
