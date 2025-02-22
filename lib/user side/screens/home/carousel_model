class CarouselItem {
  final int id;
  final String title;
  final String carouselImage;

  CarouselItem({
    required this.id,
    required this.title,
    required this.carouselImage,
  });

  factory CarouselItem.fromJson(Map<String, dynamic> json) {
    return CarouselItem(
      id: json['id'],
      title: json['title'],
      carouselImage: json['carousel_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'carousel_image': carouselImage,
    };
  }
}
