import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;
  final _picker = ImagePicker();

  //pick an image from gallery
  Future<File?> pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    return file == null ? null : File(file.path);
  }

  // upload the file
  Future<String> uploadfile({
    required File file,
    required Function(double) onprogress,
  }) async {
    final name = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = _storage.ref('uploads/$name.jpg');

    final task = ref.putFile(file);

  // listen to progress
    task.snapshotEvents.listen((TaskSnapshot snap) {
      final pct = snap.bytesTransferred / snap.totalBytes;
      onprogress(pct);
    });

    // wait for completion
    await task.whenComplete(() {});
    return await ref.getDownloadURL();
  }

  Future<void> deleteFile(String pathInStorage) =>
      _storage.ref(pathInStorage).delete();
}
