import 'package:dio/dio.dart';
import '../../infra/models/models.dart';
import 'interceptor.dart';
import 'network_exceptions.dart';
import 'urls.dart';

///
/// Make all network calls using this class
///
class ApiClient {
  final Dio dio;
  // final GlobalKey<NavigatorState>? navigatorKey;

  ApiClient({
    required this.dio,
  }) {
    dio.options.baseUrl = Urls.baseUrl;
    dio.interceptors.add(AppInterceptors(dio));
  }

  /// Handle all `Post` requests using this method
  Future<ApiResponse<T, K>> post<T, K>(String url,
      {data = const {}, bool requiresAuth = true}) async {
    try {
      final res = await dio.post(
        url,
        data: data,
        options: Options(
          extra: {'requiresToken': requiresAuth},
        ),
      );
      return ApiResponse<T, K>.fromJson(res.data);
    } catch (e) {
      return ApiResponse(
        error: NetworkExceptions.getErrorMessage(
          NetworkExceptions.getDioException(e),
        ),
        success: false,
        status: AppState.failure,
      );
    }
  }

  /// Handle all `Get` requests using this method
  Future<ApiResponse<T, K>> get<T, K>(String url,
      {Map<String, dynamic> params = const {}}) async {
    try {
      final res = await dio.get(url, queryParameters: params);
      return ApiResponse.fromJson(res.data);
    } catch (ex) {
      return ApiResponse(
        error: NetworkExceptions.getErrorMessage(
          NetworkExceptions.getDioException(ex),
        ),
        success: false,
        status: AppState.failure,
      );
    }
  }
}
