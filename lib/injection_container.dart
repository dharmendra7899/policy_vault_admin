import 'package:get_it/get_it.dart';
import 'package:policy_vault_admin/features/side_menu/provider/side_menu_provider.dart';
import 'package:policy_vault_admin/helper/session_manager.dart';
import 'package:policy_vault_admin/network/api_client.dart';
import 'package:policy_vault_admin/network/api_client_imp.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  var pref = await SharedPreferences.getInstance();

  serviceLocator.registerLazySingleton<ApiClient>(
    () => ApiClientImp(sessionManager: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<SessionManager>(
    () => SessionManagerImp(sharedPreferences: pref),
  );

  serviceLocator.registerLazySingleton(() => SideMenuProvider());
  //
  // //Auth
  //   serviceLocator.registerFactory<AuthRepo>(
  //     () => AuthService(
  //       apiClient: serviceLocator(),
  //     ),
  //   );
  //
  //   //Quiz
  //
  //   serviceLocator.registerFactory<QuizRepo>(
  //     () => QuizService(
  //       apiClient: serviceLocator(),
  //     ),
  //   );
  //
  //   //Subject
  //
  //   serviceLocator.registerFactory<SubjectRepo>(() => SubjectService(
  //         apiClient: serviceLocator(),
  //       ));
  //
  //   //User
  //
  //   serviceLocator.registerFactory<UserRepo>(
  //       () => UserService(apiClient: serviceLocator()));
  //
  //   //Dashboard
  //
  //   serviceLocator.registerFactory<DashboardRepo>(
  //       () => DashboardService(apiClient: serviceLocator()));
  //
  //   //setsQuizQuestion
  //
  //   serviceLocator.registerFactory<SetQuizRepo>(
  //       () => SetQuizService(apiClient: serviceLocator()));
  //
  //   //contestSection
  //   serviceLocator.registerFactory<ContestRepo>(
  //           () => ContestService(apiClient: serviceLocator()));
  //
  //   //badgeSection
  //   serviceLocator.registerFactory<BadgeRepo>(
  //     () => BadgeService(apiClient: serviceLocator()),
  //   );
}
