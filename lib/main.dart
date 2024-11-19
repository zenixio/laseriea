import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laseriea/app.dart';
import 'package:laseriea/features/feed/domain/repositories/home_page_repository.dart';
import 'package:laseriea/features/feed/domain/repositories/home_page_repository_impl.dart';
import 'package:laseriea/utils/ig_launcher.dart';
import 'package:laseriea/utils/launcher_manager.dart';
import 'package:laseriea/utils/secure_storage.dart';
import 'package:dio/dio.dart';

final getIt = GetIt.I;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final launcherManager = LauncherManager();
  final igLauncher = IgLauncher(launcherManager: launcherManager);
  final imagePicker = ImagePicker();
  const storage = FlutterSecureStorage();
  final dio = Dio();
  final homePageRepo = HomePageRepositoryImpl();

  getIt
    ..registerSingleton<IgLauncher>(igLauncher)
    ..registerSingleton<ImagePicker>(imagePicker)
    ..registerSingleton<StorageService>(StorageService(secureStorage: storage))
    ..registerSingleton<Dio>(dio)
    ..registerSingleton<HomePageRepository>(homePageRepo);

  runApp(const LaSerieA());
}
