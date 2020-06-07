import 'package:get_it/get_it.dart';
import 'package:pals_hand/core/services/database_service.dart';
import 'package:pals_hand/core/services/dialog_service.dart';
import 'package:pals_hand/core/services/navigation_service.dart';
import 'package:pals_hand/core/viewmodels/home/friends_list_view_model.dart';
import 'package:pals_hand/core/viewmodels/home/my_list_view_model.dart';
import 'package:pals_hand/core/viewmodels/home/settings_view_model.dart';
import 'package:pals_hand/core/viewmodels/home/shopping_view_model.dart';
import 'package:pals_hand/core/viewmodels/login_view_model.dart';
import 'package:pals_hand/core/viewmodels/signup_view_model.dart';
import 'core/services/authentication_service.dart';
import 'core/viewmodels/home/home_view_model.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());

  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => SignupViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => MyListViewModel());
  locator.registerFactory(() => FriendsListViewModel());
  locator.registerFactory(() => ShoppingViewModel());
  locator.registerFactory(() => SettingsViewModel());
}
