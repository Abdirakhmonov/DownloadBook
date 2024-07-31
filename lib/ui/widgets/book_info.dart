import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_87/blocs/book_bloc.dart';
import 'package:lesson_87/blocs/book_event.dart';

import '../../models/book.dart';

class BookDetailPage extends StatefulWidget {
  Book book;

  BookDetailPage({required this.book});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('One Dark Window'),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.network(
                  widget.book.image,
                  height: 200,
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Rachel Gillig',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  SizedBox(width: 4),
                  Text(
                    '4.8',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 16),
                  Chip(
                    label: Text('Fantasy'),
                  ),
                  SizedBox(width: 16),
                  Text(
                    '432 Pages',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Synopsis',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Elspeth needs a monster. The monster might be her. Elspeth Spindle needs more than luck to stay safe in the eerie, mist-locked kingdom of Blunder—she needs a monster. She calls him the Nightmare, an ancient, mercurial spirit trapped in her head. He protects her. He keeps her secrets.\n\nBut nothing comes for free, especially magic. When Elspeth meets a mysterious highwayman on the forest road, her life takes a drastic turn. Thrust into a world of shadow and deception, she joins a dangerous quest to cure Blunder from the dark magic infecting it. And the highwayman? He just so happens to be the King\'s nephew, Captain of the most dangerous men in Blunder—and guilty of high treason.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 16),
              widget.book.isLoading
                  ? LinearProgressIndicator(
                      value: widget.book.progress,
                    )
                  : FilledButton(
                      onPressed: () {
                        if (widget.book.isDownloaded) {
                          context.read<BookBloc>().add(
                                OpenBook(
                                  bookPath: widget.book.saveUrl,
                                ),
                              );
                        } else {
                          context.read<BookBloc>().add(
                                DownloadBook(book: widget.book),
                              );
                        }
                      },
                      child:
                          Text(widget.book.isDownloaded ? 'Open' : 'Download'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
