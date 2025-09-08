import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _key = "session_id";

  // Save session id
  static Future<void> saveSessionId(String sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, sessionId);
  }

  // Get session id
  static Future<String?> getSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  // Clear session id (logout case)
  static Future<void> clearSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
