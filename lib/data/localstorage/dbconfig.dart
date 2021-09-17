class DatabaseConfig {
  static const String databaseName = 'momerlinapp.db';
  static const int databaseVersion = 1;
  static const createTableQueries = [
    'CREATE TABLE IF NOT EXISTS Seed (id INTEGER PRIMARY KEY, seed TEXT)',
    'CREATE TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY, walletaddress TEXT, btctestaddress TEXT, btcmainaddress TEXT, seed TEXT, language TEXT)',
    'CREATE TABLE IF NOT EXISTS LanguageTable (id INTEGER PRIMARY KEY, heythereyounewhere TEXT, createWallet TEXT, importWallet TEXT, privacyPolicy TEXT, termsConditions TEXT, writedownthesewordsinorder TEXT)',
  ];
}
