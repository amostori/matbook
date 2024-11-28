import 'package:matbook/src/utils/date_time/date_time_adapter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../db/data_store.dart';
part 'is_today.g.dart';

@riverpod
class IsToday extends _$IsToday {
  @override
  bool build() {
    final myDate = ref.read(dataStoreProvider).getMyDate().date;
    final today = DateTimeAdapter.getDateTime(DateTime.now());
    // jeśli dzisiejszy dzień jest tożsamy z datą zapisaną w bazie danych isToday
    // zwróci true
    return myDate == today;
  }

  void setIsToday() {
    state = true;
  }

  void setIsNotToday() {
    state = false;
  }
}
