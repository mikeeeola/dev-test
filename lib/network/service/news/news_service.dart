import 'package:dev_test/models/state.dart';

abstract class NewsService {
  Future<ServiceState> loadNews();
}
