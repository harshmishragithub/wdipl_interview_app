// common_api.dart

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'base_manager.dart';

class NetworkApiService {
  final Dio _dio = Dio(BaseOptions(
    validateStatus: (status) {
      return status != null &&
          status <= 500; // Allow any status code less than 500
    },
  ));

  // final Dio _dio;

  // NetworkApiService() : _dio = Dio(BaseOptions(
  //   validateStatus: (status) {
  //     return status != null && status <= 500; // Allow any status code less than 500
  //   },
  // )) {
  //   _dio.interceptors.add(InterceptorsWrapper(
  //     onRequest: (options, handler) async {
  //       String token = await secureStorageService.read("accesstoken") ?? "";
  //       if (token.isNotEmpty) {
  //         options.headers["x-auth-token"] = token;
  //       }
  //       return handler.next(options);
  //     },
  //     onResponse: (response, handler) {
  //       // If response is successful, just pass it along
  //       return handler.next(response);
  //     },
  //     onError: (DioException e, handler) async {
  //       // Handle token expiration
  //       if (e.response?.statusCode == 401) {
  //         // Handle token refresh logic here
  //         bool refreshed = await _refreshToken();
  //         if (refreshed) {
  //           // Retry the failed request with the new token
  //           final requestOptions = e.requestOptions;
  //           String newToken = await secureStorageService.read("accesstoken") ?? "";
  //           requestOptions.headers["x-auth-token"] = newToken;
  //           final response = await _dio.fetch(requestOptions);
  //           return handler.resolve(response);
  //         }
  //       }
  //       return handler.reject(e);
  //     },
  //   ));
  // }

  // Common function for GET requests
  Future<ResponseData> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    if (kDebugMode) {
      print("api url is >>> $url");
    }
    Response response;
    try {
      response = await _dio.get(
        url,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
            data: response.data);
      } else if (response.statusCode == 500) {
        return ResponseData<dynamic>(
            "Internal server error", ResponseStatus.PRIVATE,
            data: response.data);
      } else if (response.statusCode == 400) {
        return ResponseData<dynamic>(
            response.data['message'], ResponseStatus.PRIVATE,
            data: response.data);
      } else {
        try {
          return ResponseData<dynamic>(
              response.data['message'].toString(), ResponseStatus.FAILED);
        } catch (_) {
          return ResponseData<dynamic>(
              data: response.data,
              response.statusMessage!,
              ResponseStatus.FAILED);
        }
      }
    } catch (e) {
      return ResponseData<dynamic>(
          "Something went wrong", ResponseStatus.FAILED);
    }
  }

  // Common function for POST requests
  Future<ResponseData> post(String url, dynamic data) async {
    if (kDebugMode) {
      print("data >>> $data");
      print("api url is >>> $url");
    }
    try {
      var response = await _dio.post(
        url,
        data: data,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
            data: response.data);
      } else if (response.statusCode == 400) {
        return ResponseData<dynamic>(
            response.data['message'], ResponseStatus.PRIVATE,
            data: response.data);
      } else if (response.statusCode == 401) {
        return ResponseData<dynamic>(
            response.data['message'], ResponseStatus.PRIVATE,
            data: response.data);
      } else if (response.statusCode == 500) {
        return ResponseData<dynamic>(
            "Internal server error", ResponseStatus.PRIVATE,
            data: response.data);
      } else {
        try {
          return ResponseData<dynamic>(
              response.data['message'].toString(), ResponseStatus.FAILED);
        } catch (_) {
          return ResponseData<dynamic>(
              data: response.data,
              response.statusMessage!,
              ResponseStatus.FAILED);
        }
      }
    } catch (e) {
      return ResponseData<dynamic>(
          "Oops something went wrong", ResponseStatus.FAILED);
    }
  }

  // Common function for PUT requests
  Future<Response> put(String url, dynamic data) async {
    try {
      return await _dio.put(url, data: data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Common function for DELETE requests
  Future<Response> delete(String url) async {
    try {
      return await _dio.delete(url);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Handle Dio errors
  dynamic _handleError(dynamic e) {
    if (e is DioException) {
      // Handle Dio specific errors (e.g., DioErrorType.connectTimeout, DioErrorType.response)
      return e.message; // Or return a custom error message
    } else {
      return 'An error occurred'; // Generic error message for other types of errors
    }
  }
}
