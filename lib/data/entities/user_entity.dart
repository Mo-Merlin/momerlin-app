import 'package:momerlin/data/entities/entity.dart';

class UserEntity extends Entity<int> {
  final String userId;
  final String name;
  final String walletaddress;
  final String btctestaddress;
  final String btcmainaddress;
  final String seed;
  final String currency;
  final String language;

  UserEntity({
    int id,
    this.userId,
    this.name,
    this.walletaddress,
    this.btctestaddress,
    this.btcmainaddress,
    this.seed,
    this.currency,
    this.language,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'walletaddress': walletaddress,
      'btctestaddress': btctestaddress,
      'btcmainaddress': btcmainaddress,
      'seed': seed,
      'currency': currency,
      'language': language,
    };
  }

  @override
  List<Object> get props => [
        id,
        userId,
        name,
        walletaddress,
        btctestaddress,
        btcmainaddress,
        seed,
        currency,
        language,
      ];
}
