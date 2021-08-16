import 'package:dev_test/cubit/news_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> init(GetIt injector) async {
  injector.registerFactory(
    () => NewsCubit(injector.get()),
  );
}
