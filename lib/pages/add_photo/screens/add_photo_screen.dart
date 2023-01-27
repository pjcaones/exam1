import 'dart:io';

import 'package:exam1/pages/add_photo/widgets/image_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef SelectImage = Future<void> Function();
typedef RemoveImage = void Function(int index);

class AddPhotoScreen extends StatelessWidget {
  final List<XFile>? imageList;
  final bool includePhotoGallery;

  final SelectImage onSelectImage;
  final RemoveImage onRemoveImage;

  const AddPhotoScreen(
      {super.key,
      required this.imageList,
      required this.includePhotoGallery,
      required this.onSelectImage,
      required this.onRemoveImage});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Photos to site diary",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.grey[700]),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ImageListWidget(
                  imageList: imageList,
                  onRemoveImage: onRemoveImage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: onSelectImage,
                    child: const Text('Add a photo'),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Include in photo gallery',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Checkbox(
                        value: includePhotoGallery,
                        onChanged: (val) {},
                      ))
                ],
              ),
            ]),
      ),
    );
  }
}
