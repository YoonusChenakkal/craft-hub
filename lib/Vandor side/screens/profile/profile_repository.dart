import 'package:crafti_hub/Vandor%20side/const/urls.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  final Dio dio = Dio();
//---------------- fetch User ------->
  Future fetchUser(int? userId) async {
    try {
      Response response = await dio.get(
        '${baseUrl}vendors/$userId/',
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

  // edit User

  Future editUser(int? userId, Map<String, dynamic> data) async {
    try {
      MultipartFile? imageFile;

      if (data.containsKey("displayImage") && data["displayImage"] != null) {
        imageFile = await MultipartFile.fromFile(data["displayImage"].path);
      }

      FormData formData = FormData.fromMap({
        if (data.containsKey("name")) "name": data["name"],
        if (data.containsKey("contactNumber"))
          "contact_number": data["contactNumber"],
        if (data.containsKey("whatsappNumber"))
          "whatsapp_number": data["whatsappNumber"],
        if (imageFile != null) "display_image": imageFile,
      });

      Response response = await dio.patch(
        '${baseUrl}vendors/$userId/',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return response;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        String errorMessage = '';

        if (e.response!.data is Map<String, dynamic>) {
          var firstKey = e.response!.data.keys
              .first; // Get the first key (e.g., "email", "contact_number")
          var firstValue =
              e.response!.data[firstKey]; // Get the value (which is a list)

          if (firstValue is List && firstValue.isNotEmpty) {
            errorMessage = firstValue.first; // Extract the first error message
          } else {
            errorMessage = firstValue.toString();
          }
        } else {
          errorMessage = e.response!.data.entries.first.value;
        }

        print('---------------->${errorMessage}');
        throw (errorMessage.isNotEmpty ? errorMessage : 'Edit user failed');
      } else {
        throw ('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
