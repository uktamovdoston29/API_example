import 'dart:async';
import 'dart:io';
import 'package:api_example/main.dart';
import 'package:api_example/src/features/auth/data/source/auth_data_source.dart';
import 'package:api_example/src/core/either/either.dart';
import 'package:api_example/src/core/failure/failure.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toastification/toastification.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final Dio client = Dio();
  @override
  Future<Either<Failure, String>> login({
    required Map<String, dynamic> userInfo,
  }) async {
    print('User info $userInfo');
    try {
      final response = await client.post(
        'https://api-service.fintechhub.uz/login/',
        data: userInfo,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print('Togir keldi ukam ${response.data}');
        await GetStorage().write('refresh', response.data['tokens']['refresh']);
        await GetStorage().write('access', response.data['tokens']['access']);
        return Right(response.data['tokens']['access']);
      } else {
        throw DioException(requestOptions: response.requestOptions);
      }
    } on TimeoutException catch (e) {
      print('⏰ [login] TimeoutException — ${e.message}');
      throw TimeoutException(e.message);
    } on SocketException catch (e) {
      print('🔌 [login] SocketException — ${e.message}');
      throw SocketException(e.message);
    } on DioException catch (e) {
      print(
        '🌐 [login] DioException — status: ${e.response?.statusCode}, message: ${e.message}, data: ${e.response?.data}',
      );
      throw DioException(requestOptions: e.requestOptions);
    } catch (e) {
      print('💥 [login] Unknown Exception — $e');
      throw Exception();
    }
  }

  @override
  Future<Either<Failure, String>> register({
    required Map<String, dynamic> userInfo,
  }) async {
    try {
      print('📡 [login] Sending POST to /api/auth/local/register...');
      final response = await client.post(
        'https://api-service.fintechhub.uz/register/',
        data: userInfo,
      );
      print(
        '📥 [login] Response received — status: ${response.statusCode}, data: ${response.data}',
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print(
          '✅ [login] SUCCESS — status: ${response.statusCode}, body: ${response.data}',
        );
        toastification.show(
          type: ToastificationType.info,
          context: navigatorKey
              .currentContext!, // optional if you use ToastificationWrapper
          title: Text('Your code: ${response.data['otp']}'),
          autoCloseDuration: const Duration(seconds: 10),
        );
        return Right(response.data['detail']);
      } else {
        print(
          '❌ [login] FAILED — status: ${response.statusCode}, body: ${response.data}',
        );
        throw DioException(requestOptions: response.requestOptions);
      }
    } on TimeoutException catch (e) {
      throw TimeoutException(e.message);
    } on SocketException catch (e) {
      throw SocketException(e.message);
    } on DioException catch (e) {
      print(
        '🌐 [login] DioException — status: ${e.response?.statusCode}, message: ${e.message}, data: ${e.response?.data}',
      );
      throw DioException(requestOptions: e.requestOptions);
    } catch (e) {
      print('💥 [login] Unknown Exception — $e');
      throw Exception();
    }
  }

  @override
  Future<Either<Failure, String>> otp(
      {required Map<String, dynamic> userInfo}) async {
    try {
      final response = await client.post(
          'https://api-service.fintechhub.uz/otp-verify/',
          data: userInfo);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(response.data['detail']);
      } else {
        throw DioException(requestOptions: response.requestOptions);
      }
    } on TimeoutException catch (e) {
      print('⏰ [login] TimeoutException — ${e.message}');
      throw TimeoutException(e.message);
    } on SocketException catch (e) {
      print('🔌 [login] SocketException — ${e.message}');
      throw SocketException(e.message);
    } on DioException catch (e) {
      print(
        '🌐 [login] DioException — status: ${e.response?.statusCode}, message: ${e.message}, data: ${e.response?.data}',
      );
      throw DioException(requestOptions: e.requestOptions);
    } catch (e) {
      print('💥 [login] Unknown Exception — $e');
      throw Exception();
    }
  }
}
