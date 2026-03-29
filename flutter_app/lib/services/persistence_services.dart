import 'package:shared_preferences/shared_preferences.dart';
import '../config/pref_keys.dart';

class PersistenceService {
  static final PersistenceService _manager = PersistenceService._internal();
  SharedPreferences? _preferences;

  factory PersistenceService() {
    return _manager;
  }

  static const _themeKey = 'app_theme_mode';
  Future<void> saveThemeMode(String theme) async {
    await _ensurePreferenceLoaded();
    _preferences!.setString(_themeKey, theme);
  }

  Future<String> getThemeMode() async {
    await _ensurePreferenceLoaded();
    return _preferences!.getString(_themeKey) ?? 'system';
  }

  Future<void> _ensurePreferenceLoaded() async {
    _manager._preferences ??= await SharedPreferences.getInstance();
  }

  Future<bool> getSignInStatus() async {
    await _manager._ensurePreferenceLoaded();
    return _manager._preferences!.getBool(PrefKeys.signInStatusKey) ?? false;
  }

  Future<void> saveSignInStatus(bool signInStatus) async {
    await _manager._ensurePreferenceLoaded();
    _manager._preferences!.setBool(PrefKeys.signInStatusKey, signInStatus);
  }

  Future<void> saveUserEmail(String userEmail) async {
    await _manager._ensurePreferenceLoaded();
    _manager._preferences!.setString(PrefKeys.userEmail, userEmail);
  }

  Future<String?> getUserEmail() async {
    await _manager._ensurePreferenceLoaded();
    return _manager._preferences!.getString(PrefKeys.userEmail);
  }

  // ───── Save / Get User Name ─────────
  Future<void> saveUserName(String name) async {
    await _ensurePreferenceLoaded();
    _preferences!.setString(PrefKeys.userName, name);
  }

  Future<String?> getUserName() async {
    await _ensurePreferenceLoaded();
    return _preferences!.getString(PrefKeys.userName);
  }

  // ───── Save / Get User Role ─────────
  Future<void> saveUserRole(String role) async {
    await _ensurePreferenceLoaded();
    _preferences!.setString(PrefKeys.userRole, role);
  }

  Future<String?> getUserRole() async {
    await _ensurePreferenceLoaded();
    return _preferences!.getString(PrefKeys.userRole);
  }

  // ─── add these two methods ───────────────────────────────

  Future<void> saveOnboardingComplete() async {
    await _manager._ensurePreferenceLoaded();
    _manager._preferences!.setBool(PrefKeys.onboardingComplete, true);
  }

  Future<bool> getOnboardingComplete() async {
    await _manager._ensurePreferenceLoaded();
    return _manager._preferences!.getBool(PrefKeys.onboardingComplete) ?? false;
  }

  // ─────────────────────────────────────────────────────────

  Future<void> signOut() async {
    await _manager._ensurePreferenceLoaded();
    await _manager._preferences!.remove(PrefKeys.userEmail);
    await _manager._preferences!.remove(PrefKeys.signInStatusKey);
    // note: we do NOT remove onboardingComplete on signout
    // onboarding should only show once ever, not on every login
  }

  PersistenceService._internal();
}
