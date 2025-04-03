// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Rating {
  final double rate;
  final String userId;

  Rating({required this.rate, required this.userId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rate': rate,
      'userId': userId,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      rate: map['rate'] as double,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) =>
      Rating.fromMap(json.decode(source) as Map<String, dynamic>);
}
