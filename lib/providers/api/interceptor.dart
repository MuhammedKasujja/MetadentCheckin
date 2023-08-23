import 'package:dio/dio.dart';
import 'package:metadent_checkin_app/infra/infra.dart';

// helper class to access your local storage
class AppInterceptors extends Interceptor {
  // final GlobalKey<NavigatorState> _navigatorKey;
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    Logger.debug(data: {"REQUESTDATA": options.data, 'url': options.baseUrl});
    if (options.extra["requiresToken"] == false) {
      // if the request doesn't need token, then just continue to the next interceptor
      options.extra.remove("requiresToken"); //remove the auxiliary header
      return handler.next(options);
    }

    return handler.next(options);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.debug(
      data:
          'RESPONSE[${response.statusCode}] => DATA: ${response.data} URL => ${response.requestOptions.path}',
    );
    if (response.data['error_code'] == 401) {
      // final error = DioError(
      //     requestOptions: response.requestOptions, type: DioErrorType.other);
      // return handler.reject(error);
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger.debug(data: {
      "ERROR": err.error,
      'MESSAGE': err.message,
      "RESPONSE": err.response?.data
    });

    return handler.next(err);
  }
}
