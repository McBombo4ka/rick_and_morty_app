import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<int> {
  final Box box;

  LayoutCubit(this.box) : super(_loadColumns(box));

  // Загрузка из Hive, по умолчанию 2
  static int _loadColumns(Box box) {
    return box.get('columns', defaultValue: 2).clamp(2, 3);
  }

  // Сохранение в Hive
  void _saveColumns(int count) {
    box.put('columns', count.clamp(2, 3));
  }

  void setColumns(int count) {
    _saveColumns(count);
    emit(count.clamp(2, 3));
  }
}
