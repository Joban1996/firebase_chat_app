import 'package:flutter_secure_storage/flutter_secure_storage.dart';
AndroidOptions _getAndroidOptions() => const AndroidOptions();
///Secure storage utils common class
class  SecureStorageUtils{

  static final SecureStorageUtils _instance =
  SecureStorageUtils._internal();

  factory SecureStorageUtils() {
    return _instance;
  }

  SecureStorageUtils._internal();

  late FlutterSecureStorage _secureStorage;

  Future<void> init() async {
    _secureStorage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  }

  ///Method for write new data
   Future<void> writeSecureData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }
  ///Method for read existing data
  Future<String?> readSecureData(String key) async {
    String? value = await _secureStorage.read(key: key);
    return value;
  }
  ///Method for delete data
  Future<void> deleteSecureData(String key) async {
    await _secureStorage.delete(key: key);
  }

  ///Secure storage delete all
  Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll();
  }

}