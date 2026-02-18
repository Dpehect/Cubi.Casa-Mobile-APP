import 'package:get_storage/get_storage.dart';

class CacheService {
  static final CacheService _instance = CacheService._internal();
  late final GetStorage _storage;

  factory CacheService() {
    return _instance;
  }

  CacheService._internal();

  Future<void> initialize() async {
    _storage = GetStorage();
  }

  Future<void> save<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? read<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  Future<void> clear() async {
    await _storage.erase();
  }

  bool hasKey(String key) {
    return _storage.hasData(key);
  }

  Future<void> saveList<T>(String key, List<T> list) async {
    await _storage.write(key, list);
  }

  List<T>? readList<T>(String key) {
    final data = _storage.read<List>(key);
    if (data != null) {
      return data.cast<T>();
    }
    return null;
  }
}
