part of 'services.dart';

class FlutixTransactionServices {
  static CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection('transactions');

  static Future<void> saveTransaction(
      FlutixTransaction flutixTransaction) async {
    await transactionCollection.doc().set({
      'userID': flutixTransaction.userID,
      'title': flutixTransaction.title,
      'subtitle': flutixTransaction.subtitle,
      'time': flutixTransaction.time.millisecondsSinceEpoch,
      'amount': flutixTransaction.amount,
      'picture': flutixTransaction.picture
    });
  }

  static Future<List<FlutixTransaction>> getTransaction(String userID) async {
    QuerySnapshot snapshot = await transactionCollection.get();

    var documents = snapshot.docs
        .where((document) => (document.data() as dynamic)['userID'] == userID);

    return documents
        .map((e) => FlutixTransaction(
            userID: (e.data() as dynamic)['userID'],
            title: (e.data() as dynamic)['title'],
            subtitle: (e.data() as dynamic)['subtitle'],
            time: DateTime.fromMillisecondsSinceEpoch(
                (e.data() as dynamic)['time']),
            amount: (e.data() as dynamic)['amount'],
            picture: (e.data() as dynamic)['picture']))
        .toList();
  }
}
