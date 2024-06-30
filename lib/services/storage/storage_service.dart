import 'package:get_storage/get_storage.dart';

class StorageService {
  static GetStorage box = GetStorage();

  //get data
  static get(String key) => box.read(key);

  //set data
  static Future set(String key, value) async => await box.write(key, value);

  //remove data
  static Future remove(String key) async => await box.remove(key);
}
