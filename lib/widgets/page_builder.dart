import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laseriea/bloc/navigation_bar/navigation_bar_cubit.dart';
import 'package:laseriea/features/feed/presentation/screens/home_screen.dart';
import 'package:laseriea/features/share_on_ing/presentation/screens/share_on_ig_screen.dart';
import 'package:laseriea/features/upload_pictures/presentation/screens/upload_picture_screen.dart';
import 'package:laseriea/main.dart';
import 'package:laseriea/utils/colors.dart';
import 'package:laseriea/utils/utils.dart';
import 'package:laseriea/widgets/bottom_bar.dart';

class PageBuilder extends StatelessWidget {
  const PageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => LinearGradient(colors: [
              Dcolors.teal,
              Dcolors.blue,
              Dcolors.cyan,
            ]).createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text(
              toTitleCamelCase(context),
              style: TextStyle(
                  color: Dcolors.lightBlue, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.grey.shade200,
        bottomNavigationBar: const BottomBar(),
        body: FutureBuilder(
          future: getIt.allReady(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Dcolors.darkGreen),
                  ),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                return PageView(
                  controller: BlocProvider.of<NavigationBarCubit>(context)
                      .pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    HomeScreen(),
                    ShareOnIgScreen(),
                    UploadPictureScreen(),
                  ],
                );
            }
          },
        ));
  }
}
