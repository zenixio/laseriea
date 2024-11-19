import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laseriea/bloc/navigation_bar/navigation_bar_state.dart';

class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit() : super(const NavigationBarState());

  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  void setIndex({required int index}) {
    final currentIndex = state.selectedIndex;

    if (index == currentIndex) return;

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    emit(state.copyWith(selectedIndex: index));
  }

  @override
  void emit(NavigationBarState state) {
    if (isClosed) return;
    super.emit(state);
  }

  @override
  Future<void> close() {
    _pageController.dispose();
    return super.close();
  }
}
