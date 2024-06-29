import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get notesListPageTitle => 'Мои дела';

  @override
  String get todoImportance_basic => 'Нет';

  @override
  String get todoImportance_low => 'Низкий';

  @override
  String get todoImportance_important => '!! Высокий';

  @override
  String completedNotesCountText(Object count) {
    return 'Выполнено — $count';
  }

  @override
  String get saveText => 'Сохранить';

  @override
  String get whatShouldBeDoneText => 'Что надо сделать...';

  @override
  String get importanceText => 'Важность';

  @override
  String get deadlineText => 'Сделать до';

  @override
  String get deleteButtonTitle => 'Удалить';

  @override
  String get createNew => 'Новая заметка...';

  @override
  String get simpleError => 'Что-то пошло не так...';

  @override
  String get someDay => 'Когда-нибудь';
}
