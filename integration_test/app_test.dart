import 'package:exam1/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'robots/add_image_screen_robot.dart';
import 'robots/comment_screen_robot.dart';
import 'robots/details_screen_robot.dart';
import 'robots/event_screen_robot.dart';
import 'robots/upload_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end app test', () {
    testWidgets('fill-out form and upload success', (tester) async {
      final AddImageScreenRobot imageScreen = AddImageScreenRobot(tester);
      final CommentScreenRobot commentScreen = CommentScreenRobot(tester);
      final DetailsScreenRobot detailsScreen = DetailsScreenRobot(tester);
      final EventScreenRobot eventScreen = EventScreenRobot(tester);
      final UploadRobot uploadButton = UploadRobot(tester);

      app.main();
      await tester.pumpAndSettle();

      // Picking of image
      await imageScreen.pickImage();
      await imageScreen.pickImage();
      await imageScreen.removeImage();

      // Input some text in comments field
      await commentScreen.inputComment(inputText: 'sample');

      // Filling out the details section of diary
      await detailsScreen.selectArea(areaSelected: 'Area 3');
      await detailsScreen.scrollPage(scrollDown: true);
      await detailsScreen.selectCategory(categorySelected: 'Task Category 2');
      await detailsScreen.inputTags(tagInput: 'sample');

      // Selecting an event
      await eventScreen.selectEvent(eventSelected: 'Event 1');

      await Future.delayed(const Duration(seconds: 2));

      // Uploading the data
      await uploadButton.uploadDiary();

      await Future.delayed(const Duration(seconds: 2));
    });
  });
}
