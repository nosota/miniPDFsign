import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:minipdfsign/core/errors/failure.dart';
import 'package:minipdfsign/core/errors/failures.dart';
import 'package:minipdfsign/data/datasources/file_picker_data_source.dart';
import 'package:minipdfsign/domain/repositories/file_picker_repository.dart';

/// Concrete implementation of [FilePickerRepository].
class FilePickerRepositoryImpl implements FilePickerRepository {
  final FilePickerDataSource _dataSource;

  FilePickerRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, String?>> pickPdfFile() async {
    try {
      final path = await _dataSource.pickPdfFile();
      return Right(path);
    } on PlatformException catch (e) {
      return Left(FileAccessFailure(
        message: 'File picker error: ${e.message}',
      ));
    } catch (e) {
      return Left(UnknownFailure(
        message: 'Unexpected error while picking file: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, PickedFile?>> pickPdfOrImage() async {
    try {
      final result = await _dataSource.pickPdfOrImage();
      if (result == null) return const Right(null);

      return Right(PickedFile(
        path: result.path,
        isPdf: result.isPdf,
      ));
    } on PlatformException catch (e) {
      return Left(FileAccessFailure(
        message: 'File picker error: ${e.message}',
      ));
    } catch (e) {
      return Left(UnknownFailure(
        message: 'Unexpected error while picking file: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> fileExists(String path) async {
    try {
      final exists = await _dataSource.fileExists(path);
      return Right(exists);
    } catch (e) {
      return Left(FileAccessFailure(
        message: 'Cannot check file existence: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, int>> getFileSize(String path) async {
    try {
      final size = await _dataSource.getFileSize(path);
      return Right(size);
    } catch (e) {
      return Left(FileAccessFailure(
        message: 'Cannot get file size: $e',
      ));
    }
  }
}
