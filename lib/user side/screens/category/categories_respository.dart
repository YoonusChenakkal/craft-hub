import 'package:crafti_hub/user%20side/const/urls.dart';
import 'package:dio/dio.dart';

class CategoriesRespository {
  final Dio dio = Dio();

//---------------- fetch Categories ------->

  Future fetchCategories() async {
    try {
      Response response = await dio.get(
        '${baseUrl}category/',
      );

      // Success case
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return response;
      }
    } on DioException catch (e) {
      // Handle 400 errors and other Dio exceptions
      if (e.response != null) {
        String errorMessage = '';
        errorMessage = e.response!.data.entries.first.value;
        print('---------------->${errorMessage}');

        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'fetch Categories failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
