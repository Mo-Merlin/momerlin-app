// import 'package:bam_wallet/data/local/user_data_source.dart';

import 'package:momerlin/data/localstorage/userdata_source.dart';

header() async {
  final token = await UserDataSource().gettoken();
  return <String, String>{
    "x-access-token": token,
    "Content-Type": "application/json; charset=UTF-8",
  };
}
