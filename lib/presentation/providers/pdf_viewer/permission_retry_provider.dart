import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for tracking permission retry state.
///
/// When true, the PDF viewer shows a loading state instead of error
/// while waiting for the user to grant folder access permission.
final permissionRetryProvider = StateProvider<bool>((ref) => false);
