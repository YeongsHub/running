// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get navHome => 'Главная';

  @override
  String get navMap => 'Моя территория';

  @override
  String get navRun => 'Бег';

  @override
  String get navHistory => 'История';

  @override
  String get navSettings => 'Настройки';

  @override
  String get startRun => 'Начать пробежку';

  @override
  String get myStats => 'Моя статистика';

  @override
  String get totalRuns => 'Всего пробежек';

  @override
  String totalRunsValue(int count) {
    return '$count пробежки';
  }

  @override
  String get totalDistance => 'Общее расстояние';

  @override
  String get totalArea => 'Захваченная территория';

  @override
  String get statsLoadFailed => 'Не удалось загрузить статистику';

  @override
  String get noRunsYet =>
      'Пробежек пока нет.\nНачните бегать, чтобы захватывать территорию!';

  @override
  String errorMessage(Object error) {
    return 'Ошибка: $error';
  }

  @override
  String get territoryColor => 'Цвет территории';

  @override
  String get customColor => 'Другой цвет';

  @override
  String get customColorTitle => 'Выберите цвет';

  @override
  String get cancel => 'Отмена';

  @override
  String get select => 'Выбрать';

  @override
  String get version => 'Версия';

  @override
  String get pause => 'Пауза';

  @override
  String get resume => 'Продолжить';

  @override
  String get stop => 'Стоп';

  @override
  String get endRunTitle => 'Завершить пробежку';

  @override
  String get endRunMessage => 'Завершить пробежку и сохранить территорию?';

  @override
  String get save => 'Сохранить';

  @override
  String get distance => 'Расстояние';

  @override
  String get time => 'Время';

  @override
  String get pace => 'Темп';

  @override
  String get unitSystem => 'Система единиц';

  @override
  String get metric => 'Метрическая (км, м)';

  @override
  String get imperial => 'Имперская (мили, футы)';

  @override
  String get paceUnit => 'мин/км';

  @override
  String get paceUnitImperial => 'мин/миля';

  @override
  String get planFree => 'Бесплатно';

  @override
  String get planPro => 'Pro';

  @override
  String get upgradeToPro => 'Перейти на Pro';

  @override
  String get proFeatures => 'Функции Pro';

  @override
  String get proFeatureMultiplayer => 'Мультиплеерная карта';

  @override
  String get proFeatureMultiplayerDesc =>
      'Смотрите территории других игроков в реальном времени';

  @override
  String get proFeatureLeaderboard => 'Таблица лидеров';

  @override
  String get proFeatureLeaderboardDesc =>
      'Соревнуйтесь глобально по площади территории';

  @override
  String get proFeatureCloudSync => 'Синхронизация с облаком';

  @override
  String get proFeatureCloudSyncDesc =>
      'Резервное копирование пробежек и территорий на всех устройствах';

  @override
  String get proFeatureFriends => 'Друзья';

  @override
  String get proFeatureFriendsDesc =>
      'Соревнуйтесь с друзьями и смотрите их территории';

  @override
  String get proPrice => 'Разблокировать Pro — 499 ₽ (единоразово)';

  @override
  String get proUpgradeConfirmTitle => 'Перейти на Pro?';

  @override
  String get proUpgradeConfirmMessage =>
      'Это симулированная покупка. Нажмите Подтвердить, чтобы разблокировать все функции Pro.';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get proUnlocked => 'Pro разблокирован! Наслаждайтесь всеми функциями.';

  @override
  String get proAlreadyOwned => 'У вас уже есть Pro.';

  @override
  String get proLockedHint => 'Функция Pro — нажмите, чтобы перейти на Pro';

  @override
  String get currentPlan => 'Текущий план';

  @override
  String get territoryClaimed => 'Территория захвачена!';

  @override
  String get areaLabel => 'Площадь';

  @override
  String get done => 'Готово';

  @override
  String get loopCompleted => 'Круг завершён!';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get termsOfUse => 'Условия использования';
}
