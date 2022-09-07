// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_recent_search_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarRecentSearchDataAdapter extends TypeAdapter<CarRecentSearchData> {
  @override
  final int typeId = 1;

  @override
  CarRecentSearchData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarRecentSearchData(
      pickupLocationId: fields[0] as String,
      returnLocationId: fields[1] as String,
      pickupLocationName: fields[2] as String,
      returnLocationName: fields[3] as String,
      pickupDate: fields[4] as String,
      returnDate: fields[5] as String,
      pickupTime: fields[6] as String,
      returnTime: fields[7] as String,
      age: fields[8] as int,
      dataSearchType: fields[9] as String,
      includeDriver: fields[10] as bool,
      isSearchSave: fields[11] as bool,
      languageCode: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CarRecentSearchData obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.pickupLocationId)
      ..writeByte(1)
      ..write(obj.returnLocationId)
      ..writeByte(2)
      ..write(obj.pickupLocationName)
      ..writeByte(3)
      ..write(obj.returnLocationName)
      ..writeByte(4)
      ..write(obj.pickupDate)
      ..writeByte(5)
      ..write(obj.returnDate)
      ..writeByte(6)
      ..write(obj.pickupTime)
      ..writeByte(7)
      ..write(obj.returnTime)
      ..writeByte(8)
      ..write(obj.age)
      ..writeByte(9)
      ..write(obj.dataSearchType)
      ..writeByte(10)
      ..write(obj.includeDriver)
      ..writeByte(11)
      ..write(obj.isSearchSave)
      ..writeByte(12)
      ..write(obj.languageCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarRecentSearchDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
