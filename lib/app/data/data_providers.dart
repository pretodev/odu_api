import 'package:odu_api/app/data/api/api_request.dart';
import 'package:odu_api/app/data/endpoints/endpoint_repository.dart';
import 'package:odu_api/core/data/json_file_collection/json_file_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_providers.g.dart';

@Riverpod(keepAlive: true)
ApiRequest apiRequest(Ref ref) {
  return ApiRequest();
}

@Riverpod(keepAlive: true)
EndpointRepository endpointRepository(Ref ref) {
  return EndpointRepository(
    jsonFileStorage: ref.read(jsonFileStorageProvider),
  );
}

// core/data
@Riverpod(keepAlive: true)
JsonFileStorage jsonFileStorage(Ref ref) {
  return JsonFileStorage(path: "/Users/silas/brasil_api.odu.json");
}
