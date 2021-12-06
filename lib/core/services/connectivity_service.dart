import 'package:connectivity/connectivity.dart';
import 'package:injectable/injectable.dart';

@singleton
class ConnectivityService {
  Future<bool> checkConnectivity() async {
    final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    return _handelResult(connectivityResult);
  }

  bool _handelResult(ConnectivityResult connectivityResult) {
    final bool connected;
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      connected = true;
    } else {
      connected = false;
    }
    return connected;
  }
}
