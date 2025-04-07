import 'dart:convert';

import 'package:hive/hive.dart';

class HiveService {
  final String _boxName = "myBox";

  Future<Box<String>> get _box async => await Hive.openBox<String>(_boxName);

  /// CRUD

  Future<void> create(Map<String, dynamic> value) async {
    final box = await _box;
    var data = json.encode(value);
    await box.add(data);
    print("saved");
  }

  Future<List<dynamic>> readAll() async {
    try {
      final box = await _box;
      List<dynamic> dataList = [];
      for (var value in box.values) {
        print(value);
        dataList.add(json.decode(value));
      }
      print("loaded");
      return dataList;
    } catch (e) {
      print("error :$e");
      return [];
    }
  }


  Future<void> update(int index, Map<String, dynamic> newValue) async {
    final box = await _box;
    var data = json.encode(newValue);
    await box.putAt(index, data);
    print("updated");
  }

  Future<void> delete(int key) async {
    final box = await _box;
    await box.deleteAt(key);
    print("removed");
  }

  // Future<Map<String, dynamic>?> read(String key) async {
  //   final box = await _box;
  //   print("the box : ${box.toString()}");
  //   return {};
  //   // return box.get(key);
  // }

}
