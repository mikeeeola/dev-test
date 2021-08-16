import 'package:dev_test/helpers/http/http.helper.dart';
import 'package:dev_test/models/news.dart';
import 'package:dev_test/models/state.dart';
import 'package:dev_test/network/base/simplify_api_consuming.dart';
import 'package:dev_test/network/service/news/news_service.dart';

class NewsServiceImpl implements NewsService {
  HttpHelper httpClient;
  NewsServiceImpl({required this.httpClient});

  @override
  Future<ServiceState> loadNews() {
    return SimplifyApiConsuming.simplifyEndpointConsumingReturn(
        () => httpClient.get(
            'https://newsapi.org/v2/everything?q=Apple&from=2021-08-16&sortBy=popularity&apiKey=469fa81af0ed493c85e555d633f1d2f8'),
        successResponse: (data) {
      return SuccessState(
          data['articles'].map((json) => Article.fromJson(json)).toList());
    });
  }
}
