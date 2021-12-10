import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import './connectivity_service.dart';
import './app_shared_preferences.dart';
import '../../ui/shared/locator_setup/locator.dart';
import '../constants/app_constants.dart' as constants;
import '../models/common_models/api_result_model.dart';

import '../models/common_models/error_model.dart';

@lazySingleton
class HttpInvokeApi {
  final String? baseUrl = constants.baseUrl;
  final ConnectivityService _connectivityService = ConnectivityService();
  final AppSharedPreferences _sharePreference = locator<AppSharedPreferences>();
  Map<String, String> _sharedDefaultHeader = <String, String>{};

  // void initSharedDefaultHeader([String contentValue = contentTypeValue]) {
  //    final String? _language = _sharePreference.getLanguage();
  //    final String? _token = _sharePreference.getAuthorisationBearerToken();
  //   _sharedDefaultHeader = <String, String>{};
  //   if (_token != null) {
  //     _sharedDefaultHeader.addAll(<String, String>{
  //       contentTypeKey: contentValue,
  //       acceptLanguageKey: _language!,
  //       authorisationKey: _token,
  //     });
  //   } else {
  //     _sharedDefaultHeader.addAll(<String, String>{
  //       contentTypeKey: contentValue,
  //       acceptLanguageKey: _language!,
  //     });
  //   }
  // }

  ///@[params] should be added to the url as the api params
  Future<ApiResultModel<http.Response>> getWS({
    required String uri,
    Map<String, String> headers = const <String, String>{},
    Map<String, dynamic> params = const <String, dynamic>{},
  }) async {
    final bool connectivityResult = await _connectivityService.checkConnectivity();
    //initSharedDefaultHeader();
    _sharedDefaultHeader.addAll(headers);
    if (connectivityResult) {
      try {
        String _url = '$baseUrl$uri';
        if (params.isNotEmpty) {
          _url += '?';
          params.forEach((String key, dynamic value) {
            _url += '$key=$value&';
          });
          _url = _url.substring(0, _url.length - 1);
        }
        final Uri _uri = Uri.parse(_url);
        final http.Response response =
            await http.get(_uri, headers: _sharedDefaultHeader).timeout(constants.timeOutDuration);
        return response.statusCode >= 200 && response.statusCode < 300
            ? ApiResultModel<http.Response>.success(data: response)
            : ApiResultModel<http.Response>.failure(
                errorModel: ErrorModel(
                  errorCode: _getResponseErrorCode(response.statusCode, response),
                  message: _getResponseMessage(response.statusCode, response),
                  statusCode: response.statusCode,
                ),
              );
      } on TimeoutException catch (timeOutExceptionError) {
        ///should return your Error model
        return ApiResultModel<http.Response>.failure(
          errorModel: ErrorModel(
            errorCode: timeOutExceptionError.toString(),
            message: constants.timeoutExceptionMessage,
            statusCode: constants.timeoutStatusCode,
          ),
        );
      } on Exception catch (exception) {
        return ApiResultModel<http.Response>.failure(
          errorModel: ErrorModel(
            message: exception.toString(),
            errorCode: exception.toString(),
            statusCode: constants.runtimeExceptionStatusCode,
          ),
        );
      }
    } else {
      return ApiResultModel<http.Response>.failure(
        errorModel: ErrorModel(
          message: constants.connectionFailedString,
          errorCode: constants.connectionFailedString,
          statusCode: constants.socketExceptionStatusCode,
        ),
      );
    }
  }

