import 'entity.dart';

class TokenEntity extends Entity<int> {
  final String token;

  TokenEntity({
    int id,
    this.token,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'token': token,
    };
  }

  @override
  List<Object> get props => [id, token];
}
