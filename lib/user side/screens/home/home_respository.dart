import 'package:crafti_hub/local_storage.dart';
import 'package:crafti_hub/user%20side/const/urls.dart';
import 'package:dio/dio.dart';

class HomeRespository {
  final Dio dio = Dio();
//---------------- fetch Popular Products ------->

  Future fetchPopularProducts() async {
    try {
      Response response = await dio.get(
        '${baseUrl1}productsapp/popular/products/',
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

        throw Exception(errorMessage.isNotEmpty
            ? errorMessage
            : 'fetch Popular Products failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

//---------------- fetch Offer Products ------->

  Future fetchOfferProducts() async {
    try {
      Response response = await dio.get(
        '${baseUrl1}productsapp/offer/products/',
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

        throw Exception(errorMessage.isNotEmpty
            ? errorMessage
            : 'fetch Offer Products failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  //---------------- fetch All Products ------->

  Future fetchAllProducts() async {
    try {
      Response response = await dio.get(
        '${baseUrl1}productsapp/product/list/',
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

        throw Exception(errorMessage.isNotEmpty
            ? errorMessage
            : 'fetch ALl Products failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  //---------------- fetch Promo Banners ------->

  Future fetchPromoBanners() async {
    try {
      Response response = await dio.get(
        '${baseUrl1}productsapp/product/banner/image/list/',
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
        errorMessage = e.response!.data.entries.first.value;
        print('---------------->${errorMessage}');

        throw Exception(errorMessage.isNotEmpty
            ? errorMessage
            : 'fetch Promo Banners failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // Fetch carousel

  Future fetchCarousel() async {
    try {
      Response response = await dio.get(
        '${baseUrl}carousel/',
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
        errorMessage = e.response!.data.entries.first.value;
        print('---------------->${errorMessage}');

        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'fetch Carousel failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  // add review to product

  Future addReviewToProduct(int productId, String review, int rating) async {
    print('workinng 0000000 repo');
    try {
      final userId = await LocalStorage.getUser();
      final data = {
        'user_id': userId,
        'rating': rating,
        'product_id': productId,
        'product': productId,
        'review': review
      };
      print(data);
      final formdData = FormData.fromMap(data);

      Response response = await dio.post(
        'https://purpleecommerce.pythonanywhere.com/productsapp/product-reviews/',
        data: formdData,

      );

      // Success case
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioException catch (e) {
      // Handle 400 errors and other Dio exceptions
      if (e.response != null) {
        String errorMessage = '';
        errorMessage = e.response!.data;
        print('---------------->${errorMessage}');

        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'add review failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
