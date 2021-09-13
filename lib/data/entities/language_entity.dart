import 'entity.dart';

class LanguageEntity extends Entity<int> {
  final String heythereyounewhere,
      createWallet,
      importWallet,
      privacyPolicy,
      termsConditions,
      writedownthesewordsinorder,
      recoverykey,
      ihavewrittenthemdown,
      yourBalanceIs,
      sats,
      send,
      receive,
      earn,
      transaction,
      nikecom,
      minago;
  LanguageEntity({
    int id,
    this.heythereyounewhere,
    this.createWallet,
    this.importWallet,
    this.privacyPolicy,
    this.termsConditions,
    this.writedownthesewordsinorder,
    this.recoverykey,
    this.ihavewrittenthemdown,
    this.yourBalanceIs,
    this.sats,
    this.send,
    this.receive,
    this.earn,
    this.transaction,
    this.nikecom,
    this.minago,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'heythereyounewhere': heythereyounewhere,
      'createWallet': createWallet,
      'importWallet': importWallet,
      'privacyPolicy': privacyPolicy,
      'termsConditions': termsConditions,
      'writedownthesewordsinorder': writedownthesewordsinorder,
      'recoverykey': recoverykey,
      'ihavewrittenthemdown': ihavewrittenthemdown,
      'yourBalanceIs': yourBalanceIs,
      'sats': sats,
      'send': send,
      'receive': receive,
      'earn': earn,
      'transaction': transaction,
      'nikecom': nikecom,
      'minago': minago,
    };
  }

  @override
  List<Object> get props => [
        id,
        heythereyounewhere,
        createWallet,
        importWallet,
        privacyPolicy,
        termsConditions,
        writedownthesewordsinorder,
        recoverykey,
        ihavewrittenthemdown,
        yourBalanceIs,
        sats,
        send,
        receive,
        earn,
        transaction,
        nikecom,
        minago,
      ];
}
