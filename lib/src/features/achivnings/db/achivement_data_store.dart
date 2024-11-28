import 'package:confetti/confetti.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../db/data_model.dart';
import 'achivement.dart';

class AchivementDataStore {
  static const String achiveBoxName = 'achivement';
  static const String dateBoxName = 'dates';
  final confettiController =
      ConfettiController(duration: const Duration(seconds: 2));

  void disposeConfetti() {
    confettiController.dispose();
  }

  void addNewAchivement() {
    final achiveBox = Hive.box<Achivement>(achiveBoxName);
    final dateBox = Hive.box<MyDate>(dateBoxName);
    final days = dateBox.getAt(0)!.days;
    switch (days) {
      case 0:
        achiveBox.add(Achivement.create(nameOfAchivement: 'Brak osiągnięć'));
        break;
      case 1:
        confettiController.play();
        achiveBox.add(Achivement.create(
            nameOfAchivement: 'Brawo, pierwszy '
                'dzień nauki!'));
        break;

      case 7:
        confettiController.play();
        achiveBox.add(Achivement.create(
            nameOfAchivement: 'Brawo, pierwszy '
                'tydzień nauki!'));
        break;

      case 14:
        confettiController.play();
        achiveBox.add(Achivement.create(
            nameOfAchivement: 'Brawo, drugi '
                'tydzień nauki!'));
        break;

      case 21:
        confettiController.play();

        achiveBox.add(Achivement.create(
            nameOfAchivement: 'Brawo, trzeci '
                'tydzień nauki!'));
        break;

      case 28:
        confettiController.play();

        achiveBox.add(Achivement.create(
            nameOfAchivement: 'Brawo, pierwszy '
                'miesiąc nauki!'));
        break;

      case 56:
        confettiController.play();
        achiveBox.add(Achivement.create(
            nameOfAchivement: 'Brawo, drugi '
                'miesiąc nauki!'));
        break;

      case 84:
        confettiController.play();
        achiveBox.add(Achivement.create(
            nameOfAchivement: 'Brawo, trzeci '
                'miesiąc nauki!'));
        break;

      case 112:
        confettiController.play();
        achiveBox.add(Achivement.create(
            nameOfAchivement: 'Brawo, czwarty '
                'miesiąc nauki!'));
        break;

      case 140:
        confettiController.play();
        achiveBox.add(Achivement.create(
            nameOfAchivement: 'Brawo, piąty '
                'miesiąc nauki!'));
        break;

      case 168:
        confettiController.play();
        achiveBox.add(Achivement.create(
            nameOfAchivement: 'Brawo, pół '
                'roku nauki!'));
        break;

      case 336:
        confettiController.play();
        achiveBox.add(Achivement.create(
            nameOfAchivement: 'Brawo, pierwszy '
                'rok nauki!'));
        break;
      default:
        achiveBox.add(Achivement.create(nameOfAchivement: ''));
    }
  }

  void clearAll() {
    final achiveBox = Hive.box<Achivement>(achiveBoxName);

    achiveBox.clear();
  }

  Achivement getLastAchivement() {
    final achiveBox = Hive.box<Achivement>(achiveBoxName);

    if (achiveBox.isEmpty) {
      addNewAchivement();
    }
    return achiveBox.values.last;
  }

  ValueListenable<Box<Achivement>> achivementListenable() {
    final achiveBox = Hive.box<Achivement>(achiveBoxName);

    if (achiveBox.isEmpty) {
      addNewAchivement();
    }
    return achiveBox.listenable();
  }
}

final achivementDataStoreProvider = Provider<AchivementDataStore>((ref) {
  return AchivementDataStore();
});
