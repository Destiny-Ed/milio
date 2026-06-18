import 'package:flutter/material.dart';
import 'package:milio/repositories/dummy_data.dart';
import '../../models/user_model.dart';
import '../../models/project_model.dart';
import '../models/transaction_model.dart';

class AppState extends ChangeNotifier {
  User get currentUser => DummyRepository.currentUser;

  List<Project> get myProjects =>
      DummyRepository.isClientMode ? DummyRepository.clientProjects : DummyRepository.myProjects;

  List<Transaction> get transactions => DummyRepository.transactions;

  // bool get isClientMode => DummyRepository.isClientMode;

  String? role; // client | freelancer | admin
  bool isClientMode = true;

  bool get isAuthenticated => role != null;

  bool get isAdmin => role == 'admin';

  void switchRoleMode() {
    isClientMode = !isClientMode;
    notifyListeners();
  }

  void setRole(String newRole) {
    role = newRole;

    // default mode mapping
    isClientMode = newRole == "client";

    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  // Simulate wallet credit after approval
  void addTransaction(Transaction txn) {
    DummyRepository.transactions.insert(0, txn);
    notifyListeners();
  }
}
