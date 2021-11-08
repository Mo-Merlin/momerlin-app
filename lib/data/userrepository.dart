// import 'localstorage/auth_header.dart';
import 'localstorage/userdata_source.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class UserRepository {
  var url = "https://api.momerlin.com/api/";
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

  Future<dynamic> storeUser(dynamic udata) async {
    var save = UserDataSource().save(udata);
    print("save $save");
    return save;
  }

  Future<dynamic> updateUser(dynamic udata) async {
    var save = UserDataSource().updatefit(udata);
    print("save $save");
    return save;
  }

  Future<dynamic> storeToken(String token) async {
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
      print(checkres);
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print(e);
      return false;
    }
  }

//updateuser
  Future<dynamic> updateuser(id, fullname) async {
    print(
      "12345678 $id , $fullname",
    );
    try {
      var data = ({"fullName": fullname});
      var body = json.encode(data);
      var res = await http.put('${url + "user/$id"}',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      var checkres = jsonDecode(res.body);

      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print(e);
      return false;
    }
  }

//getuser
  Future<dynamic> getUser(id) async {
    try {
      // var url = "http://192.168.43.124:8000/api/leaderboard";

      var res = await http.get(
        '${url + "user/get?id=$id"}',
      );

      var checkres = jsonDecode(res.body);
      print("ALL LEADERBOARD COUNT :  ${checkres.length}");
      print("ALL LEADERBOARD :  $checkres");
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print("error");
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
    print("challangeid $challangeid");
    try {
      // var url = "http://192.168.43.124:8000/api/challenges";

      var res = await http.get(
        '${url + "/challenge/$challangeid"}',
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
  Future<dynamic> joingetchallenge(id, token) async {
    print("12345678 $id");

    try {
      var data = ({"token": token});
      var body = json.encode(data);
      var res = await http.put(
        '${url + "challenge/joined/$id?page=1&limit=10"}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var checkres = jsonDecode(res.body);
      // ignore: unnecessary_brace_in_string_interps
      print("checkres ${checkres}");

      return checkres;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> getAllLeaderboard() async {
    try {
      // var url = "http://192.168.43.124:8000/api/leaderboard";

      var res = await http.get(
        '${url + "leaderboard"}',
      );

      var checkres = jsonDecode(res.body);
      print("ALL LEADERBOARD COUNT :  ${checkres.length}");
      print("ALL LEADERBOARD :  $checkres");
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print("error");
      return false;
    }
  }

  Future<dynamic> getAllUsers() async {
    try {
      // var url = "http://192.168.43.124:8000/users";

      var res = await http.get(
        '${url + "users"}',
      );

      var checkres = jsonDecode(res.body);
      print("USERS : ${checkres.length}");
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print("error");
      return false;
    }
  }

  Future<dynamic> checkNickname(String nickName) async {
    try {
      // var url = "http://192.168.43.124:8000/api/user/checkName/:name";

      var res = await http.get(
        '${url + "user/checkName/$nickName"}',
      );

      var checkres = jsonDecode(res.body);
      print("Name count :  ${checkres.length}");
      print("Nick Names :  $checkres");
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print("error");
      return false;
    }
  }

  Future<dynamic> recentWinners() async {
    try {
      // var url = "http://192.168.43.124:8000/api/leaderboard";

      var res = await http.get(
        '${url + "challenges/winners"}',
      );

      var checkres = jsonDecode(res.body);
      // print("ALL LEADERBOARD COUNT :  ${checkres.length}");
      // print("ALL LEADERBOARD :  $checkres");
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print("error");
      return false;
    }
  }
}
