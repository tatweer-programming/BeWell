import 'package:get_it/get_it.dart';

import '../../modules/authenticaion/data_layer/data_sources/auth_remote_data_sources.dart';
import '../../modules/authenticaion/data_layer/repositories/auth_repository.dart';
import '../../modules/authenticaion/domain_layer/repsitories/base_auth_repository.dart';
import '../../modules/authenticaion/presentation_layer/bloc/auth_bloc.dart';
import '../../modules/main/data_layer/data_sources/main_remote_data_source.dart';
import '../../modules/main/data_layer/repositories/main_repository.dart';
import '../../modules/main/domain_layer/repositories/base_main_repository.dart';
import '../../modules/main/presentation_layer/bloc/main_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() async {
    /// bloc
    MainBloc mainBloc = MainBloc(MainInitial());
    sl.registerLazySingleton(() => mainBloc);
    AuthBloc authBloc = AuthBloc(AuthInitial());
    sl.registerLazySingleton(() => authBloc);

    /// main
    BaseMainRemoteDataSource baseMainRemoteDataSource = MainRemoteDataSource();
    sl.registerLazySingleton(() => baseMainRemoteDataSource);

    BaseMainRepository baseMainRepository = MainRepository(sl());
    sl.registerLazySingleton(() => baseMainRepository);


    /// auth
    BaseAuthRemoteDataSource baseAuthRemoteDataSource = AuthRemoteDataSource();
    sl.registerLazySingleton(() => baseAuthRemoteDataSource);

    BaseAuthRepository baseAuthRepository = AuthRepository(sl());
    sl.registerLazySingleton(() => baseAuthRepository);
  }
}
