import 'package:bloc/bloc.dart';
import 'package:dev_test/models/news.dart';
import 'package:dev_test/models/server_error_model.dart';
import 'package:dev_test/models/state.dart';
import 'package:dev_test/network/service/news/news_service.dart';
import 'package:meta/meta.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsService newsService;
  NewsCubit(this.newsService) : super(NewsInitial());

  void fetchNews() async {
    try {
      emit(NewsLoading());
      ServiceState serviceResponse = await newsService.loadNews();
      if (serviceResponse is SuccessState) {
        emit(NewsLoaded(loadedNews: List<Article>.from(serviceResponse.value)));
      } else if (serviceResponse is ErrorState) {
        ServerErrorModel error = serviceResponse.value;
        emit(NewsLoadError(error: error));
      }
    } catch (e) {
      emit(NewsLoadError(
          error: ServerErrorModel(errorMessage: 'An error occured')));
    }
  }
}
