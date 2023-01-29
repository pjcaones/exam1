import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/card_title_widget.dart';
import '../widgets/image_list_widget.dart';

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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 9.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomCardTitle(title: "Add Photos to site diary"),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: ImageListWidget(
                    imageList: imageList,
                    onRemoveImage: onRemoveImage,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    key: const Key('add_photo'),
                    onPressed: onSelectImage,
                    child: const Text('Add a photo'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
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
                ),
              ]),
        ),
      ),
    );
  }
}
