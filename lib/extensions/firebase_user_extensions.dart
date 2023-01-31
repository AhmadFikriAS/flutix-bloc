part of 'extensions.dart';

extension FirebaseUserExtension on User {
  UserApp convertToUser(
          {String name = "No Name",
          List<String> selectedGenres = const [],
          String selectedLanguage = "English",
          int balance = 50000}) =>
      UserApp(uid, email!,
          name: name,
          balance: balance,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage,
          profilePicture: '');

  Future<UserApp> fromFireStore() async => await UserServices.getUser(uid);
}
