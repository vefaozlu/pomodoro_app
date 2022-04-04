// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyHistoryAdapter extends TypeAdapter<DailyHistory> {
  @override
  final int typeId = 2;

  @override
  DailyHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyHistory(
      weekday: fields[0] as int,
      goalName: fields[1] as String,
      pomodorosDone: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DailyHistory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.weekday)
      ..writeByte(1)
      ..write(obj.goalName)
      ..writeByte(2)
      ..write(obj.pomodorosDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
