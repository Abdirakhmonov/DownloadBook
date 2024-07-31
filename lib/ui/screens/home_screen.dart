import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_87/blocs/book_bloc.dart';
import 'package:lesson_87/blocs/book_event.dart';
import 'package:lesson_87/blocs/book_state.dart';
import 'package:lesson_87/ui/widgets/book_info.dart';
import '../../models/book.dart';
import '../widgets/category_chip.dart';
import '../widgets/continue_reading_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Book Junction',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for books',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.mic),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Category Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryChip(label: 'All', isSelected: false),
                  CategoryChip(label: 'Romance', isSelected: false),
                  CategoryChip(label: 'Sci-Fi', isSelected: false),
                  CategoryChip(label: 'Fantasy', isSelected: true),
                  CategoryChip(label: 'Classics', isSelected: false),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Continue Reading',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            ContinueReadingCard(),
            const SizedBox(height: 16.0),
            // Best Sellers
            const Text(
              'Best Sellers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            BlocBuilder<BookBloc, BookState>(
              bloc: context.read<BookBloc>()..add(GetBooks()),
              builder: (context, state) {
                if (state.status == BookStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == BookStatus.loaded) {
                  return BestSellersGrid(books: state.books!);
                } else if (state.status == BookStatus.error) {
                  print(state.errorMessage);
                  return const Center(child: Text('Failed to load books'));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BestSellersGrid extends StatelessWidget {
  final List<Book> books;

  BestSellersGrid({required this.books});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return BestSellerCard(book: books[index]);
      },
    );
  }
}

class BestSellerCard extends StatelessWidget {
  final Book book;

  BestSellerCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(book: book),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                book.image,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Text(
                book.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${book.price.toString()}'),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
