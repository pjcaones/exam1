import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:exam1/features/diary/presentation/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DiaryForm extends StatefulWidget {
  const DiaryForm({
    super.key,
    this.imageList,
  });
  final List<XFile>? imageList;

  @override
  State<DiaryForm> createState() => _DiaryFormState();
}

class _DiaryFormState extends State<DiaryForm> {
  late String _location;
  late bool _includeGalleryPhoto;

  late List<XFile>? _imageList;

  late TextEditingController _commentController;

  late int _diaryDate;
  late TextEditingController _diaryDateController;
  late int _areaID;
  late int _categoryID;
  late TextEditingController _tagsController;

  late bool _isLinkExistingEvent;
  late int _eventID;

  //hardcoded values of objects
  late Map<int, String> _areas;
  late Map<int, String> _categories;
  late Map<int, String> _events;

  @override
  void initState() {
    super.initState();

    //hardcoded values for test
    _location = '20041075 | TAP-NS TAP-North Strathfield';
    _areas = {
      1: 'Area 1',
      2: 'Area 2',
      3: 'Area 3',
    };
    _categories = {
      1: 'Task Category 1',
      2: 'Task Category 2',
      3: 'Task Category 3',
    };
    _events = {
      1: 'Event 1',
      2: 'Event 2',
      3: 'Event 3',
    };

    //DateFormat should not be here
    //ui page must not have any logics implemented
    final DateFormat format = DateFormat('yyyy-MM-dd');

    _imageList = widget.imageList ?? [];

    _includeGalleryPhoto = true;
    _commentController = TextEditingController();

    _diaryDate = DateTime.now().millisecondsSinceEpoch;
    _diaryDateController = TextEditingController();
    _diaryDateController.text =
        format.format(DateTime.fromMillisecondsSinceEpoch(_diaryDate));

    _areaID = 0;
    _categoryID = 0;

    _tagsController = TextEditingController();

    _isLinkExistingEvent = true;
    _eventID = 0;
  }

  //Callbacks
  Future<void> _onSelectImage() async {
    context.read<DiaryBloc>().add(
          PickImageEvent(
            imageList: _imageList!,
          ),
        );
  }

  void _onRemoveImage(int index) {
    context.read<DiaryBloc>().add(
          RemoveImageEvent(
            index: index,
            imageList: _imageList!,
          ),
        );
  }

  void _onIncludePhotoGallery(bool? value) {
    setState(() {
      if (value != null) {
        _includeGalleryPhoto = value;
      }
    });
  }

  void _onLinkExistingEvent(bool? value) {
    setState(() {
      if (value != null) {
        _isLinkExistingEvent = value;
      }
    });
  }

  void _uploadDiary() {
    context.read<DiaryBloc>().add(UploadDiaryEvent(
        location: _location,
        imageList: _imageList ?? [],
        comment: _commentController.text,
        diaryDate: _diaryDate,
        areaID: _areaID,
        taskCategoryID: _categoryID,
        tags: _tagsController.text,
        eventID: _eventID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiaryBloc, DiaryState>(
      builder: (context, state) {
        if (state is PickImageSuccess) {
          _imageList = state.updatedImageList;
        } else if (state is RemoveImageSuccess) {
          _imageList = state.updatedImageList;
        }

        return Column(children: [
          //Static location only
          LocationWidget(
            location: _location,
          ),

          Container(
            color: const Color.fromARGB(255, 242, 245, 247),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Column(
                children: [
                  //Header of the form
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            S.of(context).diaryMessageAddSiteDiary,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Tooltip(
                            message: S.of(context).diaryMessageFillUpDiary,
                            triggerMode: TooltipTriggerMode.tap,
                            child: const Icon(Icons.help,
                                color: Color.fromARGB(255, 154, 154, 154)),
                          ),
                        )
                      ],
                    ),
                  ),

                  //Adding of photo to site diary
                  AddPhotoScreen(
                    imageList: _imageList,
                    includePhotoGallery: _includeGalleryPhoto,
                    onIncludePhotoGallery: _onIncludePhotoGallery,
                    onSelectImage: _onSelectImage,
                    onRemoveImage: _onRemoveImage,
                  ),

                  //Comments
                  CommentScreen(commentController: _commentController),

                  //Details
                  DetailsScreen(
                      areas: _areas,
                      categories: _categories,
                      diaryDateController: _diaryDateController,
                      areaID: _areaID,
                      categoryID: _categoryID,
                      tagsController: _tagsController,
                      onSelectAreas: (value) {
                        if (value != null) {
                          setState(() {
                            _areaID = value;
                          });
                        }
                      },
                      onSelectCategory: (value) {
                        if (value != null) {
                          setState(() {
                            _categoryID = value;
                          });
                        }
                      }),

                  //Event
                  EventsScreen(
                      events: _events,
                      isLinkExistingEvent: _isLinkExistingEvent,
                      onLinkExistingEvent: _onLinkExistingEvent,
                      onSelectEvent: (value) {
                        if (value != null) {
                          setState(() {
                            _eventID = value;
                          });
                        }
                      }),

                  //Button for calling the api
                  UploadDiaryWidget(
                    onUploadDiaryForm: _uploadDiary,
                  ),
                ],
              ),
            ),
          ),
        ]);
      },
    );
  }
}
