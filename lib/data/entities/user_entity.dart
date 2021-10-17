import 'package:momerlin/data/entities/entity.dart';

class UserEntity extends Entity<int> {
  final String walletaddress;
  final String btctestaddress;
  final String btcmainaddress;
  final String seed;
  final String language;
  final String uid;

  UserEntity({
    int id,
    this.walletaddress,
    this.btctestaddress,
    this.btcmainaddress,
    this.seed,
    this.language,
    this.uid,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'walletaddress': walletaddress,
      'btctestaddress': btctestaddress,
      'btcmainaddress': btcmainaddress,
      'seed': seed,
      'language': language,
      'uid':uid
    };
  }

  @override
  List<Object> get props => [
        id,
        walletaddress,
        btctestaddress,
        btcmainaddress,
        seed,
        language,
        uid
      ];
}
