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
    print(data);
    try {
      // var config = await Firestore.instance.collection('config').getDocuments();
      // var url = config.documents[0].data['API_URL_GAM'];
      var body = json.encode(data);
      // print("body $body");
      // var url = "http://192.168.43.124:8000/api/";

      var res = await http.post('${url + "set_access_token"}',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      var checkres = jsonDecode(res.body);
      print("checkres $checkres");
      return checkres;
    } catch (e) {
      print("error");
      print("Error" + e);
    }
  }

  Future<dynamic> getToken() async {
    try {
      // var url = "http://192.168.43.124:8000/api/";

      var res = await http.post(
        '${url + "create_link_token"}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var checkres = jsonDecode(res.body);
      print("checkres $checkres");
      return checkres;
    } catch (e) {
      print("error");
      print("Error" + e);
    }
  }

  Future<dynamic> getTransaction(walletaddress) async {
    try {
      // var url = "http://192.168.43.124:8000/api/";
//
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
    }
  }

  Future<dynamic> getChallenges() async {
    try {
      // var url = "http://192.168.43.124:8000/api/challenges";

      var res = await http.get(
        '${url + "challenges"}',
      );

      var checkres = jsonDecode(res.body);
      print("NO OF CHALLENGES : "+ checkres.length.toString());
      
      return checkres;
    } catch (e) {
      print("error");
      print("Error" + e);
    }
  }
}
