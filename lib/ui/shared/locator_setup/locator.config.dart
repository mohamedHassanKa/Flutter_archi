// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

import '../../../core/providers/hotel_list_model.dart' as _i7;
import '../../../core/services/app_shared_preferences.dart' as _i3;
import '../../../core/services/connectivity_service.dart' as _i6;
import '../../../core/services/http_invote_api.dart' as _i5;
import '../theme.dart' as _i9;
import '../utils/responsive_config.dart' as _i8;
import 'module/app_module.dart' as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get, {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  await gh.factoryAsync<_i4.SharedPreferences>(() => appModule.prefs, preResolve: true);
  gh.singleton<_i3.AppSharedPreferences>(_i3.AppSharedPreferences(get<_i4.SharedPreferences>()));
  gh.lazySingleton<_i5.HttpInvokeApi>(() => _i5.HttpInvokeApi());
  gh.singleton<_i6.ConnectivityService>(_i6.ConnectivityService());
  gh.factory<_i7.HotelListProvider>(() => _i7.HotelListProvider());
  gh.singleton<_i8.LayoutConfig>(_i8.LayoutConfig());

  gh.singleton<_i9.ThemeChanger>(_i9.ThemeChanger());
  return get;
}

class _$AppModule extends _i10.AppModule {}
