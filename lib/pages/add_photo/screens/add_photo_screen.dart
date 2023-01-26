import 'dart:io';

import 'package:exam1/pages/add_photo/widgets/image_list_widget.dart';
import 'package:flutter/material.dart';

class AddPhotoScreen extends StatelessWidget {
  final List<File>? imageList;
  final bool includePhotoGallery;

  const AddPhotoScreen(
      {super.key, required this.imageList, required this.includePhotoGallery});

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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    child: const Text('Add a photo'),
                    onPressed: () {},
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
