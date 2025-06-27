import 'package:crud_operation/View_Model/Storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StorageProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Storage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // show image / placeholder
            vm.file?.url != null && vm.file!.url!.isNotEmpty
              ? Image.network(vm.file!.url!, height: 200)
              : const Icon(Icons.image, size: 200),

            const SizedBox(height: 24),

            // upload button
            ElevatedButton(
              onPressed: vm.isUploading ? null : vm.pickAndUpload,
              child: Text(vm.isUploading ? 'Uploading...' : 'Pick & Upload'),
            ),

            // progress indicator
            if (vm.isUploading)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: LinearProgressIndicator(value: vm.file?.progress ?? 0),
              ),
          ],
        ),
      ),
    );
  }
}
