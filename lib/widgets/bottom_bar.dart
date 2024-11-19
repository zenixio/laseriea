import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laseriea/bloc/navigation_bar/navigation_bar_cubit.dart';
import 'package:laseriea/bloc/navigation_bar/navigation_bar_state.dart';
import 'package:laseriea/utils/app_locale.dart';
import 'package:laseriea/utils/colors.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBarCubit, NavigationBarState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Dcolors.darkGreen, Dcolors.lightGreen],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: const [0.0, 0.8],
              tileMode: TileMode.clamp,
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<NavigationBarCubit>().setIndex(index: index);
            },
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            selectedFontSize: 12,
            unselectedFontSize: 8,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: [
              BottomNavigationBarItem(
                activeIcon: const Icon(Icons.home),
                icon: const Icon(Icons.home_outlined),
                label: AppLocale.of(context)?.home ?? '',
              ),
              BottomNavigationBarItem(
                activeIcon: const Icon(Icons.share),
                icon: const Icon(Icons.share_outlined),
                label: AppLocale.of(context)?.share ?? '',
              ),
              BottomNavigationBarItem(
                activeIcon: const Icon(Icons.add_a_photo),
                icon: const Icon(Icons.add_a_photo_outlined),
                label: AppLocale.of(context)?.upload ?? '',
              ),
            ],
          ),
        );
      },
    );
  }
}
