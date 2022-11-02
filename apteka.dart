import 'package:json_annotation/json_annotation.dart';


part 'apteka.g.dart';

@JsonSerializable()
class Apteka{
  @JsonKey(name: 'id',defaultValue: 0)
  int id;


  @JsonKey(name: 'name',defaultValue: '')
  String name;

  @JsonKey(name: 'summa',defaultValue: 0)
  int summa;

  @JsonKey(name: 'description',defaultValue:'')
  String description;

  @JsonKey(name: 'imageUrl',defaultValue: 'https://i.pinimg.com/474x/e6/a0/62/e6a062d685102494b0da11279080ced5.jpg')
  String imageUrl;

  @JsonKey(name: 'price',defaultValue: 0)
   num price;
  Apteka({required this.id, required this.name, required this.description, required this.imageUrl,required this.price,required this.summa});



  factory Apteka.fromJson(Map<String, dynamic> json) => _$AptekaFromJson(json);

  Map<String, dynamic> toJson() => _$AptekaToJson(this);

}