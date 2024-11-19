import 'package:equatable/equatable.dart';

class NavigationBarState extends Equatable {
  final int selectedIndex;

  const NavigationBarState({this.selectedIndex = 0});

  NavigationBarState copyWith({
    int? selectedIndex,
  }) {
    return NavigationBarState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }

  @override
  List<Object?> get props => [selectedIndex];
}
