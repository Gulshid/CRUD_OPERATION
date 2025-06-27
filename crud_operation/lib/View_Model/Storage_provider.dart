import 'dart:io';

import 'package:crud_operation/Model/crud_model.dart';
import 'package:crud_operation/Service/Storage_service.dart';
import 'package:flutter/material.dart';

class StorageProvider with ChangeNotifier {
  final _service = StorageService();

  /// Current file (null before pick)
  CrudModel? _file;
  CrudModel? get file => _file;

  bool get isUploading => _file != null && _file!.progress !>= 0 && _file!.progress !< 1;

  /// Step 1 – pick; Step 2 – upload; Step 3 – expose progress & URL.
  Future<void> pickAndUpload() async {
    // 1. pick
    final File? raw = await _service.pickImage();
    if (raw == null) return;

    _file = CrudModel(id: raw.path, url: '', progress: 0);
    notifyListeners();

    // 2. upload w/ progress callback
    final url = await _service.uploadfile(
      file: raw,
      onprogress: (pct) {
        _file = _file?.copyWith(progress: pct);
        notifyListeners();
      },
    );

    // 3. done – save URL
    _file = _file?.copyWith(progress: -1, url: url); // -1 means “finished”
    notifyListeners();
  }

}