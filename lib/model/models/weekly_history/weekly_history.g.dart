// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeeklyHistoryAdapter extends TypeAdapter<WeeklyHistory> {
  @override
  final int typeId = 3;

  @override
  WeeklyHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeeklyHistory(
      weekday: fields[0] as int,
      pomodorosDone: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WeeklyHistory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.weekday)
      ..writeByte(1)
      ..write(obj.pomodorosDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
