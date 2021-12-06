// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:archi/core/hotel_list_model.dart' as _i6;
import 'package:archi/core/services/app_shared_preferences.dart' as _i3;
import 'package:archi/core/services/connectivity_service.dart' as _i5;
import 'package:archi/ui/shared/locator_setup/module/app_module.dart' as _i9;
import 'package:archi/ui/shared/theme.dart' as _i8;
import 'package:archi/ui/shared/utils/responsive_config.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get, {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();

  gh.singleton<_i5.ConnectivityService>(_i5.ConnectivityService());
  gh.factory<_i6.HotelListModel>(() => _i6.HotelListModel());
  gh.singleton<_i7.LayoutConfig>(_i7.LayoutConfig());
  await gh.factoryAsync<_i4.SharedPreferences>(() => appModule.prefs, preResolve: true);
  gh.singleton<_i3.AppSharedPreferences>(_i3.AppSharedPreferences(get<_i4.SharedPreferences>()));
  gh.singleton<_i8.ThemeChanger>(_i8.ThemeChanger());
  return get;
}

class _$AppModule extends _i9.AppModule {}
