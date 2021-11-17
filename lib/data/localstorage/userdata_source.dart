import 'package:momerlin/data/entities/language_entity.dart';
import 'package:momerlin/data/entities/token_entity.dart';
import 'package:momerlin/data/entities/user_entity.dart';

import 'data_source.dart';

class UserDataSource extends DataSource {
  String get primaryKey => 'id';

  String get tableToken => 'Token';
  String get tableName => 'User';
  String get tableSeed => 'Seed';
  String get languageTable => 'LanguageTable';
  @override
  Future<List<UserEntity>> all() async {
    checkDatabaseConnection();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return UserEntity(
        id: maps[i]['id'],
        walletaddress: maps[i]['walletaddress'],
        btctestaddress: maps[i]['btctestaddress'],
        btcmainaddress: maps[i]['btcmainaddress'],
        seed: maps[i]['seed'],
        uid: maps[i]["uid"],
        language: maps[i]['language'],
        googlefitenable: maps[i]['googlefitenable'],
        plaidlogin: maps[i]['plaidlogin'],
        healthfitenable: maps[i]['healthfitenable'],
      );
    });
  }

  Future<bool> checkUserData() async {
    await checkDatabaseConnection();
    int id = 1;
    final maps = await db.query(tableName, where: '"id" = $id');
    return (maps.length == 0) ? false : true;
  }

  Future<String> gettoken() async {
    await checkDatabaseConnection();
    final maps = await db.query(tableToken);
    return maps[0]["token"].toString();
  }

  Future<bool> savetoken(String token) async {
    await checkDatabaseConnection();
    await insertToken(TokenEntity(token: token));
    final List<Map<String, dynamic>> maps = await db.query(tableToken);
    return maps != null;
  }

  Future<bool> saveLang(dynamic udata) async {
    await insertLang(LanguageEntity(
      heythereyounewhere: udata[0]['heythereyounewhere'],
      createWallet: udata[0]['createWallet'],
      importWallet: udata[0]['importWallet'],
      privacyPolicy: udata[0]['privacyPolicy'],
      termsConditions: udata[0]['termsConditions'],
      writedownthesewordsinorder: udata[0]['writedownthesewordsinorder'],
      recoverykey: udata[0]['recoverykey'],
      ihavewrittenthemdown: udata[0]['ihavewrittenthemdown'],
      yourBalanceIs: udata[0]['yourBalanceIs'],
      sats: udata[0]['sats'],
      send: udata[0]['send'],
      receive: udata[0]['receive'],
      earn: udata[0]['earn'],
      transaction: udata[0]['transaction'],
      nikecom: udata[0]['nikecom'],
      minago: udata[0]['minago'],
      sendfunds: udata[0]['sendfunds'],
      iwanttosend: udata[0]['iwanttosend'],
      to: udata[0]['to'],
      scanqrcode: udata[0]['scanqrcode'],
      btcaddress: udata[0]['btcaddress'],
      pleasedoublecheckyourrecipientsinfo: udata[0]
          ['pleasedoublecheckyourrecipientsinfo'],
      sendnow: udata[0]['sendnow'],
      pastefromclipboard: udata[0]['pastefromclipboard'],
      justlikemagicyourealldone: udata[0]['justlikemagicyourealldone'],
      thoughitmaytakeourmagicminstoreachyourdestination: udata[0]
          ['thoughitmaytakeourmagicminstoreachyourdestination'],
      sendmore: udata[0]['sendmore'],
      gohome: udata[0]['gohome'],
      yourprofile: udata[0]['yourprofile'],
      momoomer: udata[0]['momoomer'],
      earnofreferredearnings: udata[0]['earnofreferredearnings'],
      minwithdraw: udata[0]['minwithdraw'],
      currentgasfeeestimated: udata[0]['currentgasfeeestimated'],
      selectcurrency: udata[0]['selectcurrency'],
      support: udata[0]['support'],
      followus: udata[0]['followus'],
      aboutus: udata[0]['aboutus'],
    ));

    final List<Map<String, dynamic>> maps = await db.query(languageTable);

    return maps != null;
  }

  Future<dynamic> getLanguage() async {
    await checkDatabaseConnection();
    final maps = await db.query(languageTable);

    return maps;
  }

  Future<dynamic> save(
    dynamic udata,
  ) async {
    await insert(UserEntity(
        walletaddress: udata['address'],
        btctestaddress: udata['btcTestnetAddress'],
        btcmainaddress: udata['btcMainnetAddress'],
        seed: udata['seed'],
        uid: udata["uid"],
        language: udata['language'],
        googlefitenable: udata['googlefitenable'],
        plaidlogin: udata['plaidlogin'],
        healthfitenable: udata['healthfitenable']));
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return maps != null;
  }

  Future<dynamic> getUser() async {
    await checkDatabaseConnection();
    final maps = await db.query(tableName);
    return maps;
  }

  Future<dynamic> updateLanguage(String lang) async {
    var row = {'language': lang};
    await checkDatabaseConnection();
    await db.update(
      tableName,
      row,
      where: 'id = 1',
    );
    // final maps = await db.query(tableName);
    await deleteLang();
    // return await UserRepository().updateLanguage(maps[0]['language']);
  }

  Future<dynamic> updatefit(googlefitenable) async {
    var row = {'googlefitenable': googlefitenable};
    await checkDatabaseConnection();
    await db.update(
      tableName,
      row,
      where: 'id = 1',
    );
  }

  Future<dynamic> updatehealthfit(healthfitenable) async {
    var row = {'healthfitenable': healthfitenable};
    await checkDatabaseConnection();
    await db.update(
      tableName,
      row,
      where: 'id = 1',
    );
    return true;
  }
  Future<dynamic> updateplaidlogin(plaidlogin) async {
    var row = {'plaidlogin': plaidlogin};
    await checkDatabaseConnection();
    await db.update(
      tableName,
      row,
      where: 'id = 1',
    );
    return true;
  }

  Future<bool> logout() async {
    await deleteAll();
    final maps = await db.query(tableName);
    return maps.length == 0;
  }
}
