import 'dart:io';

import 'package:flutter/material.dart';

class ImageListWidget extends StatelessWidget {
  final List<File>? imageList;

  const ImageListWidget({super.key, this.imageList});

  @override
  Widget build(BuildContext context) {
    Widget widgetToDisplay;

    if (imageList == null || imageList!.isEmpty) {
      widgetToDisplay = const Align(
        alignment: Alignment.center,
        child: Text(
          'No image uploaded yet..',
        ),
      );
    } else {
      widgetToDisplay = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageList?.length ?? 0,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .2,
                height: MediaQuery.of(context).size.height * .2,
                child: Image.file(
                  imageList![index],
                  fit: BoxFit.fill,
                ),
              )
            ],
          );
        },
      );
    }

    return widgetToDisplay;
  }
}
