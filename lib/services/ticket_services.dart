part of 'services.dart';

class TicketServices {
  static CollectionReference ticketCollection =
      FirebaseFirestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.doc().set({
      'movieID': ticket.movieDetail.id,
      'userID': id,
      'theaterName': ticket.theater.name,
      'time': ticket.time.millisecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice,
    });
  }

  static Future<List<Ticket>> getTickets(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.get();
    var documents = snapshot.docs
        .where((document) => (document.data() as dynamic)['userID'] == userId);

    List<Ticket> tickets = [];
    for (var document in documents) {
      MovieDetail movieDetail = await MovieServices.getDetails(null,
          movieID: (document.data() as dynamic)['movieID'], client: null);
      tickets.add(Ticket(
          movieDetail,
          Theater((document.data() as dynamic)['theaterName']),
          DateTime.fromMillisecondsSinceEpoch(
              (document.data() as dynamic)['time']),
          (document.data() as dynamic)['bookingCode'],
          (document.data() as dynamic)['seats'].toString().split(','),
          (document.data() as dynamic)['name'],
          (document.data() as dynamic)['totalPrice']));
    }

    return tickets;
  }
}
