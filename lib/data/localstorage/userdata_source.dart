import 'package:momerlin/data/entities/language_entity.dart';

import 'data_source.dart';

class UserDataSource extends DataSource {
  String get primaryKey => 'id';

  String get tableName => 'User';
  String get tableSeed => 'Seed';
  String get languageTable => 'LanguageTable';

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
    ));

    final List<Map<String, dynamic>> maps = await db.query(languageTable);

    return maps != null;
  }

  Future<dynamic> getLanguage() async {
    await checkDatabaseConnection();
    final maps = await db.query(languageTable);

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

  Future<bool> logout() async {
    await deleteAll();
    final maps = await db.query(tableName);
    return maps.length == 0;
  }
}
