// import 'localstorage/auth_header.dart';
import 'localstorage/userdata_source.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class UserRepository {
  var url = "http://52.66.200.27:8000/api/";
  Future<bool> isSignedIn() async {
    // Read the keystore
    // signOut();
    final currentUser = await UserDataSource().getUser();
    if (currentUser.length != 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> storeUser(dynamic udata) async {
    var save = UserDataSource().save(udata);
    print("save $save");
    return save;
  }

  Future<bool> storeToken(String token) async {
    var save = UserDataSource().savetoken(token);
    return save;
  }

  Future<dynamic> updateToken(data) async {
    try {
      var body = json.encode(data);
      var res = await http.post('${url + "set_access_token"}',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      var checkres = jsonDecode(res.body);

      return checkres;
    } catch (e) {
      print("error");
      print("Error" + e);
    }
  }

  Future<dynamic> getToken() async {
    try {
      var res = await http.post(
        '${url + "create_link_token"}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var checkres = jsonDecode(res.body);

      return checkres;
    } catch (e) {
      print("error");
      print("Error" + e);
    }
  }

  //usersave
  Future<dynamic> adduser(data) async {
    try {
      var body = json.encode(data);

      var res = await http.post('${url + "user"}',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      var checkres = jsonDecode(res.body);
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> getTransaction(walletaddress) async {
    try {
      var res = await http.get(
        '${url + "transactions?address=$walletaddress"}',
      );
      var checkres = jsonDecode(res.body);

      return checkres;
    } catch (e) {
      print("error");
      print("Error" + e);
    }
  }

  Future<dynamic> getTransaction1(walletaddress) async {
    print("walletaddress $walletaddress");
    try {
      // var url = "http://192.168.43.124:8000/api/";
//
      var res = await http.get(
        '${url + "momerlin/transactions?address=$walletaddress"}',
      );
      var checkres = jsonDecode(res.body);

      return checkres;
    } catch (e) {
      print("error");
      print("Error" + e);
      return e;
    }
  }

  Future<dynamic> getChallenges() async {
    try {
      // var url = "http://192.168.43.124:8000/api/challenges";

      var res = await http.get(
        '${url + "challenges"}',
      );

      var checkres = jsonDecode(res.body);

      return checkres;
    } catch (e) {
      print("error");
      print("Error" + e);
    }
  }

  //getmychallange
  Future<dynamic> getmyChallenges(id) async {
    try {
      // var url = "http://192.168.43.124:8000/api/challenges";

      var res = await http.get(
        '${url + "user/challenges?id=$id"}',
      );

      var checkres = jsonDecode(res.body);
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print("error");
      return false;
    }
  }

  //create challange
  Future<dynamic> createchallenge(data) async {
    print(data);
    try {
      var body = json.encode(data);

      var res = await http.post('${url + "challenge/create"}',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      var checkres = jsonDecode(res.body);

      checkres["status"] = true;
      return checkres;
    } catch (e) {
      return false;
    }
  }
}
