import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:laseriea/config/constants.dart';
import 'package:laseriea/utils/logger_service.dart';
import 'package:laseriea/utils/utils.dart';
import 'package:universal_html/html.dart' as html;

class StorageService {
  final FlutterSecureStorage secureStorage;

  StorageService({required this.secureStorage});

  Future<void> saveData(Uint8List data) async {
    try {
      final base64String = tryEncode(data);

      if (base64String == null || base64String.isEmpty) {
        throw Exception('Error while encoding $data');
      }

      if (kIsWeb) {
        html.window.localStorage[storageKey] = base64String;
      } else {
        await secureStorage.write(
          key: storageKey,
          value: base64String,
        );
      }

      LoggerService.log(tag: 'StorageService', message: 'data saved $base64String');
    } catch (e) {
      LoggerService.log(tag: 'StorageService', message: 'Error while saving data $e');
    }
  }

  Future<Uint8List?> loadData() async {
    try {
      String? base64String;
      if (kIsWeb) {
        base64String = html.window.localStorage[storageKey];
      } else {
        base64String = await secureStorage.read(key: storageKey);
      }

      LoggerService.log(tag: 'StorageService', message: 'data loaded $base64String');

      return tryDecode(base64String);
    } catch (e) {
      LoggerService.log(tag: 'StorageService', message: 'Error while loading data $e');
      return null;
    }
  }

  Future<void> deleteData() async {
    try {
      if (kIsWeb) {
        html.window.localStorage.remove(storageKey);
      } else {
        await secureStorage.delete(key: storageKey);
      }
    } catch (e) {
      LoggerService.log(tag: 'StorageService', message: 'Error while deleting data $e');
    }
  }
}
