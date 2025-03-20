import 'package:crafti_hub/Vandor%20side/screens/products/product_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagePickSection extends StatelessWidget {
  const ImagePickSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VendorProductProvider>(
      builder: (context, provider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Selected Images Preview
              Consumer<VendorProductProvider>(
                builder: (context, provider, _) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Displaying selected images, taking only necessary space
                          provider.selectedImages.isEmpty
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 129, 63, 42),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.image,
                                    size: 70,
                                    color: Color.fromARGB(255, 129, 63, 42),
                                  ),
                                )
                              : Wrap(
                                  spacing: 10, // Space between images
                                  children: List.generate(
                                    provider.selectedImages.length,
                                    (index) => Stack(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Image.file(
                                            provider.selectedImages[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          right: 5,
                                          top: 5,
                                          child: GestureDetector(
                                            onTap: () =>
                                                provider.removeImage(index),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle),
                                              child: Icon(
                                                Icons.close,
                                                size: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                          ElevatedButton(
                            onPressed: () => provider.pickImages(),
                            style: ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: WidgetStatePropertyAll(CircleBorder()),
                              padding: WidgetStatePropertyAll(EdgeInsets.zero),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 50,
                              color: Color.fromARGB(255, 129, 63, 42),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
