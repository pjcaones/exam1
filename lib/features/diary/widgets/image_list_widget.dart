import 'dart:io';

import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageListWidget extends StatelessWidget {
  const ImageListWidget({
    super.key,
    this.imageList,
    required this.onRemoveImage,
  });
  final ValueChanged<int> onRemoveImage;

  final List<XFile>? imageList;

  @override
  Widget build(BuildContext context) {
    return imageList == null || imageList!.isEmpty
        ? Align(child: Text(S.of(context).diaryMessageNoImageYet))
        : SizedBox(
            width: double.infinity,
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: imageList?.length ?? 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(children: [
                    Stack(clipBehavior: Clip.none, children: [
                      Image.file(
                        File(imageList![index].path),
                        height: 80,
                        width: 80,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        top: -12,
                        right: -10,
                        child: GestureDetector(
                          key: Key(
                            '${S.of(context).keyRemoveButton}$index',
                          ),
                          onTap: () => onRemoveImage(index),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]),
                );
              },
            ),
          );
  }
}
