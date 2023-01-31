part of 'shared.dart';

Future<File> ambilImage() async {
  final ImagePicker _picker = ImagePicker();
  var image = await _picker.pickImage(source: ImageSource.gallery);

  return File(image!.path);
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  Reference ref = FirebaseStorage.instance.ref().child(fileName);
  UploadTask task = ref.putFile(image);
  TaskSnapshot snapshot = await task;

  return await snapshot.ref.getDownloadURL();
}

Widget generateDashedDivider(double width) {
  int n = width ~/ 5;
  return Row(
    children: List.generate(
        n,
        (index) => (index % 2 == 0)
            ? Container(
                height: 2,
                width: width / n,
                color: const Color(0xFFE4E4E4),
              )
            : SizedBox(
                width: width / n,
              )),
  );
}
