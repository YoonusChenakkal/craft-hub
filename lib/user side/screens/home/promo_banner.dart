import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafti_hub/user%20side/screens/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return CarouselSlider.builder(
      itemCount: homeProvider.promoBanners.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias, // Ensures rounded corners apply
          child: Stack(
            children: [
              // Placeholder icon while loading
              const Center(
                child: Icon(
                  Icons.image, // Placeholder icon
                  size: 80,
                  color: Colors.grey,
                ),
              ),
              // Network Image with loading and error handling
              Image.network(
                homeProvider.promoBanners[index].bannerImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null)
                    return child; // Show image when loaded
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ), // Show loader while loading
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image, // Broken image icon on failure
                      size: 80,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 7),
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
    );
  }
}
