flutter pub add intl
flutter pub add hive_flutter
flutter pub add hive
dart pub add dev:hive_generator
flutter pub add flutter_riverpod
dart pub add dev:riverpod_generator
flutter pub add riverpod_annotation
flutter pub add uuid
dart pub add dev:build_runner
flutter pub add dev:custom_lint
flutter pub add dev:riverpod_lint
flutter pub add flex_color_scheme
flutter pub add fluttertoast

flutter pub add flutter_native_splash
(dart run flutter_native_splash:create)

flutter pub add flutter_launcher_icons
(flutter pub run flutter_launcher_icons)
----------------------------------
add:
analyzer:
plugins:
- custom_lint
to analysis_options.yaml
- ---------------------------------
dart run build_runner build -d
----------------------------------
