import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:studyQ/models/account_model.dart';

class SharedPreferencesService {
  static final _accountPreferenceKey = "account";

  static Future updateAccount(Account account) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_accountPreferenceKey);

    var accountJson = jsonEncode(account.toMap());
    prefs.setString(_accountPreferenceKey, accountJson);
    return;
  }

  static Future<Account> getAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonObject = prefs.getString(_accountPreferenceKey);
    Account account = Account(userName: "<unkown>");
    try {
      account = Account.fromMap(jsonDecode(jsonObject));
    } catch (e) {
      log("Could not decode account. JSON: " + jsonObject);
    }
    return account;
  }
}
