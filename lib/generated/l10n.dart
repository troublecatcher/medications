// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Ask a question`
  String get askAQuestion {
    return Intl.message(
      'Ask a question',
      name: 'askAQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get termsOfUse {
    return Intl.message(
      'Terms of Use',
      name: 'termsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Share app`
  String get shareApp {
    return Intl.message(
      'Share app',
      name: 'shareApp',
      desc: '',
      args: [],
    );
  }

  /// `Rate the app`
  String get rateTheApp {
    return Intl.message(
      'Rate the app',
      name: 'rateTheApp',
      desc: '',
      args: [],
    );
  }

  /// `About the app`
  String get aboutTheApp {
    return Intl.message(
      'About the app',
      name: 'aboutTheApp',
      desc: '',
      args: [],
    );
  }

  /// `About application`
  String get aboutApplication {
    return Intl.message(
      'About application',
      name: 'aboutApplication',
      desc: '',
      args: [],
    );
  }

  /// `Version {version}`
  String versionVersion(Object version) {
    return Intl.message(
      'Version $version',
      name: 'versionVersion',
      desc: '',
      args: [version],
    );
  }

  /// `Error: couldn\'t fetch current version`
  String get errorCouldntFetchCurrentVersion {
    return Intl.message(
      'Error: couldn\\\'t fetch current version',
      name: 'errorCouldntFetchCurrentVersion',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load Terms of Use`
  String get failedToLoadTermsOfUse {
    return Intl.message(
      'Failed to load Terms of Use',
      name: 'failedToLoadTermsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load Privacy Policy`
  String get failedToLoadPrivacyPolicy {
    return Intl.message(
      'Failed to load Privacy Policy',
      name: 'failedToLoadPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Your question has been successfully sent!`
  String get yourQuestionHasBeenSuccessfullySent {
    return Intl.message(
      'Your question has been successfully sent!',
      name: 'yourQuestionHasBeenSuccessfullySent',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while sending the question`
  String get somethingWentWrongWhileSendingTheQuestion {
    return Intl.message(
      'Something went wrong while sending the question',
      name: 'somethingWentWrongWhileSendingTheQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Topic of the question`
  String get topicOfTheQuestion {
    return Intl.message(
      'Topic of the question',
      name: 'topicOfTheQuestion',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Your message`
  String get yourMessage {
    return Intl.message(
      'Your message',
      name: 'yourMessage',
      desc: '',
      args: [],
    );
  }

  /// `Medications`
  String get medications {
    return Intl.message(
      'Medications',
      name: 'medications',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Added`
  String get added {
    return Intl.message(
      'Added',
      name: 'added',
      desc: '',
      args: [],
    );
  }

  /// `Add medication`
  String get addMedication {
    return Intl.message(
      'Add medication',
      name: 'addMedication',
      desc: '',
      args: [],
    );
  }

  /// `Change medication`
  String get changeMedication {
    return Intl.message(
      'Change medication',
      name: 'changeMedication',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Medication name`
  String get medicationName {
    return Intl.message(
      'Medication name',
      name: 'medicationName',
      desc: '',
      args: [],
    );
  }

  /// `Release form`
  String get releaseForm {
    return Intl.message(
      'Release form',
      name: 'releaseForm',
      desc: '',
      args: [],
    );
  }

  /// `ICON`
  String get icon {
    return Intl.message(
      'ICON',
      name: 'icon',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Delete medication`
  String get deleteMedication {
    return Intl.message(
      'Delete medication',
      name: 'deleteMedication',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get schedule {
    return Intl.message(
      'Schedule',
      name: 'schedule',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Morning`
  String get morning {
    return Intl.message(
      'Morning',
      name: 'morning',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Evening`
  String get evening {
    return Intl.message(
      'Evening',
      name: 'evening',
      desc: '',
      args: [],
    );
  }

  /// `Night`
  String get night {
    return Intl.message(
      'Night',
      name: 'night',
      desc: '',
      args: [],
    );
  }

  /// `Add schedule`
  String get addSchedule {
    return Intl.message(
      'Add schedule',
      name: 'addSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Change schedule`
  String get changeSchedule {
    return Intl.message(
      'Change schedule',
      name: 'changeSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Measure`
  String get measure {
    return Intl.message(
      'Measure',
      name: 'measure',
      desc: '',
      args: [],
    );
  }

  /// `Starts`
  String get starts {
    return Intl.message(
      'Starts',
      name: 'starts',
      desc: '',
      args: [],
    );
  }

  /// `Ends`
  String get ends {
    return Intl.message(
      'Ends',
      name: 'ends',
      desc: '',
      args: [],
    );
  }

  /// `Doesn't end`
  String get doesntEnd {
    return Intl.message(
      'Doesn\'t end',
      name: 'doesntEnd',
      desc: '',
      args: [],
    );
  }

  /// `Time of intake {number}`
  String timeOfIntakeNumber(Object number) {
    return Intl.message(
      'Time of intake $number',
      name: 'timeOfIntakeNumber',
      desc: '',
      args: [number],
    );
  }

  /// `Add time of intake`
  String get addTimeOfIntake {
    return Intl.message(
      'Add time of intake',
      name: 'addTimeOfIntake',
      desc: '',
      args: [],
    );
  }

  /// `Add more`
  String get addMore {
    return Intl.message(
      'Add more',
      name: 'addMore',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get reminder {
    return Intl.message(
      'Reminder',
      name: 'reminder',
      desc: '',
      args: [],
    );
  }

  /// `No medicine`
  String get noMedicine {
    return Intl.message(
      'No medicine',
      name: 'noMedicine',
      desc: '',
      args: [],
    );
  }

  /// `The day is empty`
  String get theDayIsEmpty {
    return Intl.message(
      'The day is empty',
      name: 'theDayIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Medication schedules will appear here`
  String get medicationSchedulesWillAppearHere {
    return Intl.message(
      'Medication schedules will appear here',
      name: 'medicationSchedulesWillAppearHere',
      desc: '',
      args: [],
    );
  }

  /// `{title} medications will be stored here`
  String titleMedicationsWillBeStoredHere(Object title) {
    return Intl.message(
      '$title medications will be stored here',
      name: 'titleMedicationsWillBeStoredHere',
      desc: '',
      args: [title],
    );
  }

  /// `Medication`
  String get medication {
    return Intl.message(
      'Medication',
      name: 'medication',
      desc: '',
      args: [],
    );
  }

  /// `Don't forget to take {medicationname}`
  String dontForgetToTakeMedicationname(Object medicationname) {
    return Intl.message(
      'Don\'t forget to take $medicationname',
      name: 'dontForgetToTakeMedicationname',
      desc: '',
      args: [medicationname],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
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
