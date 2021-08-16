part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoaded extends NewsState {
  final List<Article> loadedNews;
  NewsLoaded({
    required this.loadedNews,
  });
}

class NewsLoading extends NewsState {}

class NewsLoadError extends NewsState {
  final ServerErrorModel error;
  NewsLoadError({
    required this.error,
  });
}
