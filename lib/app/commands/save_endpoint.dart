import 'package:odu_api/app/data/data_providers.dart';
import 'package:odu_api/app/data/endpoints/endpoint.dart';
import 'package:odu_api/core/data/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'save_endpoint.g.dart';

@riverpod
class SaveEndpoint extends _$SaveEndpoint {
  @override
  AsyncValue<Unit> build() {
    return const AsyncData(unit);
  }

  Future<void> call(Endpoint endpoint) async {
    state = const AsyncLoading();
    final result = await ref.read(endpointRepositoryProvider).store(endpoint);
    state = switch (result) {
      Ok() => AsyncData(result.value),
      Error() => AsyncError(
        result.error,
        result.stackTrace ?? StackTrace.current,
      ),
    };
  }
}
