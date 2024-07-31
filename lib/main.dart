import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_87/blocs/book_bloc.dart';
import 'package:lesson_87/repositories/book_repository.dart';
import 'package:lesson_87/ui/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) {
        return BookRepository();
      },
      child: BlocProvider(
        create: (context) {
          return BookBloc(
            bookRepository: context.read<BookRepository>(),
          );
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
  }
}
