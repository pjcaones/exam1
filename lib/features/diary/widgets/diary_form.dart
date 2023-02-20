import 'package:exam1/features/diary/bloc/diary_bloc.dart';
import 'package:exam1/features/diary/widgets/widgets.dart';
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

    _location = '';
    _imageList = widget.imageList ?? [];

    _includeGalleryPhoto = true;
    _commentController = TextEditingController();

    _diaryDateController = TextEditingController();
    _areas = {};
    _areaID = 0;
    _categories = {};
    _categoryID = 0;
    _tagsController = TextEditingController();

    _isLinkExistingEvent = true;
    _events = {};
    _eventID = 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<DiaryBloc>().add(DiaryInitialEvent());
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
        if (state is DiaryInitialLoadSuccess) {
          _location = state.location;
          _areas = state.areas;
          _categories = state.categories;
          _events = state.events;
          _diaryDate = state.diaryDate;
          _diaryDateController.text = DateFormat('yyyy-MM-dd')
              .format(DateTime.fromMillisecondsSinceEpoch(_diaryDate));
        } else if (state is PickImageSuccess) {
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
