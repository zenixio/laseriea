import 'package:dio/dio.dart';
import 'package:laseriea/config/urls.dart';
import 'package:laseriea/features/feed/domain/repositories/home_page_repository.dart';
import 'package:laseriea/main.dart';
import 'package:laseriea/utils/logger_service.dart';

class HomePageRepositoryImpl extends HomePageRepository {
  @override
  Future<dynamic> getFeedData() async {
    try {
      if (getIt.isRegistered<Dio>()) {
        final dio = getIt.get<Dio>();

        final response = await dio.get(Urls.gazzettaFeed);

        return response.data;
      } else {
        throw 'Dio not registered';
      }
    } catch (e) {
      LoggerService.log(
          tag: 'HomePageRepositoryImpl',
          message: 'Error while fetching data $e');
      return null;
    }
  }
}
