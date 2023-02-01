import 'package:exam1/presentation/pages/diary_form/diary_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DiaryForm extends StatefulWidget {
  final List<XFile>? imageList;

  const DiaryForm({
    super.key,
    required this.imageList,
  });

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

  late bool _isExistingEvent;
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
    DateFormat format = DateFormat('yyyy-MM-dd');

    _imageList = widget.imageList;

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

  //Callbacks
  void _onSelectImage() async {
    _imageList ??= [];

    BlocProvider.of<AddPhotoBloc>(context).add(
      PickImageEvent(
        imageList: _imageList!,
      ),
    );
  }

  void _onRemoveImage(int index) {
    BlocProvider.of<AddPhotoBloc>(context).add(
      RemoveImageEvent(
        index: index,
        imageList: _imageList!,
      ),
    );
  }

  void _uploadDiary() {
    BlocProvider.of<AddPhotoBloc>(context).add(UploadDiaryEvent(
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
    return Column(children: [
      //Static location only
      LocationWidget(
        location: _location,
      ),

      Container(
        color: const Color.fromARGB(255, 242, 245, 247),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
          child: Column(
            children: [
              //Header of the form
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
                child: Row(
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
                        child: Icon(Icons.help,
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
                  isLinkExistingEvent: _isExistingEvent,
                  onSelectEvent: (value) {
                    if (value != null) {
                      setState(() {
                        _eventID = value;
                      });
                    }
                  }),

              //Button for calling the api
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    key: const Key('next'),
                    onPressed: _uploadDiary,
                    child: const Text('Next'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
