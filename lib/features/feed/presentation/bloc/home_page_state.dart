import 'package:equatable/equatable.dart';

import '../../domain/entities/feed_item.dart';

class HomePageState extends Equatable {
  final List<FeedItem>? items;
  final bool? isLoading;

  const HomePageState({
    this.items,
    this.isLoading,
  });

  HomePageState copyWith({
    List<FeedItem>? items,
    bool? isLoading,
  }) {
    return HomePageState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        items,
        isLoading,
      ];
}
