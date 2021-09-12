import 'entity.dart';

class LanguageEntity extends Entity<int> {
  final String heythereyounewhere,
      createWallet,
      importWallet,
      privacyPolicy,
      termsConditions,
      writedownthesewordsinorder,
      recoverykey,
      ihavewrittenthemdown;
  LanguageEntity(
      {int id,
      this.heythereyounewhere,
      this.createWallet,
      this.importWallet,
      this.privacyPolicy,
      this.termsConditions,
      this.writedownthesewordsinorder,
      this.recoverykey,
      this.ihavewrittenthemdown})
      : super(id);

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
      'ihavewrittenthemdown': ihavewrittenthemdown
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
        ihavewrittenthemdown
      ];
}
