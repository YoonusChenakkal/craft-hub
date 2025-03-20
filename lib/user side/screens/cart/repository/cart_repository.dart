import 'package:dio/dio.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class CartRepository {
  final Dio dio = Dio();

  Future fetchCart(userId) async {
    // Fetch cart

    try {
      Response response = await dio.get(
        'https://purpleecommerce.pythonanywhere.com/productsapp/cart/$userId/',
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
            errorMessage.isNotEmpty ? errorMessage : 'fetch Cart failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future addToCart(body, productId, userId) async {
    // Fetch cart

    try {
      SVProgressHUD.show();
      Response response = await dio.post(
        'https://purpleecommerce.pythonanywhere.com/productsapp/cart/add/$userId/$productId/',
        data: body,
      );

      // Success case
      if (response.statusCode == 200 || response.statusCode == 201) {
        SVProgressHUD.dismiss();

        print(response.data);
        return response;
      } else {
        SVProgressHUD.dismiss();

        // This block is not needed if using default validateStatus
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      SVProgressHUD.dismiss();

      // Handle 400 errors and other Dio exceptions
      if (e.response != null) {
        SVProgressHUD.dismiss();

        String errorMessage = '';
        errorMessage = e.response!.data.entries.first.value;
        print('---------------->${errorMessage}');

        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'add to Cart failed');
      } else {
        SVProgressHUD.dismiss();

        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      SVProgressHUD.dismiss();

      throw Exception('Unexpected error: $e');
    }
  }

  Future deleteCartItem(cartItemId) async {
    // Fetch cart

    try {
      SVProgressHUD.show();

      Response response = await dio.delete(
        'https://purpleecommerce.pythonanywhere.com/productsapp/cart/delete/$cartItemId/',
      );

      // Success case
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        SVProgressHUD.dismiss();

        return response;
      } else {
        SVProgressHUD.dismiss();

        // This block is not needed if using default validateStatus
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      SVProgressHUD.dismiss();

      // Handle 400 errors and other Dio exceptions
      if (e.response != null) {
        SVProgressHUD.dismiss();

        String errorMessage = '';
        errorMessage = e.response!.data.entries.first.value;
        print('---------------->${errorMessage}');

        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'delete Cart failed');
      } else {
        SVProgressHUD.dismiss();

        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      SVProgressHUD.dismiss();

      throw Exception('Unexpected error: $e');
    }
  }
  // CheckOut

  Future checkOut(body, ) async {
    // Fetch cart

    try {
      Response response = await dio.post(
        'https://purpleecommerce.pythonanywhere.com/productsapp/checkout/',
        data: body,
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
            errorMessage.isNotEmpty ? errorMessage : 'checkout failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
