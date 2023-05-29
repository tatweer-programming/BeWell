import 'package:get_it/get_it.dart';

import '../../modules/main/data_layer/data_sources/main_remote_data_source.dart';
import '../../modules/main/data_layer/repositories/main_repository.dart';
import '../../modules/main/domain_layer/repositories/base_main_repository.dart';
import '../../modules/main/presentation_layer/bloc/main_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() async {
    MainBloc bloc = MainBloc(MainInitial());
    sl.registerLazySingleton(() => bloc);
    /// main
    BaseMainRemoteDataSource baseMainRemoteDataSource = MainRemoteDataSource();
    sl.registerLazySingleton(() => baseMainRemoteDataSource);

    BaseMainRepository baseMainRepository = MainRepository(sl());
    sl.registerLazySingleton(() => baseMainRepository);
  }
}
