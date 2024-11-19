import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laseriea/features/feed/domain/repositories/home_page_repository.dart';
import 'package:laseriea/features/feed/presentation/bloc/home_page_state.dart';
import 'package:laseriea/main.dart';
import 'package:xml/xml.dart';

import '../../domain/entities/feed_item.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageState());

  Future<void> getFeed() async {
    final repo = getIt.get<HomePageRepository>();

    emit(state.copyWith(isLoading: true));
    final data = await repo.getFeedData();
    emit(state.copyWith(isLoading: false));

    final document = XmlDocument.parse(data);
    Iterable<XmlElement> items = [];

    try {
      items = document.findAllElements('item');
    } catch (_) {}

    final List<FeedItem> rssFeedItems = items.isNotEmpty
        ? items.map((node) => FeedItem.fromXml(node)).toList().where(
            (element) {
              return element.description.isNotEmpty && element.title.isNotEmpty;
            },
          ).toList()
        : [];

    if (rssFeedItems.isNotEmpty) {
      emit(state.copyWith(items: rssFeedItems));
    }
    return Future.value();
  }

  @override
  void emit(HomePageState state) {
    if (isClosed) return;
    super.emit(state);
  }
}
