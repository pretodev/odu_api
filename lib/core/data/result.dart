/// Used instead of `void` as a return statement for a function
/// when no value is to be returned.
///
/// There is only one value of type [Unit].
final class Unit {
  const Unit._();
}

const unit = Unit._();

/// Type alias for a future that resolves to a [Result].
///
/// ```dart
/// AsyncResult<int> fetchData() async {
///   return Result.ok(42);
/// }
/// ```
typedef AsyncResult<T> = Future<Result<T>>;

/// Utility class to wrap result data
///
/// Evaluate the result using a switch statement:
/// ```dart
/// switch (result) {
///   case Ok(): {
///     print(result.value);
///   }
///   case Error(): {
///     print(result.error);
///   }
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// Creates a successful [Result] with a [Unit] value.
  static Result<Unit> get unit => const Result.ok(Unit._());

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.ok(T value) = Ok._;

  /// Creates an error [Result], completed with the specified [error].
  const factory Result.error(Exception error, [StackTrace? stackTrace]) =
      Error._;
}

/// Subclass of Result for values
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  /// Returned value in result
  final T value;

  @override
  String toString() => "Result<$T>.ok($value)";
}

/// Subclass of Result for errors
final class Error<T> extends Result<T> {
  const Error._(this.error, [this.stackTrace]);

  /// Returned error in result
  final Exception error;

  final StackTrace? stackTrace;

  @override
  String toString() => "Result<$T>.error($error, $stackTrace)";
}
