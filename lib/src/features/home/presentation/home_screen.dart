import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matbook/src/features/achivnings/db/achivement_data_store.dart';
import 'package:matbook/src/utils/constants.dart';
import 'package:matbook/src/utils/date_time/date_time_adapter.dart';
import 'package:matbook/src/utils/my_toast.dart';

import '../../../db/data_model.dart';
import '../../../db/data_store.dart';
import '../../../utils/life_cycle.dart';
import '../providers/is_today.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final dataStore = ref.watch(dataStoreProvider);
    final isToday = ref.watch(isTodayProvider);
    final achivement = ref.watch(achivementDataStoreProvider);

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           ref.read(dataStoreProvider).clearAll();
        //         },
        //         icon: const Icon(Icons.delete))
        //   ],
        // ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(200, 100, 100, 0),
          onPressed: isToday
              ? () {
                  MyToast.showMyToast('Dziś już pogłówkowałeś nad matmą.');
                  _addDataToDatabase(ref);
                  ref.read(achivementDataStoreProvider).addNewAchivement();
                }
              : () {
                  _addDataToDatabase(ref);
                  ref.read(achivementDataStoreProvider).addNewAchivement();
                },
          child: const Icon(Icons.add),
        ),
        body: Stack(
          children: [
            const Image(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              width: double.infinity,
              color: const Color.fromARGB(130, 0, 0, 0),
              height: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
              child: Column(
                children: [
                  // Służy do monitorowania boxu
                  ValueListenableBuilder(
                      valueListenable: dataStore.datesListenable(),
                      // box.listenable
                      builder: (_, box, child) {
                        final myDateObject = box.getAt(0);
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  myDateObject!.date,
                                  style: TextStyling.getSubMainTextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Text(
                              '\nDni nauki: ${myDateObject.days}',
                              style: TextStyling.getMainTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        );
                      }),
                  ValueListenableBuilder(
                      valueListenable: achivement.achivementListenable(),
                      builder: (_, box, child) {
                        return Column(
                          children: [
                            Text(
                              box.values.last.nameOfAchivement,
                              style: TextStyling.getSubMainTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      })
                ],
              ),
            ),
            ConfettiWidget(
              confettiController: achivement.confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              blastDirection: pi / 2,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 120,
              gravity: 0.05,
            ),
          ],
        ),
      ),
    );
  }

  void _addDataToDatabase(WidgetRef ref) {
    // ustawienie zmiennej isToday na true
    ref.read(isTodayProvider.notifier).setIsToday();
    final readStore = ref.read(dataStoreProvider);
    final oldDate = readStore.getMyDate();
    final newDate = MyDate.create(
      // zwiększenie liczby dni nauki o 1
      days: oldDate.days + 1,
      // zamiana dzisiejszej DateTime na String YYYY MM DD
      date: DateTimeAdapter.getDateTime(DateTime.now()),
    );
    // zamiana starej daty na dzisiejszą w bazie danych
    readStore.addNextDate(newDate);
  }

  @override
  void dispose() {
    ref.read(achivementDataStoreProvider).disposeConfetti();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // przy każdej zmianie stanu aplikacji (LifeCycle) wywoływana będzie metoda
    // _refreshContent(), która bada czy jest nowy dzień, niezapisany jeszcze
    // w bazie
    WidgetsBinding.instance
        .addObserver(LifecycleEventHandler(resumeCallBack: () async {
      return _refreshContent(ref.read(dataStoreProvider));
    }));
  }

  _refreshContent(DataStore dataStore) {
    // pobiera datę zapisaną w bazie danych
    final dateFromDB = dataStore.getMyDate().date;
    // dzisiejszą datę adaptuje do formatu zapisywanego w bazie (YYYY MM DD)
    final today = DateTimeAdapter.getDateTime(DateTime.now());
    // ustawia zmienną isToday w zależności od tego czy daty są te same
    // zmienna isToday decyduje o tym, czy FAB będzie reagował na kliknięcie
    // zwiększając liczbę dni nauki i dodając nową datę do bazy
    if (dateFromDB == today) {
      ref.read(isTodayProvider.notifier).setIsToday();
    } else {
      ref.read(isTodayProvider.notifier).setIsNotToday();
    }
  }
}
