import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:minipdfsign/core/constants/app_constants.dart';
import 'package:minipdfsign/data/models/recent_file_model.dart';

/// Local data source for recent files using SharedPreferences.
abstract class RecentFilesLocalDataSource {
  /// Retrieves all stored recent files.
  Future<List<RecentFileModel>> getRecentFiles();

  /// Saves the list of recent files.
  Future<void> saveRecentFiles(List<RecentFileModel> files);

  /// Clears all stored recent files.
  Future<void> clearRecentFiles();
}

/// Implementation of [RecentFilesLocalDataSource] using SharedPreferences.
class RecentFilesLocalDataSourceImpl implements RecentFilesLocalDataSource {
  final SharedPreferences _prefs;

  RecentFilesLocalDataSourceImpl(this._prefs);

  @override
  Future<List<RecentFileModel>> getRecentFiles() async {
    final jsonString = _prefs.getString(AppConstants.recentFilesKey);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((e) => RecentFileModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // If parsing fails, return empty list and clear corrupted data
      await clearRecentFiles();
      return [];
    }
  }

  @override
  Future<void> saveRecentFiles(List<RecentFileModel> files) async {
    final jsonList = files.map((f) => f.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    final success = await _prefs.setString(AppConstants.recentFilesKey, jsonString);
    if (!success) {
      throw Exception('SharedPreferences.setString returned false');
    }
  }

  @override
  Future<void> clearRecentFiles() async {
    await _prefs.remove(AppConstants.recentFilesKey);
  }
}
