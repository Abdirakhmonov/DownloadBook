import 'package:flutter/material.dart';

class ContinueReadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              'https://mpd-biblio-covers.imgix.net/9781250784094.jpg',
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'A Day of Fallen Night',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text('Samantha Shannon'),
                  const SizedBox(height: 8),
                  const LinearProgressIndicator(value: 0.3),
                  const SizedBox(height: 20),
                  Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                        child: Text(
                      "Update progress",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
