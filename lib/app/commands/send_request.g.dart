// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_request.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(SendRequest)
const sendRequestProvider = SendRequestProvider._();

final class SendRequestProvider
    extends $NotifierProvider<SendRequest, AsyncValue<ApiResponse>> {
  const SendRequestProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendRequestProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendRequestHash();

  @$internal
  @override
  SendRequest create() => SendRequest();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<ApiResponse> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<ApiResponse>>(value),
    );
  }
}

String _$sendRequestHash() => r'0d573ff93222f8d9c33a2b68d4a90c9d936c5842';

abstract class _$SendRequest extends $Notifier<AsyncValue<ApiResponse>> {
  AsyncValue<ApiResponse> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<ApiResponse>, AsyncValue<ApiResponse>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ApiResponse>, AsyncValue<ApiResponse>>,
              AsyncValue<ApiResponse>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
