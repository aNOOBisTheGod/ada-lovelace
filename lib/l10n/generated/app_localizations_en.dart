import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get notesListPageTitle => 'My tasks';

  @override
  String get todoImportance_basic => 'None';

  @override
  String get todoImportance_low => 'Low';

  @override
  String get todoImportance_important => '!! High';

  @override
  String completedNotesCountText(Object count) {
    return 'Completed — $count';
  }

  @override
  String get saveText => 'Save';

  @override
  String get whatShouldBeDoneText => 'What should be done...';

  @override
  String get importanceText => 'Importance';

  @override
  String get deadlineText => 'Deadline';

  @override
  String get deleteButtonTitle => 'Delete';

  @override
  String get createNew => 'Create new...';

  @override
  String get simpleError => 'Something went wrong...';

  @override
  String get someDay => 'Some day';
}
