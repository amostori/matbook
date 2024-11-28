import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:matbook/src/features/achivnings/db/achivement.dart';
import 'package:matbook/src/utils/date_time/date_time_adapter.dart';

import 'data_model.dart';

class DataStore {
  static const String boxName = 'dates';
  static const String achiveBoxName = 'achivement';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<MyDate>(MyDateAdapter());
    await Hive.openBox<MyDate>(boxName);

    Hive.registerAdapter<Achivement>(AchivementAdapter());
    await Hive.openBox<Achivement>(achiveBoxName);
  }

  void addNewDate(MyDate newDate) {
    final box = Hive.box<MyDate>(boxName);
    // dodaje nową datę do listy dat pod indexem 0
    box.add(newDate);
  }

  void addNextDate(MyDate newDate) {
    final box = Hive.box<MyDate>(boxName);
    // podmienia nową datę za starą w indexie 0
    box.putAt(0, newDate);
  }

  void clearAll() {
    final box = Hive.box<MyDate>(boxName);
    box.clear();
  }
  // zwraca datę zapisaną w bazie
  MyDate getMyDate() {
    final box = Hive.box<MyDate>(boxName);
    if (box.isEmpty) {
      // jeśli box jest pusty dodaje przykładową datę tworząc box
      final exampleDate = DateTimeAdapter.getDateTime(DateTime(2024, 11, 19));
      addNewDate(MyDate.create(days: 0, date: exampleDate));
    }
    return box.getAt(0)!;
  }

  // zwraca box jako obiekt listenable (który można nasłuchiwać)
  ValueListenable<Box<MyDate>> datesListenable() {
    final box = Hive.box<MyDate>(boxName);
    // jeśli box będzie pusty pojawi się błąd
    if (box.isEmpty) {
      final exampleDate = DateTimeAdapter.getDateTime(DateTime(2019, 8, 6));
      addNewDate(MyDate.create(days: 0, date: exampleDate));
    }
    return box.listenable();
  }
}

final dataStoreProvider = Provider<DataStore>((ref) {
  // jako że obiekt dataStore jest tworzony w metodzie main() aplikacji, tutaj
  // nie powinien być tworzony by nie powstały dwa.
  throw UnimplementedError();
});
