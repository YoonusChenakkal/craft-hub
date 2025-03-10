import 'package:dio/dio.dart';

class OrderRepository {
  final Dio dio = Dio();

  Future fetchOrders(userId) async {
    // Fetch orders

    try {
      Response response = await dio.get(
        'https://purpleecommerce.pythonanywhere.com/productsapp/orders/vendor/$userId/',
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
            errorMessage.isNotEmpty ? errorMessage : 'fetch Orders failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future changeOrderStatus(orderId,data) async {
    // Fetch orders

    try {
      final formData = FormData.fromMap(data);
      Response response = await dio.patch(
          'https://purpleecommerce.pythonanywhere.com/productsapp/orders/${orderId}/',
          data: formData);

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
        errorMessage = e.response!.data.entries.first.value;
        print('---------------->${errorMessage}');

        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'fetch Orders failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
