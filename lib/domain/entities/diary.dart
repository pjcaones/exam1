class Diary {
  const Diary({
    required this.location,
    required this.imageList,
    required this.comment,
    required this.diaryDateInMillis,
    required this.areaID,
    required this.taskCategoryID,
    required this.tags,
    required this.eventID,
  });
  final String location;

  //For add photo part
  final List<String> imageList;

  //for comment part
  final String comment;

  //for details part
  final int diaryDateInMillis;
  final int areaID;
  final int taskCategoryID;
  final String tags;

  //for linking event
  final int eventID;
}
