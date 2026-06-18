import 'package:flutter/material.dart';
import 'package:milio/repositories/dummy_data.dart';
import '../../models/user_model.dart';
import '../../models/project_model.dart';
import '../../models/wallet_transaction_model.dart';

class AppState extends ChangeNotifier {
  User get currentUser => DummyRepository.currentUser;

  List<Project> get myProjects =>
      DummyRepository.isClientMode ? DummyRepository.clientProjects : DummyRepository.myProjects;

  List<WalletTransaction> get transactions => DummyRepository.transactions;

  bool get isClientMode => DummyRepository.isClientMode;

  void switchRole() {
    DummyRepository.isClientMode = !DummyRepository.isClientMode;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  // Simulate wallet credit after approval
  void addTransaction(WalletTransaction txn) {
    DummyRepository.transactions.insert(0, txn);
    notifyListeners();
  }
}
