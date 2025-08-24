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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
