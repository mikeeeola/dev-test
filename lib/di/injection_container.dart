import 'package:dev_test/di/bloc/bloc_module.dart' as BlocModule;
import 'package:dev_test/di/service/service_module.dart' as ServiceModule;
import 'package:dev_test/di/viewmodel/view_module.dart' as ViewModelModule;
import 'package:get_it/get_it.dart';

final GetIt injector = GetIt.instance;

Future<void> init() async {
  ServiceModule.init(injector);

  ViewModelModule.init(injector);

  BlocModule.init(injector);
}
