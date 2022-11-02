// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apteka.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Apteka _$AptekaFromJson(Map<String, dynamic> json) => Apteka(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ??
          'https://i.pinimg.com/474x/e6/a0/62/e6a062d685102494b0da11279080ced5.jpg',
      price: json['price'] as num? ?? 0,
      summa: json['summa'] as int? ?? 0,
    );

Map<String, dynamic> _$AptekaToJson(Apteka instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'summa': instance.summa,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
    };
