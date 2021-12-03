// import 'localstorage/auth_header.dart';
import 'dart:io';

import 'package:momerlin/models/spendingreportsmodel.dart';

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
    // print("save $save");
    return save;
  }

  Future<dynamic> updateUser(dynamic udata) async {
    var save = UserDataSource().updatefit(udata);
    // print("save $save");
    return save;
  }

  Future<dynamic> updatehealthfit(dynamic udata) async {
    var save = UserDataSource().updatehealthfit(udata);
    // print("save $save");
    return save;
  }

  Future<dynamic> updateplaidlogin(dynamic udata) async {
    var save = UserDataSource().updateplaidlogin(udata);
    // print("save $save");
    return save;
  }

  Future<dynamic> storeToken(String token) async {
    var save = UserDataSource().savetoken(token);
    return save;
  }

  Future<dynamic> updateToken(data) async {
    try {
      var body = json.encode(data);
      var res = await http.post(Uri.parse('${url + "set_access_token"}'),
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
        (Uri.parse('${url + "create_link_token"}')),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var checkres = jsonDecode(res.body);
      // print(checkres);
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

      var res = await http.post((Uri.parse('${url + "user"}')),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      var checkres = jsonDecode(res.body);
      // print(checkres);
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print(e);
      return false;
    }
  }

//updateuser
  Future<dynamic> updateuser(id, fullname, image) async {
    // print(
    // "12345678 $id , $fullname",
    // );
    try {
      var data = ({"fullName": fullname, "imageUrl": image});
      var body = json.encode(data);
      var res = await http.put((Uri.parse('${url + "user/$id"}')),
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
        (Uri.parse('${url + "user/get?id=$id"}')),
      );

      var checkres = jsonDecode(res.body);

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
        (Uri.parse('${url + "transactions?address=$walletaddress"}')),
      );
      var checkres = jsonDecode(res.body);

      checkres["status"] = true;

      return checkres;
    } catch (e) {
      print(e);
      print("error");
      return false;
    }
  }
  //getspendingreports

  Future<dynamic> getSpendingReports(walletaddress) async {
    try {
      var res = await http.get(
        // '${url + "expenses?address=$walletaddress"}',
        (Uri.parse('${url + "myExpenses/$walletaddress"}')),
      );
      var checkres = jsonDecode(res.body);

      checkres["status"] = true;

      return checkres;
    } catch (e) {
      print(e);
      print("error");
      var checkres = false;
      //  checkres["status"]=false;
      return checkres;
    }
  }

  //GETFILTER
  Future<dynamic> getMyspendingReportsfilter(
      walletaddress, startdate, enddate) async {
    try {
      var res = await http.get(
        // '${url + "expenses?address=$walletaddress"}',
        (Uri.parse(
            '${url + "myExpenses/$walletaddress?startDate=$startdate&endDate=$enddate"}')),
      );
      var checkres = jsonDecode(res.body);

      checkres["status"] = true;

      return checkres;
    } catch (e) {
      print(e);
      print("error");
      return false;
    }
  }

  //GETearningFILTER
  Future<dynamic> getMyearningReportsfilter(id, startdate, enddate) async {
    try {
      var res = await http.get(
        // '${url + "expenses?address=$walletaddress"}',
        (Uri.parse(
            '${url + "myActivity/$id??startDate=$startdate&endDate=$enddate"}')),
      );
      var checkres = jsonDecode(res.body);

      checkres["status"] = true;

      return checkres;
    } catch (e) {
      print(e);
      print("error");
      return false;
    }
  }

  //getspendingreports

  Future<dynamic> getSpendingReportsbycategory(category, walletaddress) async {
    try {
      var res = await http.get(
        // '${url + "expenses?address=$walletaddress"}',
        (Uri.parse(
            '${url + "transactions/category/$category?address=$walletaddress"}')),
      );
      var checkres = jsonDecode(res.body);

      checkres["status"] = true;

      return checkres;
    } catch (e) {
      print(e);
      print("error");
      return false;
    }
  }
//getmyearningreports

  Future<dynamic> getmyEarningActivity(uid) async {
    try {
      var res = await http.get(
        (Uri.parse('${url + "myActivity/$uid"}')),
      );
      var checkres = jsonDecode(res.body);
      checkres["status"] = true;

      return checkres;
    } catch (e) {
      print(e);
      print("error");
      return false;
    }
  }

  Future<dynamic> getTransaction1(walletaddress) async {
    try {
      // var url = "http://192.168.43.124:8000/api/";
//
      var res = await http.get(
        (Uri.parse('${url + "momerlin/transactions?address=$walletaddress"}')),
      );
      var checkres = jsonDecode(res.body);
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      // print("PAVITHRA $e");
      print("error");

      return false;
    }
  }

  Future<dynamic> getChallenges() async {
    try {
      // var url = "http://192.168.43.124:8000/api/challenges";

      var res = await http.get(
        (Uri.parse('${url + "challenges"}')),
      );

      var checkres = jsonDecode(res.body);
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
        (Uri.parse('${url + "user/challenges?id=$id"}')),
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
        (Uri.parse('${url + "/challenge/$challangeid"}')),
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
    // print(data);
    try {
      var body = json.encode(data);

      var res = await http.post((Uri.parse('${url + "challenge/create"}')),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      var checkres = jsonDecode(res.body);
      print(checkres);
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      return false;
    }
  }

  // joining a challenge
  Future<dynamic> joiningchallenge(id, challengeId) async {
    try {
      var res = await http.put(
        (Uri.parse('${url + "challenge/join?id=$id&challenge=$challengeId"}')),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var checkres = jsonDecode(res.body);
      print(checkres);
      checkres["status"] = true;
      return checkres;
    } catch (e) {
      print(e);
      return false;
    }
  }

// getjoining a challenge
  Future<dynamic> joingetchallenge(id, token, distance) async {
    var data;
    try {
      if (Platform.isIOS) {
        data = ({"distance": distance});
      } else {
        data = ({
          "token": token,
        });
      }

      var body = json.encode(data);
      var res = await http.put(
        (Uri.parse('${url + "challenge/joined/$id?page=1&limit=10"}')),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var checkres = jsonDecode(res.body);

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
        (Uri.parse('${url + "leaderboard"}')),
      );

      var checkres = jsonDecode(res.body);
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
        (Uri.parse('${url + "users"}')),
      );

      var checkres = jsonDecode(res.body);
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
        (Uri.parse('${url + "user/checkName/$nickName"}')),
      );

      var checkres = jsonDecode(res.body);
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
        (Uri.parse('${url + "challenges/winners"}')),
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
