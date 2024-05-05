import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/app/main.dart';
import 'package:template/features/medications/model/medication/medication.dart';

class MedicationListCubit extends Cubit<List<Medication>> {
  MedicationListCubit() : super([]) {
    read();
  }

  void create(Medication medication) {
    medicationBox.add(medication).whenComplete(() {
      emit([...state, medication]);
    });
  }

  void read() {
    List<Medication> medicationList = [];
    if (medicationBox.isNotEmpty) {
      for (var i = 0; i < medicationBox.length; i++) {
        medicationList.add(medicationBox.getAt(i)!);
      }
      emit(medicationList);
    } else {
      emit([]);
    }
  }

  void update(int index, Medication medication) {
    medicationBox.putAt(index, medication).whenComplete(() {
      final List<Medication> updatedList = List.from(state);
      updatedList[index] = medication;
      emit(updatedList);
    });
  }

  void delete(int index) {
    medicationBox.deleteAt(index).whenComplete(() {
      final List<Medication> updatedList = List.from(state);
      updatedList.removeAt(index);
      emit(updatedList);
    });
  }
}
