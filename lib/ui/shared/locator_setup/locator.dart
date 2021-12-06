import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import './locator.config.dart';

final locator = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() async => $initGetIt(locator);
