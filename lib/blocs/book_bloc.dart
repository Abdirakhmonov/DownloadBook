import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lesson_87/blocs/book_event.dart';
import 'package:lesson_87/blocs/book_state.dart';
import 'package:lesson_87/repositories/book_repository.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import '../models/book.dart';
import '../services/permission_service.dart';


class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc({required this.bookRepository})
      : super(BookState(
          status: BookStatus.initial,
          books: [],
        )) {
    on<GetBooks>(_onGetBooks);
    on<DownloadBook>(_onDownloadBook);
    on<OpenBook>(_onOpenBook);
  }

  final BookRepository bookRepository;

  void _onGetBooks(event, emit) async {
    emit(state.copyWith(status: BookStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 1));
      final books = bookRepository.getBooks();

      for (Book book in books) {
        final fullPath = await _getSavePath(book);
        if (_checkBookExists(fullPath)) {
          book.isDownloaded = true;
          book.saveUrl = fullPath;
          book.progress = 1;
        }
      }

      emit(state.copyWith(
        status: BookStatus.loaded,
        books: books,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onDownloadBook(DownloadBook event, emit) async {
    final index = state.books!.indexWhere((book) {
      return book.id == event.book.id;
    });
    state.books![index].isLoading = true;
    emit(state.copyWith(books: state.books));

    try {
      if (await PermissionService.requestStoragePermission()) {
        final dio = Dio();

        final fullPath = await _getSavePath(event.book);
        final response = await dio.download(
          event.book.url,
          fullPath,
          onReceiveProgress: (count, total) {
            final progress = count / total;
            state.books![index].progress = progress;
            emit(state.copyWith(
              books: state.books,
            ));
          },
        );

        print(response);

        state.books![index].isDownloaded = true;
        state.books![index].isLoading = false;
        state.books![index].saveUrl = fullPath;

        emit(state.copyWith(
          books: state.books,
        ));
      } else {
        emit(
          state.copyWith(
            status: BookStatus.error,
            errorMessage: "Permission not granted",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BookStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onOpenBook(OpenBook event, emit) async {
    await OpenFilex.open(event.bookPath);
  }

  Future<String> _getSavePath(Book book) async {
    Directory? savePath = await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      savePath = Directory("/storage/emulated/0/download");
    }

    final fileName = book.title;
    final fileFormat = book.url.split('.').last;
    final fullPath = "${savePath.path}/$fileName.$fileFormat";

    return fullPath;
  }

  bool _checkBookExists(String fullPath) {
    final book = File(fullPath);

    return book.existsSync();
  }
}
