import 'dart:convert';

import 'package:expense_tracker/authentication/domain/login_success.dart';
import 'package:expense_tracker/authentication/register_user.dart';
import 'package:expense_tracker/budget_tracker/budget.dart';
import 'package:expense_tracker/expense_tracker/expense.dart';
import 'package:expense_tracker/users/login_user.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class ExpensesHttpClient {
  var client = http.Client();

  Future<ExpenseTracker>? createExpense(ExpenseTracker? expenseTracker) async {
    var url = Uri.https(ApiPaths.baseUrl, ApiPaths.expenseList);
    var response = await http.post(url, body: expenseTracker?.toJson());
    return ExpenseTracker.fromJson(jsonDecode(response.body));
  }

  // Future<List<ExpenseTracker>>? getExpenses() async {
  //   var url = Uri.https(ApiPaths.baseUrl, ApiPaths.expenseList);
  //   var response = await http.get(url);
  //   final data = json.decode(response.body);
  //   return data
  //       .map((item) => ExpenseTracker.fromJson(item as Map<String, dynamic>))
  //       .toList();
  // }
  Future<List<ExpenseTracker>> getExpenses() async {
    var url = Uri.https(ApiPaths.baseUrl, ApiPaths.expenseList);
    var response = await http.get(url);
    final data = json.decode(response.body) as List<dynamic>;

    return data
        .map((item) => ExpenseTracker.fromJson(item as Map<String, dynamic>))
        .toList()
        .cast<ExpenseTracker>();
  }

  Future<ExpenseTracker>? updateExpense(ExpenseTracker? expenseTracker) async {
    var url = Uri.https(ApiPaths.baseUrl, ApiPaths.expenseList);
    var response = await http.patch(url, body: expenseTracker?.toJson());
    return ExpenseTracker.fromJson(jsonDecode(response.body));
  }

  Future<void>? deleteExpense(ExpenseTracker? expenseTracker) async {
    var url = Uri.https(
        ApiPaths.baseUrl, '${ApiPaths.expenses}/${expenseTracker?.id}');
    await http.delete(url);
    return;
  }
}

class BudgetHttpClient {
  var client = http.Client();

  Future<BudgetTracker>? createBudget(BudgetTracker? budgetTracker) async {
    var url = Uri.https(ApiPaths.baseUrl, ApiPaths.budgetList);
    var response = await http.post(url, body: budgetTracker?.toJson());
    return BudgetTracker.fromJson(jsonDecode(response.body));
  }

  Future<BudgetTracker>? updateBudget(BudgetTracker? budgetTracker) async {
    var url =
        Uri.https(ApiPaths.baseUrl, '${ApiPaths.budgets}${budgetTracker?.id}/');
    var response = await http.patch(url, body: budgetTracker?.toJson());
    return BudgetTracker.fromJson(jsonDecode(response.body));
  }

  Future<BudgetTracker> getBudget(int? id) async {
    var url = Uri.https(ApiPaths.baseUrl, '${ApiPaths.budgets}/$id/');
    var response = await http.get(url);
    return BudgetTracker.fromJson(jsonDecode(response.body));
  }

  Future<List<BudgetTracker>> getBudgets() async {
    var url = Uri.https(ApiPaths.baseUrl, ApiPaths.budgetList);
    var response = await http.get(url);

    List<dynamic> data = json.decode(response.body);
    return data
        .map((item) => BudgetTracker.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteBudgetTracker(BudgetTracker? budgetTracker) async {
    var url =
        Uri.https(ApiPaths.baseUrl, "${ApiPaths.budgets}/${budgetTracker?.id}");
    await http.delete(url);
    return;
  }
}

class UserHttpsClient {
  var client = http.Client();

  Future<List<LoginUser>> getUser(int? id) async {
    var url = Uri.https(ApiPaths.baseUrl, '${ApiPaths.users}/$id/');
    var response = await http.get(url);

    List<dynamic> data = json.decode(response.body);
    return data
        .map((item) => LoginUser.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<LoginUser>? patchUser(LoginUser? myUser) async {
    var url = Uri.https(ApiPaths.baseUrl, '${ApiPaths.users}${myUser?.email}/');
    var response = await http.patch(url, body: myUser?.toJson());
    return LoginUser.fromJson(jsonDecode(response.body));
  }

  Future<LoginUser>? createUser(LoginUser? myUser) async {
    var url = Uri.https(ApiPaths.baseUrl, ApiPaths.userList);
    var response = await http.post(url, body: myUser?.toJson());
    return LoginUser.fromJson(jsonDecode(response.body));
  }
}

class LoginHttpsClient {
  var client = http.Client();
  Future<LoginSuccess>? createUser(LoginUser? myUser) async {
    var url = Uri.https(ApiPaths.baseUrl, ApiPaths.login);
    var response = await http.post(url, body: myUser?.toJson());
    return LoginSuccess.fromJson(jsonDecode(response.body));
  }
}

class RegisterHttpsClient {
  Future<LoginSuccess> createUser(RegisterUser? registerUser) async {
    var url = Uri.https(ApiPaths.baseUrl, ApiPaths.registration);
    var response = await http.post(url, body: registerUser?.toJson());
    return LoginSuccess.fromJson(jsonDecode(response.body));
  }
}
