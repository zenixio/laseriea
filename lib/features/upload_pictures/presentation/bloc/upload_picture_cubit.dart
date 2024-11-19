import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laseriea/features/upload_pictures/presentation/bloc/upload_picture_state.dart';
import 'package:laseriea/main.dart';
import 'package:laseriea/utils/logger_service.dart';
import 'package:laseriea/utils/secure_storage.dart';

/// By default we allow only formats like png, jpg, jpeg, bmp which are standard formats
/// We set a size of 20 mb for file

class UploadPictureCubit extends Cubit<UploadPictureState> {
  UploadPictureCubit() : super(const UploadPictureState());

  final _picker =
      getIt.isRegistered<ImagePicker>() ? getIt.get<ImagePicker>() : null;

  Future<void> loadFromStorage() async {
    if (getIt.isRegistered<StorageService>()) {
      final data = await getIt.get<StorageService>().loadData();

      if (data != null) {
        emit(state.copyWith(imageBytes: data));
      }
    }

    return Future.value();
  }

  void removeImage() {
    LoggerService.log(tag: 'UploadPictureState', message: 'removeImage called');
    emit(const UploadPictureState());
  }

  Future<void> pickFile({
    required VoidCallback onLoadingEntry,
    required VoidCallback onLoadingExit,
    required VoidCallback onError,
    required VoidCallback onSizeError,
  }) async {
    LoggerService.log(
      tag: 'UploadPictureCubit',
      message: '_pickFile called',
    );

    try {
      onLoadingEntry();
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'bmp', 'jpeg'],
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.firstOrNull;
        if (file != null) {
          LoggerService.log(
            tag: 'UploadPictureCubit',
            message: '_pickFile: file selected: ${file.name}',
          );

          if (file.size > 20000) {
            // MAX 20 MB
            LoggerService.log(
              tag: 'UploadPictureCubit',
              message:
                  '_pickFile: file size is bigger than 20 mb => ${file.size}',
            );
            onSizeError();
          } else {
            saveToStorage(file.bytes);

            emit(
              state.copyWith(
                imageBytes: file.bytes,
                formatChoosen: file.extension,
              ),
            );
          }
        }
      } else {
        LoggerService.log(
          tag: 'UploadPictureCubit',
          message: '_pickFile: no file selected',
        );
        onError();
      }
    } catch (e) {
      LoggerService.log(
        tag: 'UploadPictureCubit',
        message: '_pickFile: error during file selection: $e',
      );
      onError();
    } finally {
      onLoadingExit();
    }
  }

  void saveToStorage(Uint8List? bytes) {
    if (bytes != null) {
      if (getIt.isRegistered<StorageService>()) {
        getIt.get<StorageService>().saveData(bytes);
      }
    }
  }

  Future<void> pickImageFromGallery({
    required VoidCallback onError,
    required VoidCallback onLoadingEntry,
    required VoidCallback onLoadingExit,
    required VoidCallback onSizeError,
  }) async {
    LoggerService.log(
        tag: 'UploadPictureState', message: 'pickImageFromGallery called');

    try {
      onLoadingEntry();
      final pickedFile = await _picker?.pickImage(source: ImageSource.gallery);
      if (pickedFile != null &&
          (pickedFile.path.endsWith('.jpeg') ||
              pickedFile.path.endsWith('.jpg') ||
              pickedFile.path.endsWith('.png') ||
              pickedFile.path.endsWith('.bmp'))) {
        LoggerService.log(
            tag: 'UploadPictureState',
            message: 'pickImageFromGallery  File picked: ${pickedFile.path}');

        final bytes = await pickedFile.readAsBytes();

        const twentyMB = 20 * 1024 * 1024; // 20 MB
        if (bytes.lengthInBytes > twentyMB) {
          throw 'File bigger than 20MB';
        } else {
          onLoadingExit();
          saveToStorage(bytes);
          emit(
            state.copyWith(
              imageBytes: bytes,
              formatChoosen: pickedFile.path.split('.').last,
            ),
          );
        }
      } else {
        LoggerService.log(
            tag: 'UploadPictureState',
            message: 'pickImageFromGallery No valid file picked');

        throw Exception('No valid file picked');
      }
    } catch (e) {
      onLoadingExit();

      if (e == 'File bigger than 20MB') {
        onSizeError();
      } else {
        onError();
      }

      LoggerService.log(
          tag: 'UploadPictureState', message: 'pickImageFromGallery error: $e');
    }

    return Future.value();
  }

  Future<void> captureImageWithCamera({
    required VoidCallback onError,
    required VoidCallback onLoadingEntry,
    required VoidCallback onLoadingExit,
  }) async {
    LoggerService.log(
        tag: 'UploadPictureState', message: 'captureImageWithCamera called');
    try {
      onLoadingEntry();
      final pickedFile = await _picker?.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        LoggerService.log(
            tag: 'UploadPictureState',
            message:
                'captureImageWithCamera: Image captured: ${pickedFile.path}');

        final bytes = await pickedFile.readAsBytes();
        const twentyMB = 20 * 1024 * 1024;
        if (bytes.lengthInBytes > twentyMB) {
          throw Exception('File bigger than 20MB');
        } else {
          onLoadingExit();
          saveToStorage(bytes);
          emit(state.copyWith(imageBytes: bytes));
        }
      } else {
        LoggerService.log(
            tag: 'UploadPictureState',
            message: 'captureImageWithCamera: No image captured');
        throw Exception('No image captured');
      }
    } catch (e) {
      onLoadingExit();
      onError();

      LoggerService.log(
          tag: 'UploadPictureState',
          message: 'captureImageWithCamera: error: $e');
    }

    return Future.value();
  }

  @override
  void emit(UploadPictureState state) {
    if (isClosed) {
      return;
    }
    super.emit(state);
  }
}
