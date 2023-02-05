import 'package:exam1/features/diary/presentation/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef SelectImage = void Function();
typedef RemoveImage = void Function(int index);

class AddPhotoScreen extends StatelessWidget {
  const AddPhotoScreen(
      {super.key,
      required this.imageList,
      required this.includePhotoGallery,
      required this.onIncludePhotoGallery,
      required this.onSelectImage,
      required this.onRemoveImage});
  final List<XFile>? imageList;
  final bool includePhotoGallery;

  final SelectImage onSelectImage;
  final RemoveImage onRemoveImage;
  final ValueChanged<bool?> onIncludePhotoGallery;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 9),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCardTitle(title: S.of(context).diaryTitleAddPhotos),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ImageListWidget(
                    imageList: imageList,
                    onRemoveImage: onRemoveImage,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    key: Key(S.of(context).keyAddPhoto),
                    onPressed: onSelectImage,
                    child: Text(S.of(context).buttonAddPhoto),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          S.of(context).diaryMessageIncludePhotoGallery,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Checkbox(
                            value: includePhotoGallery,
                            onChanged: onIncludePhotoGallery,
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
