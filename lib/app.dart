import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:laseriea/bloc/navigation_bar/navigation_bar_cubit.dart';
import 'package:laseriea/config/constants.dart';
import 'package:laseriea/utils/app_locale.dart';
import 'package:laseriea/widgets/page_builder.dart';
import 'package:laseriea/widgets/unknown_page.dart';

class LaSerieA extends StatelessWidget {
  const LaSerieA({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationBarCubit(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        restorationScopeId: restorationScopeId,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('it', ''),
        ],
        onGenerateTitle: (BuildContext context) => AppLocale.of(context)?.appTitle ?? '',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) {
              return _routerWidget(routeSettings);
            },
          );
        },
      ),
    );
  }

  Widget _routerWidget(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return const PageBuilder();
      default:
        return const UnknownPage();
    }
  }
}