  Future<ApiResultModel<http.Response>> postWS(String uri,
      {Map<String, String> headers = const <String, String>{},
      Map<String, dynamic> body = const <String, dynamic>{}}) async {
    //initSharedDefaultHeader();
    _sharedDefaultHeader.addAll(headers);
    final bool connectivityResult = await _connectivityService.checkConnectivity();
    if (connectivityResult) {
      try {
        final String encodedJson = json.encode(body);
        final Uri _uri = Uri.parse('$baseUrl$uri');
        final http.Response response = await http
            .post(_uri, headers: _sharedDefaultHeader, body: encodedJson, encoding: utf8)
            .timeout(constants.timeOutDuration);
        return response.statusCode >= 200 && response.statusCode < 300
            ? ApiResultModel<http.Response>.success(data: response)
            : ApiResultModel<http.Response>.failure(
                errorModel: ErrorModel(
                  errorCode: _getResponseErrorCode(response.statusCode, response),
                  message: _getResponseMessage(response.statusCode, response),
                  statusCode: response.statusCode,
                ),
              );
      } on TimeoutException catch (timeOutExceptionError) {
        ///should return your Error model
        return ApiResultModel<http.Response>.failure(
          errorModel: ErrorModel(
            errorCode: timeOutExceptionError.toString(),
            message: timeOutExceptionError.toString(),
            statusCode: constants.timeoutStatusCode,
          ),
        );
      } on Exception catch (exception) {
        ///should return your Error model
        return ApiResultModel<http.Response>.failure(
          errorModel: ErrorModel(
            errorCode: exception.toString(),
            message: exception.toString(),
            statusCode: constants.runtimeExceptionStatusCode,
          ),
        );
      }
    } else {
      return ApiResultModel<http.Response>.failure(
        errorModel: ErrorModel(
          errorCode: constants.connectionFailedString,
          message: constants.connectionFailedString,
          statusCode: constants.socketExceptionStatusCode,
        ),
      );
    }
  }

  Future<ApiResultModel<http.Response>> postFileWS(String uri, File file, String fileKey, MediaType? contentType,
      {Map<String, String> headers = const <String, String>{},
      Map<String, dynamic> body = const <String, dynamic>{}}) async {
    //initSharedDefaultHeader(contentMutlipartTypeValue);
    _sharedDefaultHeader.addAll(headers);
    final bool connectivityResult = await _connectivityService.checkConnectivity();
    if (connectivityResult) {
      try {
        final Uri _uri = Uri.parse('$baseUrl$uri');
        final http.MultipartRequest request = http.MultipartRequest('POST', _uri);
        request.headers.addAll(_sharedDefaultHeader);
        request.files.add(
          await http.MultipartFile.fromPath(
            fileKey,
            file.path,
            contentType: contentType,
          ),
        );
        final http.StreamedResponse streamedResponse = await request.send().timeout(constants.timeOutDuration);
        final http.Response response = await http.Response.fromStream(streamedResponse);
        return response.statusCode >= 200 && response.statusCode < 300
            ? ApiResultModel<http.Response>.success(data: response)
            : ApiResultModel<http.Response>.failure(
                errorModel: ErrorModel(
                  errorCode: _getResponseErrorCode(response.statusCode, response),
                  message: _getResponseMessage(response.statusCode, response),
                  statusCode: response.statusCode,
                ),
              );
      } on TimeoutException catch (timeOutExceptionError) {
        ///should return your Error model
        return ApiResultModel<http.Response>.failure(
          errorModel: ErrorModel(
            errorCode: timeOutExceptionError.toString(),
            message: timeOutExceptionError.toString(),
            statusCode: constants.timeoutStatusCode,
          ),
        );
      } on Exception catch (exception) {
        ///should return your Error model
        return ApiResultModel<http.Response>.failure(
          errorModel: ErrorModel(
            errorCode: exception.toString(),
            message: exception.toString(),
            statusCode: constants.runtimeExceptionStatusCode,
          ),
        );
      }
    } else {
      return ApiResultModel<http.Response>.failure(
        errorModel: ErrorModel(
          errorCode: constants.connectionFailedString,
          message: constants.connectionFailedString,
          statusCode: constants.socketExceptionStatusCode,
        ),
      );
    }
  }

