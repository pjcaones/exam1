import 'dart:io';

import 'package:exam1/presentation.dart';
import 'package:exam1/presentation.dart' as get_it;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:integration_test/integration_test.dart';
import 'package:localizely_sdk/localizely_sdk.dart';
import 'package:path_provider/path_provider.dart';

import 'robots/add_image_screen_robot.dart';
import 'robots/comment_screen_robot.dart';
import 'robots/details_screen_robot.dart';
import 'robots/event_screen_robot.dart';
import 'robots/upload_robot.dart';

void main() {
  Future<List<XFile>> mockImageList({required int testImageCountToLoad}) async {
    final List<XFile> testImageList = [];

    for (int imageCount = 1; imageCount <= testImageCountToLoad; imageCount++) {
      final ByteData data =
          await rootBundle.load('assets/images/sample_image1.jpeg');
      final Uint8List bytes = data.buffer.asUint8List();
      final Directory tempDir = await getTemporaryDirectory();
      final File file = await File(
        '${tempDir.path}/tmp.tmp',
      ).writeAsBytes(bytes);
      testImageList.add(XFile(file.path));
    }

    return testImageList;
  }

  void runDiaryApp({required List<XFile> testImageList}) {
    get_it.init();

    const sdkToken = 'af46981a623c443f8ac5c5e28ec376bc1648cd15';
    const distributionId = '2629f09b51fa470b8cd5de819d9a520a';

    Localizely.init(
      sdkToken,
      distributionId,
    );
    Localizely.setPreRelease(true);
    runApp(
      ModularApp(
        module: DiaryModule(
          isTestMode: true,
          testImageList: testImageList,
        ),
        child: const MyApp(),
      ),
    );
  }

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end app test', () {
    testWidgets('fill-out form and upload', (tester) async {
      final AddImageScreenRobot imageScreen = AddImageScreenRobot(tester);
      final CommentScreenRobot commentScreen = CommentScreenRobot(tester);
      final DetailsScreenRobot detailsScreen = DetailsScreenRobot(tester);
      final EventScreenRobot eventScreen = EventScreenRobot(tester);
      final UploadRobot uploadButton = UploadRobot(tester);

      final List<XFile> imageList =
          await mockImageList(testImageCountToLoad: 2);
      runDiaryApp(testImageList: imageList);
      await tester.pumpAndSettle();

      // Picking of image
      // Can't automate actual picking of image from gallery
      // Alternative: added sample images to preload in the image list card
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
      // For given sample image list, it always throw fail upload.
      // It is because of the fake api - always returning "Payload Too Large"
      // root cause: convertion of image to base64 string
      await uploadButton.uploadDiary(uploadResult: UploadResult.fail);

      await Future.delayed(const Duration(seconds: 2));
    });
  });
}
