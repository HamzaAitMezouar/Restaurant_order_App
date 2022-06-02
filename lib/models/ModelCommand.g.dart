// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ModelCommand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelCommand _$ModelCommandFromJson(Map<String, dynamic> json) => ModelCommand(
      name: json['name'] as String,
      image: json['image'] as String,
      fries: json['fries'] as String,
      friesPrice: (json['friesPrice'] as num).toDouble(),
      itemPrice: (json['itemPrice'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      floor: json['floor'] as int?,
      table: json['table'] as int?,
      isReady: json['isReady'] as bool?,
    );

Map<String, dynamic> _$ModelCommandToJson(ModelCommand instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'itemPrice': instance.itemPrice,
      'total': instance.total,
      'friesPrice': instance.friesPrice,
      'fries': instance.fries,
      'isReady': instance.isReady,
      'floor': instance.floor,
      'table': instance.table,
    };
