class Book {
  int id;
  String title;
  String image;
  String url;
  double price;
  bool isLoading;
  bool isDownloaded;
  double progress;
  String saveUrl;

  Book({
    required this.id,
    required this.title,
    required this.image,
    required this.url,
    required this.price,
    this.isLoading = false,
    this.isDownloaded = false,
    this.progress = 0,
    this.saveUrl = "",
  });
}
