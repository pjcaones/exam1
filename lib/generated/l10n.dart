// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localizely_sdk/localizely_sdk.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    if (!Localizely.hasMetadata()) {
      Localizely.setMetadata(_metadata);
    }
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static final Map<String, List<String>> _metadata = {
    'appName': [],
    'buttonAddPhoto': [],
    'buttonNext': [],
    'buttonOK': [],
    'dateFormatyyyyMMdd': [],
    'diaryFormPage': [],
    'diaryMessageAddSiteDiary': [],
    'diaryMessageFillUpDiary': [],
    'diaryMessageIncludePhotoGallery': [],
    'diaryTitleAddPhotos': [],
    'diaryTitleComments': [],
    'diaryTitleDetails': [],
    'diaryTitleEvent': [],
    'errorMessageDefault': [],
    'errorMessageFailedUpload': [],
    'keyAddPhoto': [],
    'keyArea': [],
    'keyCategory': [],
    'keyDiaryDate': [],
    'keyEvent': [],
    'keyNext': [],
    'textfieldLabelArea': [],
    'textfieldLabelCategory': [],
    'textfieldLabelComment': [],
    'textfieldLabelEvent': [],
    'textfieldLabelTags': [],
    'uploadDiarySuccessMessage': [],
    'uploadFailed': [],
    'uploadSuccess': []
  };

  /// `Exam 1`
  String get appName {
    return Intl.message(
      'Exam 1',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Add a photo`
  String get buttonAddPhoto {
    return Intl.message(
      'Add a photo',
      name: 'buttonAddPhoto',
      desc: 'Add photo button',
      args: [],
    );
  }

  /// `Next`
  String get buttonNext {
    return Intl.message(
      'Next',
      name: 'buttonNext',
      desc: 'Next button',
      args: [],
    );
  }

  /// `OK`
  String get buttonOK {
    return Intl.message(
      'OK',
      name: 'buttonOK',
      desc: 'Button OK',
      args: [],
    );
  }

  /// `yyyy-MM-dd`
  String get dateFormatyyyyMMdd {
    return Intl.message(
      'yyyy-MM-dd',
      name: 'dateFormatyyyyMMdd',
      desc: 'Dateformat for yyyy-MM-dd',
      args: [],
    );
  }

  /// `New Diary`
  String get diaryFormPage {
    return Intl.message(
      'New Diary',
      name: 'diaryFormPage',
      desc: '',
      args: [],
    );
  }

  /// `Add to site diary`
  String get diaryMessageAddSiteDiary {
    return Intl.message(
      'Add to site diary',
      name: 'diaryMessageAddSiteDiary',
      desc: 'Text for add to site diary',
      args: [],
    );
  }

  /// `Fill up to add in site diary`
  String get diaryMessageFillUpDiary {
    return Intl.message(
      'Fill up to add in site diary',
      name: 'diaryMessageFillUpDiary',
      desc: 'Text for fill up to add in site diary',
      args: [],
    );
  }

  /// `Include in photo gallery`
  String get diaryMessageIncludePhotoGallery {
    return Intl.message(
      'Include in photo gallery',
      name: 'diaryMessageIncludePhotoGallery',
      desc: 'Text for include photo gallery',
      args: [],
    );
  }

  /// `Add Photos to site diary`
  String get diaryTitleAddPhotos {
    return Intl.message(
      'Add Photos to site diary',
      name: 'diaryTitleAddPhotos',
      desc: 'Add Photos',
      args: [],
    );
  }

  /// `Comments`
  String get diaryTitleComments {
    return Intl.message(
      'Comments',
      name: 'diaryTitleComments',
      desc: 'Title comments',
      args: [],
    );
  }

  /// `Details`
  String get diaryTitleDetails {
    return Intl.message(
      'Details',
      name: 'diaryTitleDetails',
      desc: 'diary title for details',
      args: [],
    );
  }

  /// `Link to existing event?`
  String get diaryTitleEvent {
    return Intl.message(
      'Link to existing event?',
      name: 'diaryTitleEvent',
      desc: 'diary title for events',
      args: [],
    );
  }

  /// `Something went wrong..`
  String get errorMessageDefault {
    return Intl.message(
      'Something went wrong..',
      name: 'errorMessageDefault',
      desc: 'Default error message',
      args: [],
    );
  }

  /// `Failed to upload the diary.`
  String get errorMessageFailedUpload {
    return Intl.message(
      'Failed to upload the diary.',
      name: 'errorMessageFailedUpload',
      desc: 'error message for failed upload',
      args: [],
    );
  }

  /// `add_photo`
  String get keyAddPhoto {
    return Intl.message(
      'add_photo',
      name: 'keyAddPhoto',
      desc: 'Add photo key',
      args: [],
    );
  }

  /// `area`
  String get keyArea {
    return Intl.message(
      'area',
      name: 'keyArea',
      desc: 'key for area dropdown',
      args: [],
    );
  }

  /// `category`
  String get keyCategory {
    return Intl.message(
      'category',
      name: 'keyCategory',
      desc: 'key for category dropdown',
      args: [],
    );
  }

  /// `diary_date`
  String get keyDiaryDate {
    return Intl.message(
      'diary_date',
      name: 'keyDiaryDate',
      desc: 'key for diary date',
      args: [],
    );
  }

  /// `event`
  String get keyEvent {
    return Intl.message(
      'event',
      name: 'keyEvent',
      desc: 'key for event dropdown',
      args: [],
    );
  }

  /// `next`
  String get keyNext {
    return Intl.message(
      'next',
      name: 'keyNext',
      desc: 'key for next button',
      args: [],
    );
  }

  /// `Select Area`
  String get textfieldLabelArea {
    return Intl.message(
      'Select Area',
      name: 'textfieldLabelArea',
      desc: 'Text label for Areas',
      args: [],
    );
  }

  /// `Task Category`
  String get textfieldLabelCategory {
    return Intl.message(
      'Task Category',
      name: 'textfieldLabelCategory',
      desc: 'Text label for category dropdown',
      args: [],
    );
  }

  /// `Comments`
  String get textfieldLabelComment {
    return Intl.message(
      'Comments',
      name: 'textfieldLabelComment',
      desc: 'hint for comment textfield',
      args: [],
    );
  }

  /// `Select an event`
  String get textfieldLabelEvent {
    return Intl.message(
      'Select an event',
      name: 'textfieldLabelEvent',
      desc: 'text label for event',
      args: [],
    );
  }

  /// `Tags`
  String get textfieldLabelTags {
    return Intl.message(
      'Tags',
      name: 'textfieldLabelTags',
      desc: 'text label for tags textfield',
      args: [],
    );
  }

  /// `Your diary has been uploaded!`
  String get uploadDiarySuccessMessage {
    return Intl.message(
      'Your diary has been uploaded!',
      name: 'uploadDiarySuccessMessage',
      desc: 'Message for upload diary success',
      args: [],
    );
  }

  /// `Upload Failed`
  String get uploadFailed {
    return Intl.message(
      'Upload Failed',
      name: 'uploadFailed',
      desc: 'Upload Failed',
      args: [],
    );
  }

  /// `Upload Success`
  String get uploadSuccess {
    return Intl.message(
      'Upload Success',
      name: 'uploadSuccess',
      desc: 'Upload Success',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
