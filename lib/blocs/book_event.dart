import '../models/book.dart';

sealed class BookEvent {}

final class GetBooks extends BookEvent {}

final class DownloadBook extends BookEvent {
  final Book book;

  DownloadBook({
    required this.book,
  });
}

final class OpenBook extends BookEvent {
  final String bookPath;

  OpenBook({required this.bookPath});
}