  Future<ApiResultModel<http.Response>> putWS(
      {required String uri,
      Map<String, String> headers = const <String, String>{},
      Map<String, dynamic> body = const <String, dynamic>{}}) async {
    //initSharedDefaultHeader();
    _sharedDefaultHeader.addAll(headers);
    final bool connectivityResult = await _connectivityService.checkConnectivity();
    if (connectivityResult) {
      try {
        final Uri _uri = Uri.parse('$baseUrl$uri');
        final http.Response response = await http
            .put(_uri, headers: _sharedDefaultHeader, body: json.encode(body))
            .timeout(constants.timeOutDuration);
        return response.statusCode >= 200 && response.statusCode < 300
            ? ApiResultModel<http.Response>.success(data: response)
            : ApiResultModel<http.Response>.failure(
                errorModel: ErrorModel(
                  errorCode: _getResponseErrorCode(response.statusCode, response),
                  message: _getResponseMessage(response.statusCode, response),
                  statusCode: response.statusCode,
                ),
              );
      } on TimeoutException catch (timeOutExceptionError) {
        /// this statusCode changeable according to the developer's choice
        return ApiResultModel<http.Response>.failure(
          errorModel: ErrorModel(
            errorCode: timeOutExceptionError.toString(),
            message: timeOutExceptionError.toString(),
            statusCode: constants.timeoutStatusCode,
          ),
        );
      } on Exception catch (exception) {
        /// In case of any other exception we return an errorModel that take error description
        return ApiResultModel<http.Response>.failure(
          errorModel: ErrorModel(
            errorCode: exception.toString(),
            message: exception.toString(),
            statusCode: constants.runtimeExceptionStatusCode,
          ),
        );
      }
    } else {
      return ApiResultModel<http.Response>.failure(
        errorModel: ErrorModel(
          message: constants.connectionFailedString,
          errorCode: constants.connectionFailedString,
          statusCode: constants.socketExceptionStatusCode,
        ),
      );
    }
  }

  Future<ApiResultModel<http.Response>> deleteWS(
      {required String uri,
      Map<String, dynamic> body = const <String, dynamic>{},
      Map<String, String> headers = const <String, String>{}}) async {
    //initSharedDefaultHeader();
    _sharedDefaultHeader.addAll(headers);
    final bool connectivityResult = await _connectivityService.checkConnectivity();
    if (connectivityResult) {
      try {
        final Uri _uri = Uri.parse('$baseUrl$uri');
        final http.Response response = await http
            .delete(_uri, headers: _sharedDefaultHeader, body: json.encode(body))
            .timeout(constants.timeOutDuration);
        return response.statusCode >= 200 && response.statusCode < 300
            ? ApiResultModel<http.Response>.success(data: response)
            : ApiResultModel<http.Response>.failure(
                errorModel: ErrorModel(
                    message: _getResponseMessage(response.statusCode, response),
                    statusCode: response.statusCode,
                    errorCode: _getResponseErrorCode(response.statusCode, response)),
              );
      } on TimeoutException catch (timeOutExceptionError) {
        return ApiResultModel<http.Response>.failure(
          errorModel: ErrorModel(
            errorCode: timeOutExceptionError.toString(),
            message: timeOutExceptionError.toString(),
            statusCode: constants.timeoutStatusCode,
          ),
        );
      } on Exception catch (exception) {
        return ApiResultModel<http.Response>.failure(
          errorModel: ErrorModel(
            errorCode: exception.toString(),
            message: exception.toString(),
            statusCode: constants.runtimeExceptionStatusCode,
          ),
        );
      }
    } else {
      return ApiResultModel<http.Response>.failure(
        errorModel: ErrorModel(
          errorCode: constants.connectionFailedString,
          message: constants.connectionFailedString,
          statusCode: constants.socketExceptionStatusCode,
        ),
      );
    }
  }

  String? _getResponseMessage(int statusCode, http.Response response) {
    final Map<String, dynamic> _httpErrorJson = json.decode(response.body);
    final String? _httpError = ErrorModel.fromJson(_httpErrorJson).message;
    if (_httpError != null) {
      final String utfDecodedError = utf8.decode(_httpError.codeUnits);
      return utfDecodedError;
    }
  }

  String? _getResponseErrorCode(int statusCode, http.Response response) {
    final Map<String, dynamic> _httpErrorJson = json.decode(response.body);
    final String? _httpError = ErrorModel.fromJson(_httpErrorJson).errorCode;
    if (_httpError != null) {
      return _httpError;
    }
  }
}
