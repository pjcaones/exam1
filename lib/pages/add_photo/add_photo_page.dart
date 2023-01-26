import 'dart:io';

import 'package:exam1/pages/add_photo/screens/add_photo_screen.dart';
import 'package:exam1/pages/add_photo/screens/comment_screen.dart';
import 'package:exam1/pages/add_photo/screens/details_screen.dart';
import 'package:exam1/pages/add_photo/screens/events_screen.dart';
import 'package:exam1/pages/add_photo/widgets/location_widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class UploadPhotosPage extends StatefulWidget {
  const UploadPhotosPage({super.key});

  @override
  State<UploadPhotosPage> createState() => _UploadPhotosState();
}

class _UploadPhotosState extends State<UploadPhotosPage> {
  late bool _includeGalleryPhoto;
  List<File>? _imageList;

  late TextEditingController _commentController;

  late int _diaryDate;
  late TextEditingController _diaryDateController;
  late int _areaID;
  late int _categoryID;
  late TextEditingController _tagsController;

  late bool _isExistingEvent;
  late int _eventID;

  @override
  void initState() {
    super.initState();

    DateFormat format = DateFormat('yyyy-MM-dd');

    _includeGalleryPhoto = true;
    _commentController = TextEditingController();

    _diaryDate = DateTime.now().millisecondsSinceEpoch;
    _diaryDateController = TextEditingController();
    _diaryDateController.text =
        format.format(DateTime.fromMillisecondsSinceEpoch(_diaryDate));

    _areaID = 0;
    _categoryID = 0;

    _tagsController = TextEditingController();

    _isExistingEvent = true;
    _eventID = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Diary'),
        centerTitle: false,
        leadingWidth: 30.0,
        leading: IconButton(
          icon: const Icon(Icons.close_sharp),
          padding: const EdgeInsets.only(left: 12.0),
          onPressed: () {
            //Prompt for confirming closing the app
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Static location only
            const LocationWidget(
                location: '20041075 | TAP-NS TAP-North Strathfield'),

            //Start of the form
            Container(
              color: Colors.white10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Column(
                  children: [
                    //Header of the form
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Add to site diary',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Tooltip(
                            message: "Fill up to add in site diary",
                            triggerMode: TooltipTriggerMode.tap,
                            child: Icon(Icons.help),
                          ),
                        )
                      ],
                    ),

                    //Adding of photo to site diary
                    AddPhotoScreen(
                      imageList: _imageList,
                      includePhotoGallery: _includeGalleryPhoto,
                    ),

                    //Comments
                    CommentScreen(commentController: _commentController),

                    //Details
                    DetailsScreen(
                        diaryDateController: _diaryDateController,
                        areaID: _areaID,
                        categoryID: _categoryID,
                        tagsController: _tagsController,
                        onSelectAreas: (value) {},
                        onSelectCategory: (value) {}),

                    //Event
                    EventsScreen(
                        isLinkExistingEvent: _isExistingEvent,
                        onSelectEvent: (value) {}),

                    //Button for calling the api
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 4.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 70,
                        child: ElevatedButton(
                          child: const Text('Next'),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _commentController.dispose();
    _commentController.dispose();
  }
}
