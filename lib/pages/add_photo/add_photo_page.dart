import 'dart:io';

import 'package:exam1/helpers/image_helper.dart';
import 'package:exam1/pages/add_photo/add_photo_bloc.dart';
import 'package:exam1/pages/add_photo/screens/add_photo_screen.dart';
import 'package:exam1/pages/add_photo/screens/comment_screen.dart';
import 'package:exam1/pages/add_photo/screens/details_screen.dart';
import 'package:exam1/pages/add_photo/screens/events_screen.dart';
import 'package:exam1/pages/add_photo/widgets/location_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class UploadPhotosPage extends StatefulWidget {
  const UploadPhotosPage({super.key});

  @override
  State<UploadPhotosPage> createState() => _UploadPhotosState();
}

class _UploadPhotosState extends State<UploadPhotosPage> {
  late ImageHelper _imageHelper;

  late bool _includeGalleryPhoto;
  List<XFile>? _imageList;

  late TextEditingController _commentController;

  late int _diaryDate;
  late TextEditingController _diaryDateController;
  late int _areaID;
  late int _categoryID;
  late TextEditingController _tagsController;

  late bool _isExistingEvent;
  late int _eventID;

  late AddPhotoBloc _addPhotoBloc;

  late ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();

    DateFormat format = DateFormat('yyyy-MM-dd');
    _imageHelper = ImageHelper();

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

    _addPhotoBloc = AddPhotoBloc();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _progressDialog = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false);
  }

  //Callbacks
  Future<void> _onSelectImage() async {
    XFile? pickedImage =
        await _imageHelper.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageList ??= [];
      if (pickedImage != null) {
        _imageList!.add(pickedImage);
      }
    });
  }

  void _onRemoveImage(int index) {
    setState(() {
      _imageList!.removeAt(index);
    });
  }

  void diaryDialog(
      {required String title,
      required String message,
      required Function() onPressed}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text('OK'),
            )
          ],
        );
      },
    );
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
      body: BlocListener<AddPhotoBloc, AddPhotoState>(
        bloc: _addPhotoBloc,
        listener: (context, state) async {
          if (state is UploadDiaryLoading) {
            if (!_progressDialog.isShowing()) {
              _progressDialog.show();
            }
          } else if (state is UploadDiaryFailed) {
            if (_progressDialog.isShowing()) {
              _progressDialog.hide();

              diaryDialog(
                  title: 'Upload Failed',
                  message: state.errorMessage ?? 'Something went wrong..',
                  onPressed: () {
                    Navigator.of(context).pop();
                  });
            }
          } else if (state is UploadDiarySuccess) {
            if (_progressDialog.isShowing()) {
              _progressDialog.hide();

              diaryDialog(
                  title: 'Upload Success',
                  message: 'Your diary has beed uploaded!',
                  onPressed: () {
                    Navigator.of(context).pop();
                  });
            }
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Static location only
              const LocationWidget(
                  location: '20041075 | TAP-NS TAP-North Strathfield'),

              //Start of the form
              Container(
                color: Colors.white10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
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
                        onSelectImage: _onSelectImage,
                        onRemoveImage: _onRemoveImage,
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
                            onPressed: () {
                              _addPhotoBloc.add(UploadDiary());
                            },
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _commentController.dispose();
    _commentController.dispose();

    _addPhotoBloc.close();
  }
}
