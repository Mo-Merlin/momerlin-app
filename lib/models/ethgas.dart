class EthGas {
  final double fast, standard, low, fastwait, standardwait, lowwait;
  EthGas({
    this.fast,
    this.standard,
    this.low,
    this.fastwait,
    this.standardwait,
    this.lowwait,
  });

  factory EthGas.fromJson(Map<String, dynamic> json) {
    return EthGas(
      fast: double.parse((json['fast']).toString()),
      standard: double.parse((json['average']).toString()),
      low: double.parse((json['safeLow']).toString()),
      fastwait: double.parse((json['fastWait']).toString()),
      standardwait: double.parse((json['avgWait']).toString()),
      lowwait: double.parse((json['safeLowWait']).toString()),
    );
  }
}
