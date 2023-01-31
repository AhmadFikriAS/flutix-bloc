part of 'services.dart';

class UserServices {
  static final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(UserApp user) async {
    _userCollection.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': user.selectedGenres,
      'selectedLanguage': user.selectedLanguage,
      'profilePicture': user.profilePicture
    });
  }

  static Future<UserApp> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    return UserApp(
      id,
      (snapshot.data() as dynamic)['email'],
      balance: (snapshot.data() as dynamic)['balance'],
      profilePicture: (snapshot.data() as dynamic)['profilePicture'],
      selectedGenres: ((snapshot.data() as dynamic)['selectedGenres'] as List)
          .map((e) => e.toString())
          .toList(),
      selectedLanguage: (snapshot.data() as dynamic)['selectedLanguage'],
      name: (snapshot.data() as dynamic)['name'],
    );
  }
}
