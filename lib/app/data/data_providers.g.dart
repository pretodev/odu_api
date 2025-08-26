// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(apiRequest)
const apiRequestProvider = ApiRequestProvider._();

final class ApiRequestProvider
    extends $FunctionalProvider<ApiRequest, ApiRequest, ApiRequest>
    with $Provider<ApiRequest> {
  const ApiRequestProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiRequestProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiRequestHash();

  @$internal
  @override
  $ProviderElement<ApiRequest> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiRequest create(Ref ref) {
    return apiRequest(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiRequest value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiRequest>(value),
    );
  }
}

String _$apiRequestHash() => r'884dc081fcc9fbe184b2b012276b7181ec23097a';

@ProviderFor(endpointRepository)
const endpointRepositoryProvider = EndpointRepositoryProvider._();

final class EndpointRepositoryProvider
    extends
        $FunctionalProvider<
          EndpointRepository,
          EndpointRepository,
          EndpointRepository
        >
    with $Provider<EndpointRepository> {
  const EndpointRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'endpointRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$endpointRepositoryHash();

  @$internal
  @override
  $ProviderElement<EndpointRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EndpointRepository create(Ref ref) {
    return endpointRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EndpointRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EndpointRepository>(value),
    );
  }
}

String _$endpointRepositoryHash() =>
    r'86cf232970ca7c9d7522ea9373e61fcd86130a07';

@ProviderFor(jsonFileStorage)
const jsonFileStorageProvider = JsonFileStorageProvider._();

final class JsonFileStorageProvider
    extends
        $FunctionalProvider<JsonFileStorage, JsonFileStorage, JsonFileStorage>
    with $Provider<JsonFileStorage> {
  const JsonFileStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jsonFileStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jsonFileStorageHash();

  @$internal
  @override
  $ProviderElement<JsonFileStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  JsonFileStorage create(Ref ref) {
    return jsonFileStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JsonFileStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JsonFileStorage>(value),
    );
  }
}

String _$jsonFileStorageHash() => r'59d74572544ba34e5c21aba5124074b32fd099d8';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
