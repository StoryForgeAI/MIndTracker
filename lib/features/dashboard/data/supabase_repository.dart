import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/session_stats.dart';
import '../../tracking/domain/usage_log.dart';
import '../../blocking/domain/blocked_app.dart';
import '../../../core/config/supabase_config.dart';

abstract class SupabaseRepository {
  Future<void> saveUsageLog(UsageLog log);
  Future<void> saveBlockedApp(BlockedApp app);
  Future<void> saveSessionStats(SessionStats stats);
  Future<SessionStats?> getLatestSessionStats(String userId);
}

class SupabaseRepositoryImpl implements SupabaseRepository {
  final SupabaseClient _client;

  SupabaseRepositoryImpl(this._client);

  @override
  Future<void> saveUsageLog(UsageLog log) async {
    try {
      await _client.from(SupabaseConfig.usageLogsTable).upsert(log.toJson());
    } catch (e) {
      // Handle error silently in production
    }
  }

  @override
  Future<void> saveBlockedApp(BlockedApp app) async {
    try {
      await _client.from(SupabaseConfig.blockedAppsTable).upsert(app.toJson());
    } catch (e) {
      // Handle error silently in production
    }
  }

  @override
  Future<void> saveSessionStats(SessionStats stats) async {
    try {
      await _client.from(SupabaseConfig.sessionStatsTable).upsert(stats.toJson());
    } catch (e) {
      // Handle error silently in production
    }
  }

  @override
  Future<SessionStats?> getLatestSessionStats(String userId) async {
    try {
      final response = await _client
          .from(SupabaseConfig.sessionStatsTable)
          .select()
          .eq('user_id', userId)
          .order('date', ascending: false)
          .limit(1)
          .single();
      return SessionStats.fromJson(response);
    } catch (e) {
      // Handle error silently in production
      return null;
    }
  }
}
