class DatabaseConfig {
  static const String databaseName = 'momerlinapp.db';
  static const int databaseVersion = 2;
  static const createTableQueries = [
    'CREATE TABLE IF NOT EXISTS Seed (id INTEGER PRIMARY KEY, seed TEXT)',
    'CREATE TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY, userId TEXT, name TEXT, walletaddress TEXT, btctestaddress TEXT, btcmainaddress TEXT, seed TEXT, currency TEXT, language TEXT)',
    'CREATE TABLE IF NOT EXISTS LanguageTable (id INTEGER PRIMARY KEY, heythereyounewhere TEXT, createWallet TEXT, importWallet TEXT, privacyPolicy TEXT, termsConditions TEXT, writedownthesewordsinorder TEXT,recoverykey TEXT, ihavewrittenthemdown TEXT,yourBalanceIs TEXT,sats TEXT,send TEXT,receive TEXT,earn TEXT,transaction TEXT,nikecom TEXT,minago TEXT,sendfunds TEXT,iwanttosend TEXT,to TEXT,scanqrcode TEXT,btcaddress TEXT,pleasedoublecheckyourrecipientsinfo TEXT,sendnow TEXT,pastefromclipboard TEXT,justlikemagicyourealldone TEXT,thoughitmaytakeourmagicminstoreachyourdestination TEXT,sendmore TEXT,gohome TEXT,yourprofile TEXT,momoomer TEXT,earnofreferredearnings TEXT,minwithdraw TEXT,currentgasfeeestimated TEXT,selectcurrency TEXT,support TEXT,followus TEXT,aboutus TEXT,)',
  ];
}
