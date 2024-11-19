import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laseriea/config/constants.dart';
import 'package:laseriea/features/feed/presentation/bloc/home_page_cubit.dart';
import 'package:laseriea/features/feed/presentation/bloc/home_page_state.dart';
import 'package:laseriea/utils/app_locale.dart';
import 'package:laseriea/utils/colors.dart';
import 'package:laseriea/utils/logger_service.dart';
import 'package:laseriea/widgets/iframe.dart';
import 'package:laseriea/widgets/web_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => HomePageCubit()..getFeed(),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          final items = state.items ?? [];
          if (state.isLoading ?? true) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Dcolors.darkGreen),
              ),
            );
          }
          return items.isEmpty
              ? Center(
                  child: Text(
                    AppLocale.of(context)?.noData ?? '',
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.grey.shade400),
                  restorationId: feedListRestorationId,
                  itemCount: items.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final description = item.description;
                    final truncatedDescription = description.length > 50
                        ? "${description.substring(0, 50)}..."
                        : description;

                    LoggerService.log(
                        tag: 'data', message: '$description ${item.title}');

                    return ListTile(
                      onTap: () {
                        if (kIsWeb) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return IframeScreen(url: item.linkUrl);
                            },
                          ));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return WebViewScreen(url: item.linkUrl);
                            },
                          ));
                        }
                      },
                      isThreeLine: true,
                      titleTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      subtitleTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(item.imageUrl),
                      ),
                      title: Text(
                        item.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Text(
                        truncatedDescription,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
