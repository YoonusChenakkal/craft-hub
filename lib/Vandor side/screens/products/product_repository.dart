import 'package:crafti_hub/Vandor%20side/const/urls.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class ProductRepository {
  final Dio dio = Dio();

  //  Fetch Categories
  Future fetchCategories() async {
    try {
      Response response = await dio.get('${baseUrl}vendors/by-category/');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return response;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        String errorMessage = e.response!.data.entries.first.value;
        print('❌ Error: $errorMessage');
        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'Fetch categories failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  //  Fetch Products
  Future fetchProducts(userId) async {
    try {
      Response response = await dio.get(
          '${baseUrl2}productsapp/vendors/$userId/products');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return response;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        String errorMessage = e.response!.data.entries.first.value;
        print('❌ Error: $errorMessage');
        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'Fetch categories failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  //  Add Product API
  Future<void> addProduct({
    required int userId,
    required String productName,
    required String productDescription,
    required String price,
    required String discount,
    required String categoryname,
    required String subcategoryname,
    required List<File> images,
    required bool isOfferProduct,
    required bool isPopularProduct,
    required bool isNewArrival,
    required bool isTrendingProduct,
  }) async {
    try {
      // Convert images to MultipartFile
      List<MultipartFile> multipartImages = await Future.wait(
        images.map((image) async => await MultipartFile.fromFile(image.path)),
      );

      FormData formData = FormData.fromMap({
        "vendor": userId,
        "category": 1,
        "categoryname": categoryname,
        "subcategory": subcategoryname,
        "product_name": productName,
        "product_description": productDescription,
        "price": price,
        "discount": discount,
        "images": multipartImages, // Send as MultipartFile list
        "isofferproduct": isOfferProduct,
        "Popular_products": isPopularProduct,
        "newarrival": isNewArrival,
        "trending_one": isTrendingProduct,
      });

      // Print all data to the console
      print("Data being sent to the API:");
      print("Vendor: 5");
      print("Category ID: $categoryname");
      print("Category ID: $subcategoryname");

      print("Product Name: $productName");
      print("Product Description: $productDescription");
      print("Price: $price");
      print("Offer Price: $discount");
      print("Images: ${multipartImages}"); // Print image paths
      print("Is Offer Product: true");
      print("Popular Product: false");
      print("New Arrival: true");
      print("Trending One: false");

      Response response = await dio.post(
        '${baseUrl2}productsapp/product/',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Product added successfully');
        print(response.data);
      } else {
        throw Exception('Failed to add product: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        String errorMessage = e.response!.data.entries.first.value;
        print('❌ Error: $errorMessage');
        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'Add product failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  //Edit Product

  Future<void> updateProduct({
    required int productId,
    required String productName,
    required String productDescription,
    required String price,
    required String discount,
    String? categoryname,
    String? subcategoryname,
    required bool isOfferProduct,
    required bool isPopularProduct,
    required bool isNewArrival,
    required bool isTrendingProduct,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "category_id": 1,
        "product_name": productName,
        "product_description": productDescription,
        if (categoryname != null && categoryname.isNotEmpty)
          "categoryname": categoryname,
        if (subcategoryname != null && subcategoryname.isNotEmpty)
          "subcategory": subcategoryname,
        "price": price,
        "discount": discount,
        "isofferproduct": isOfferProduct,
        "Popular_products": isPopularProduct,
        "newarrival": isNewArrival,
        "trending_one": isTrendingProduct,
      });
      print(subcategoryname);
      print(categoryname);
      // Send PATCH request
      Response response = await dio.patch(
        '${baseUrl2}productsapp/product/$productId/',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Product updated successfully');
      } else {
        throw Exception('❌ Failed to update product: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        String errorMessage = e.response!.data.entries.first.value;
        print('❌ API Error: $errorMessage');
        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'Edit product failed');
      } else {
        throw Exception('❌ Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('❌ Unexpected error: $e');
    }
  }

  //Delete Product

  Future<void> deleteProduct(int productId) async {
    try {
      Response response = await dio.delete(
          '${baseUrl2}productsapp/product/$productId/');

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        print('✅ Product deleted successfully');
      } else {
        throw Exception('❌ Failed to delete product: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        String errorMessage = e.response!.data.entries.first.value;
        print('❌ API Error: $errorMessage');
        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'Delete product failed');
      } else {
        throw Exception('❌ Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('❌ Unexpected error: $e');
    }
  }
}
