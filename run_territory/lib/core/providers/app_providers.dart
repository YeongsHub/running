import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:run_territory/data/repositories/run_repository_impl.dart';
import 'package:run_territory/data/repositories/territory_repository_impl.dart';
import 'package:run_territory/data/sources/local/database_helper.dart';
import 'package:run_territory/data/sources/local/friends_local_source.dart';
import 'package:run_territory/data/sources/local/run_local_source.dart';
import 'package:run_territory/data/sources/local/territory_local_source.dart';
import 'package:run_territory/domain/entities/friend.dart';
import 'package:run_territory/domain/entities/run_session.dart';
import 'package:run_territory/domain/repositories/run_repository.dart';
import 'package:run_territory/domain/repositories/territory_repository.dart';
import 'package:run_territory/domain/usecases/claim_territory.dart';
import 'package:run_territory/domain/usecases/get_my_territories.dart';

final databaseHelperProvider = Provider<DatabaseHelper>((ref) => DatabaseHelper());

final runLocalSourceProvider = Provider<RunLocalSource>((ref) {
  return RunLocalSource(ref.watch(databaseHelperProvider));
});

final runRepositoryProvider = Provider<RunRepository>((ref) {
  return RunRepositoryImpl(ref.watch(runLocalSourceProvider));
});

final territoryLocalSourceProvider = Provider<TerritoryLocalSource>((ref) {
  return TerritoryLocalSource(ref.watch(databaseHelperProvider));
});

final territoryRepositoryProvider = Provider<TerritoryRepository>((ref) {
  return TerritoryRepositoryImpl(ref.watch(territoryLocalSourceProvider));
});

final claimTerritoryUseCaseProvider = Provider<ClaimTerritoryUseCase>((ref) {
  return ClaimTerritoryUseCase(ref.watch(territoryRepositoryProvider));
});

final getMyTerritoriesUseCaseProvider = Provider<GetMyTerritoriesUseCase>((ref) {
  return GetMyTerritoriesUseCase(ref.watch(territoryRepositoryProvider));
});

// 전체 런 기록 — DB 쿼리를 한 번만 실행하고 캐싱
final runHistoryProvider = FutureProvider<List<RunSession>>((ref) async {
  return ref.watch(runRepositoryProvider).getAllSessions();
});

// false = 미터법(기본), true = 야드파운드법(미국)
final useImperialProvider = StateProvider<bool>((ref) => false);

final statsProvider = FutureProvider((ref) async {
  return ref.watch(runRepositoryProvider).getStats();
});

// Pro 여부 — SharedPreferences로 영속
class IsProNotifier extends AsyncNotifier<bool> {
  static const _key = 'is_pro';

  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  Future<void> unlock() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
    state = const AsyncData(true);
  }
}

final isProProvider = AsyncNotifierProvider<IsProNotifier, bool>(IsProNotifier.new);

// ─── Friends ────────────────────────────────────────────────────────────────

final friendsLocalSourceProvider = Provider<FriendsLocalSource>((ref) {
  return FriendsLocalSource(ref.watch(databaseHelperProvider));
});

class FriendsNotifier extends AsyncNotifier<List<Friend>> {
  @override
  Future<List<Friend>> build() async {
    return ref.watch(friendsLocalSourceProvider).getAllFriends();
  }

  Future<void> addFriend(Friend friend) async {
    await ref.read(friendsLocalSourceProvider).upsertFriend(friend);
    ref.invalidateSelf();
  }

  Future<void> removeFriend(String id) async {
    await ref.read(friendsLocalSourceProvider).deleteFriend(id);
    ref.invalidateSelf();
  }
}

final friendsProvider = AsyncNotifierProvider<FriendsNotifier, List<Friend>>(FriendsNotifier.new);

// 내 고유 사용자 ID (앱 설치 시 1회 생성, 공유 코드 생성에 사용)
final myUserIdProvider = FutureProvider<String>((ref) async {
  const key = 'my_user_id';
  final prefs = await SharedPreferences.getInstance();
  var id = prefs.getString(key);
  if (id == null) {
    id = const Uuid().v4();
    await prefs.setString(key, id);
  }
  return id;
});

// 내 닉네임
class MyNameNotifier extends AsyncNotifier<String> {
  static const _key = 'my_display_name';

  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key) ?? 'Runner';
  }

  Future<void> setName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, name);
    state = AsyncData(name);
  }
}

final myNameProvider = AsyncNotifierProvider<MyNameNotifier, String>(MyNameNotifier.new);
