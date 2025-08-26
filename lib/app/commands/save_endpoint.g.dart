// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_endpoint.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(SaveEndpoint)
const saveEndpointProvider = SaveEndpointProvider._();

final class SaveEndpointProvider
    extends $NotifierProvider<SaveEndpoint, AsyncValue<Unit>> {
  const SaveEndpointProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveEndpointProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveEndpointHash();

  @$internal
  @override
  SaveEndpoint create() => SaveEndpoint();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<Unit> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<Unit>>(value),
    );
  }
}

String _$saveEndpointHash() => r'223034cd1d94437d91da6d85e1ab677907e7d4fd';

abstract class _$SaveEndpoint extends $Notifier<AsyncValue<Unit>> {
  AsyncValue<Unit> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Unit>, AsyncValue<Unit>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Unit>, AsyncValue<Unit>>,
              AsyncValue<Unit>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
