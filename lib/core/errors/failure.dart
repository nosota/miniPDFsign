import 'package:equatable/equatable.dart';

/// Base failure class for domain-level error handling.
///
/// All specific failures extend this class to provide type-safe
/// error handling using the Either pattern from dartz.
///
/// Example:
/// ```dart
/// Future<Either<Failure, List<RecentFile>>> getRecentFiles();
/// ```
abstract class Failure extends Equatable {
  /// Human-readable error message for display or logging.
  final String message;

  /// Optional error code for programmatic handling.
  final String? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}
