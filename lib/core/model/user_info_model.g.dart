// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInformationModelAdapter extends TypeAdapter<UserInformationModel> {
  @override
  final int typeId = 0;

  @override
  UserInformationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInformationModel(
      fullName: fields[0] as String?,
      email: fields[4] as String?,
      id: fields[1] as String?,
      phoneNumber: fields[2] as String?,
      pathImage: fields[5] as String?,
      isAccountSocial: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserInformationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.isAccountSocial)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.pathImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInformationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
