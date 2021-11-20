import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';



@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeBluetoothState());

  void switchView(int index) {
    switch (index) {
      case 0:
        emit(const HomeSpeedState());
        break;
      case 1:
        emit(const HomeBluetoothState());
        break;
      case 2:
        emit(const HomeManualState());
        break;
    }
  }
}
