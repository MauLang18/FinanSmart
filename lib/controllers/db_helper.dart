// ignore_for_file: avoid_print

import 'package:finance_app/pages/models/saving.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbHelper {
  late Box box;
  late Box box2;
  late Box box3;
  late SharedPreferences preferences;
  bool _isBox2Initialized = false;

  DbHelper() {
    initialize();
  }

  Future<void> initialize() async {
    await openBox();
  }

  openBox() async {
    box = await Hive.openBox('transaction');
    box2 = await Hive.openBox('saving');
    box3 = await Hive.openBox('budget');
    _isBox2Initialized = true;
  }

  Future<SavingModel?> getSavingData(int index) async {
    if (!_isBox2Initialized) {
      await initialize();
    }
    try {
      if (box2.isNotEmpty && index >= 0 && index < box2.length) {
        Map<dynamic, dynamic>? map = box2.getAt(index);
        if (map != null) {
          return SavingModel(
            map['amount'] as int,
            map['note'] as String,
            map['goalAmount'] as int,
          );
        }
      }
      return null;
    } catch (e) {
      print('Error retrieving saving data: $e');
      return null;
    }
  }

  void addData(int amount, DateTime date, String type, String note) async {
    if (!_isBox2Initialized) {
      await initialize();
    }
    var value = {'amount': amount, 'date': date, 'type': type, 'note': note};
    box.add(value);
  }

  void addSaving(int amount, String note, int goalAmount) async {
    if (!_isBox2Initialized) {
      await initialize();
    }
    var value = {'amount': amount, 'note': note, 'goalAmount': goalAmount};
    box2.add(value);
  }

  void addBudget(int amount, String note) async {
    if (!_isBox2Initialized) {
      await initialize();
    }
    var value = {'amount': amount, 'note': note};
    box3.add(value);
  }

  Future<void> updateSaving(
      int index, int amount, String note, int goalAmount) async {
    if (!_isBox2Initialized) {
      await initialize();
    }
    var value = {'amount': amount, 'note': note, 'goalAmount': goalAmount};
    box2.put(index, value);
  }

  Future deleteData(
    int index,
  ) async {
    await box.deleteAt(index);
  }

  Future deleteSaving(
    int index,
  ) async {
    await box2.deleteAt(index);
  }

  Future deleteBudget(
    int index,
  ) async {
    await box3.deleteAt(index);
  }

  Future cleanData() async {
    await box.clear();
    await box2.clear();
    await box3.clear();
  }

  addName(String name) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString('name', name);
  }

  getName() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString('name');
  }

  setLocalAuth(bool val) async {
    preferences = await SharedPreferences.getInstance();
    return preferences.setBool('auth', val);
  }

  Future<bool> getLocalAuth() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getBool('auth') ?? false;
  }
}
