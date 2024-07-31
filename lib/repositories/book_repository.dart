import '../models/book.dart';

class BookRepository {
  List<Book> books = [
    Book(
        id: 1,
        title: "Stop Smoking",
        image:
            "https://cdn4.vectorstock.com/i/1000x1000/88/78/book-title-vector-4828878.jpg",
        url:
            "https://hr.fiu.edu/wp-content/uploads/2020/11/Quitting-Smoking.pdf",
        price: 12.9),
    Book(
        id: 2,
        title: "Soul",
        image:
            "https://marketplace.canva.com/EAFaQMYuZbo/1/0/1003w/canva-brown-rusty-mystery-novel-book-cover-hG1QhA7BiBU.jpg",
        url:
            "https://freedomarchives.org/Documents/Finder/DOC513_scans/Soulbook/513.Soulbook.Soulbook3.Fall.1965.pdf",
        price: 12.9),
    Book(
        id: 3,
        title: "Alone",
        image:
            "https://marketplace.canva.com/EAFPHUaBrFc/1/0/1003w/canva-black-and-white-modern-alone-story-book-cover-QHBKwQnsgzs.jpg",
        url:
            "https://lx.iriss.org.uk/sites/default/files/resources/Home%20alone.pdf",
        price: 12.9),
    Book(
        id: 4,
        title: "Zero to One",
        image:
            "https://assets.asaxiy.uz/product/items/desktop/c45147dee729311ef5b5c3003946c48f2023080717021174560gpz6jipFB3.jpg",
        url: "https://morfene.com/021.pdf",
        price: 12.9),
    Book(
        id: 5,
        title: "Atomic Habits",
        image:
            "https://images.squarespace-cdn.com/content/v1/59925253b8a79bf1c2e0ec7d/bf8585a0-d021-4c99-8d18-bc7feb61d67c/tempImageXNcP1f.jpg",
        url:
            "https://dn790007.ca.archive.org/0/items/atomic-habits-pdfdrive/Atomic%20habits%20%28%20PDFDrive%20%29.pdf",
        price: 12.9),
    Book(
        id: 6,
        title: "Harry Potter",
        image:
            "https://static0.srcdn.com/wordpress/wp-content/uploads/2023/08/harry-potter-movies-length-runtime.jpg",
        url:
            "https://vidyaprabodhinicollege.edu.in/VPCCECM/ebooks/ENGLISH%20LITERATURE/Harry%20potter/(Book%207)%20Harry%20Potter%20And%20The%20Deathly%20Hallows.pdf",
        price: 12.9),
  ];

  List<Book> getBooks() {
    return [...books];
  }
}
