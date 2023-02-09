import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/providers/log_provider.dart';
import 'package:social_instagram/utils/prefs_key.dart';

import '../modules/profile/repos/profile_repo.dart';
import '../providers/bloc_provider.dart';

enum AppState { loading, unAuthorized, authorized }

class AppStateBloc implements BlocBase {
  final _appState = BehaviorSubject<AppState>.seeded(AppState.loading);

  Stream<AppState> get appState => _appState.stream;

  AppState get appStateValue => _appState.stream.value;

  AppState get initState => AppState.loading;

  String langCode = 'en';

  LogProvider get logger => const LogProvider('⚡️ AppStateBloc');

  AppStateBloc() {
    launchApp();
  }

  Future<void> launchApp() async {
    final prefs = await SharedPreferences.getInstance();
    final authorLevel = prefs.getInt(PrefsKey.authorLevel) ?? 0;
    logger.log('authorLevel $authorLevel');
    //langCode = prefs.getString('langCode') ?? 'vi';

    switch (authorLevel) {
      case 2:
        await changeAppState(AppState.authorized);
        await saveProfileUser();
        break;
      default:
        await changeAppState(AppState.unAuthorized);
    }
  }

  Future<void> changeAppState(AppState state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PrefsKey.authorLevel, state.index);
    logger.log('changeAppState $state');

    _appState.sink.add(state);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    await changeAppState(AppState.unAuthorized);
  }

  // Hàm này s gọi profileUser để lấy ra thông tin của user đang đăng nhập và lưu vào shared preferences để lấy ra khi cần thiết
  static Future<void> saveProfileUser() async {
    final prefs = await SharedPreferences.getInstance();
    final profileUser = await ProfileRepo().getProfile();
    await prefs.setString(PrefsKey.profileUser, jsonEncode(profileUser));
  }

  // Hàm này sẽ lấy ra thông tin của user đang đăng nhập từ shared preferences
  static Future<User> getProfileUser() async {
    final prefs = await SharedPreferences.getInstance();
    final profileUser = prefs.getString(PrefsKey.profileUser);
    return User.fromJson(jsonDecode(profileUser!));
  }

  @override
  void dispose() {
    _appState.close();
  }
}
