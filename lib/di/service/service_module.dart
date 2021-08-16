import 'package:dev_test/helpers/http/http.helper.dart';
import 'package:dev_test/network/service/news/news_service.dart';
import 'package:dev_test/network/service/news/news_service_impl.dart';
import 'package:get_it/get_it.dart';

Future<void> init(GetIt injector) async {
  injector.registerFactory(() => HttpHelper());

  injector.registerFactory<NewsService>(
    () => NewsServiceImpl(httpClient: injector.get()),
  );
}
