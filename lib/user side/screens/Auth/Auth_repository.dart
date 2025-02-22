import 'package:crafti_hub/user%20side/const/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final Dio dio = Dio();

  // -------- Register APi --------->

  Future userRegister(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);

      Response response = await dio.post(
        '${baseUrl}register/',
        data: formData,
      );

      // Success case
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        // This block is not needed if using default validateStatus
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle 400 errors and other Dio exceptions
      if (e.response != null) {
        String errorMessage = '';
        final responseData = e.response!.data;
        if (responseData is Map<String, dynamic> && responseData.isNotEmpty) {
          errorMessage =
              responseData.values.first.toString(); // Get first value
        }
        print('---------------->${errorMessage}');

        throw Exception(errorMessage.isNotEmpty
            ? errorMessage
            : 'Registration Failed failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // -------- verify Register Otp APi --------->

  Future verifyRegisterOtp(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);

      Response response = await dio.post(
        '${baseUrl}verify-otp/',
        data: formData,
      );

      // Success case
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        // This block is not needed if using default validateStatus
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle 400 errors and other Dio exceptions
      if (e.response != null) {
        String errorMessage = '';
        final responseData = e.response!.data;
        if (responseData is Map<String, dynamic> && responseData.isNotEmpty) {
          errorMessage =
              responseData.values.first.toString(); // Get first value
        }
        print('---------------->${errorMessage}');

        throw Exception(errorMessage.isNotEmpty
            ? errorMessage
            : 'Registration Failed failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  // -------- Login API ---------->

  Future loginVendor(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);

      Response response = await dio.post(
        '${baseUrl}request-otp/',
        data: formData,
      );
      debugPrint("Response: $response");

      print(formData);

      // Success case
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response);
        return response;
      }
    } on DioException catch (e) {
      // Handle 400 errors and other Dio exceptions
      if (e.response != null) {
        String errorMessage = '';
        // Extract the first value from the response map
        final responseData = e.response!.data;
        if (responseData is Map<String, dynamic> && responseData.isNotEmpty) {
          errorMessage =
              responseData.values.first.toString(); // Get first value
        }
        print('---------------->${errorMessage}');

        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'Sent otp failed');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

// ---------- Loging Otp  Verification --------->

  Future loginOtpVerify(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);

      Response response = await dio.post(
        '${baseUrl}login/',
        data: formData,
      );

      // Success case
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle API errors
      if (e.response != null) {
        String errorMessage = '';

        var errorData = e.response!.data;

        if (errorData is Map && errorData.isNotEmpty) {
          var firstError = errorData.entries.first.value;

          // If it's a List, get the first element
          if (firstError is List && firstError.isNotEmpty) {
            errorMessage = firstError.first.toString();
          } else if (firstError is String) {
            errorMessage = firstError;
          } else {
            errorMessage = 'Login failed';
          }
        } else {
          errorMessage = 'An unknown error occurred';
        }

        print('---------------->${errorMessage}');
        throw Exception(errorMessage);
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
