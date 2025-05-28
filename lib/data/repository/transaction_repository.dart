import 'package:expense_tracker/data/services/local_storage_service.dart';
import 'package:expense_tracker/domain/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionRepository {
  Future<bool> addTransaction(Map<String, dynamic> data) async {
    try {
      await LocalStorageService.save(data["id"].toString(), data);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<List<Transaction>?> getAllTransaction() async {
    try {
      List data = LocalStorageService.readAll();
      return data.map((e) => Transaction.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
