import 'package:flutter_application_1/cubit/stetse.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class todoscubit extends Cubit<todostate> {
  todoscubit() : super(inisiAppstat());
  static todoscubit git(context) => BlocProvider.of(context);
  int curuntindex=1;
  setbottomindex(int index) {
    curuntindex = index;
    emit(setcurantAppstat());
  }
}

