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

      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print("error");

      return false;
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
      print(checkres);
      checkres["status"] = true;
      checkres["success"] = true;
      return checkres;
    } catch (e) {
      print("error");
      return false;
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
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print("error");
      return false;
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
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print("error");

      return false;
    }
  }

  Future<dynamic> getChallenges() async {
    try {
      // var url = "http://192.168.43.124:8000/api/challenges";

      var res = await http.get(
        '${url + "challenges"}',
      );

      var checkres = jsonDecode(res.body);
      print("2345678 $checkres");
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print("error");
      return false;
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
  Future<dynamic> getwinnerChallenges(challangeid) async {
    try {
      // var url = "http://192.168.43.124:8000/api/challenges";

      var res = await http.get(
        '${url + "challenge/winners?id=$challangeid"}',
      );

      var checkres = jsonDecode(res.body);
      print("PAVIMANO $checkres");
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

  // joining a challenge
  Future<dynamic> joiningchallenge(id, challengeId) async {
    print("USER ID " +
        id.toString() +
        "  CHALLENGE ID " +
        challengeId.toString());
    try {
      var res = await http.put(
        '${url + "challenge/join?id=$id&challenge=$challengeId"}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var checkres = jsonDecode(res.body);

      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print(e);
      return false;
    }
  }

// getjoining a challenge
  Future<dynamic> joingetchallenge(id) async {
    print("12345678 $id");
    try {
      var res = await http.get(
        Uri.parse(
          '${url + "/challenge/joined?id=$id"}',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var checkres = jsonDecode(res.body);
      print("checkres ${checkres.length}");
    
      return checkres;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
