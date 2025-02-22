import 'package:crafti_hub/user%20side/const/urls.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  final Dio dio = Dio();
//---------------- fetch User ------->
  Future fetchUser(int? userId) async {
    try {
      Response response = await dio.get(
        '${baseUrl}users/$userId/',
      );

      // Success case
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return response;
      } else {
        // This block is not needed if using default validateStatus
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle 400 errors and other Dio exceptions
      if (e.response != null) {
        String errorMessage = '';
        errorMessage = e.response!.data.entries.first.value;
        print('---------------->${errorMessage}');

        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'Sent otp failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  //add address

  Future addAddress(Map<String, dynamic> data) async {
    try {
      Response response = await dio.post(
        '${baseUrl}addresses/',
        data: data,
      );

      // Success case
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return response;
      } else {
        // This block is not needed if using default validateStatus
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle 400 errors and other Dio exceptions
      if (e.response != null) {
        String errorMessage = '';
        errorMessage = e.response!.data.entries.first.value;
        print('---------------->${errorMessage}');

        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'Sent otp failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
