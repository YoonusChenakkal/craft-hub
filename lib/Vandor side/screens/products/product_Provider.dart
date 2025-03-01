import 'dart:io';
import 'package:crafti_hub/Vandor%20side/common/flush_bar.dart';
import 'package:crafti_hub/local_storage.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/category_model.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/product_model.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VendorProductProvider extends ChangeNotifier {
  List<ProductModel> products = [];
  List<CategoryModel> categories = [];
  List<File> _selectedImages = [];
  CategoryModel? selectedCategory;
  String _searchQuery = '';

  // Controllers for form fields
  TextEditingController tcProductName = TextEditingController();
  TextEditingController tcProductDescription = TextEditingController();
  TextEditingController tcPrice = TextEditingController();
  TextEditingController tcDiscount = TextEditingController();

  bool _isPopular = false;

  bool _isNewArrival = false;

  bool _isTrending = false;

  bool _isOfferProduct = false;

  bool _isLoading = false;

  get isLoading => _isLoading;

  get isPopular => _isPopular;

  get isNewArrival => _isNewArrival;

  get isTrending => _isTrending;
  get isOfferProduct => _isOfferProduct;
  List<File> get selectedImages => _selectedImages;
  List<ProductModel> get filteredProducts => products
      .where((product) =>
          product.vendorName.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  set isPopular(value) {
    _isPopular = value;
    notifyListeners();
  }

  set isNewArrival(value) {
    _isNewArrival = value;
    notifyListeners();
  }

  set isTrending(value) {
    _isTrending = value;
    notifyListeners();
  }

  set isOfferProduct(value) {
    _isOfferProduct = value;
    notifyListeners();
  }

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> pickImages() async {
    try {
      final ImagePicker _picker = ImagePicker();

      final List<XFile>? pickedFiles = await _picker.pickMultiImage(
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFiles != null) {
        _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
        notifyListeners();
      }
    } catch (e) {
      print("❌ Error picking images: $e");
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < _selectedImages.length) {
      _selectedImages.removeAt(index);
      notifyListeners();
    }
  }

  void clearImages() {
    _selectedImages.clear();
    notifyListeners();
  }

  ProductRepository _productRepo = ProductRepository();

  fetchCategories(BuildContext context) async {
    isLoading = true;

    try {
      final response = await _productRepo.fetchCategories();

      categories = (response.data as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList();

      print('Sucess User Fetch');
      notifyListeners();
    } on Exception catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Fetching Categories Failed', // Clean up message
      );
      print("❌ Fetching Categories Failed : $e");
    } finally {
      isLoading = false;
    }
  }

  fetchProducts(BuildContext context) async {
    isLoading = true;
    final userId = await LocalStorage.getUser();

    try {
      final response = await _productRepo.fetchProducts(userId);

      products = (response.data as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();

      print('Sucess Product Fetch');
      notifyListeners();
    } catch (e) {
      // Display the parsed error message

      print("❌ Fetching Products failed: $e");
    } finally {
      isLoading = false;
    }
  }

  Future<void> addProduct(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      int? userId = await LocalStorage.getUser();
      if (userId == null) {
        showFlushbar(
          context: context,
          color: Colors.red,
          icon: Icons.error,
          message: 'Please log in again.',
        );
        isLoading = false;
        notifyListeners();
        return;
      }
      // Call API to add product

      await _productRepo.addProduct(
        userId: userId,
        productName: tcProductName.text,
        productDescription: tcProductDescription.text,
        price: tcPrice.text,
        discount: tcDiscount.text,
        categoryId: selectedCategory!.id,
        images: selectedImages,
        isOfferProduct: isOfferProduct,
        isNewArrival: isNewArrival,
        isPopularProduct: isPopular,
        isTrendingProduct: isTrending,
      );

      print('✅ Product added successfully');

      showFlushbar(
        context: context,
        color: Colors.green,
        icon: Icons.check_circle,
        message: 'Product added successfully!',
      );

      // Clear form after success
      reset();
    } catch (e) {
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Adding Product Failed', // Clear error message
      );
      print("❌ Product addition failed: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProduct(int productId, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      // Call API to add product

      await _productRepo.updateProduct(
        productId: productId,
        productName: tcProductName.text,
        productDescription: tcProductDescription.text,
        price: tcPrice.text,
        offerPrice: tcDiscount.text,
        categoryId: selectedCategory!.id,
        isOfferProduct: isOfferProduct,
        isNewArrival: isNewArrival,
        isPopularProduct: isPopular,
        isTrendingProduct: isTrending,
      );

      print('✅ Product Updated successfully');
      fetchProducts(context);
      notifyListeners();
      Navigator.pop(context);
      await showFlushbar(
        context: context,
        color: Colors.cyan,
        icon: Icons.check_circle,
        message: 'Product Updated successfully!',
      );

      // Clear form after success
      reset();
    } catch (e) {
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Updating Product Failed', // Clear error message
      );
      print("❌ Product Updating failed: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // delete product

  Future<void> deleteProduct(int productId, BuildContext context) async {
    print('Deleting Product: $productId');
    isLoading = true;
    notifyListeners();

    try {
      // Call API to delete product
      await _productRepo.deleteProduct(productId);

      print('✅ Product Deleted successfully');
      await showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.check_circle,
        message: 'Product Deleted successfully!',
      );
      fetchProducts(context);
      // Clear form after success
      reset();
    } catch (e) {
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Deleting Product Failed', // Clear error message
      );
      print("❌ Product Deleting failed: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  reset() {
    tcProductName.clear();
    tcProductDescription.clear();
    tcPrice.clear();
    tcDiscount.clear();
    selectedImages.clear();
    selectedCategory = null;

    notifyListeners();
  }
}
