import 'package:bloc/bloc.dart';
import 'package:bloc_student_manager/database/hive.dart';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:meta/meta.dart';

part 'student_details_state.dart';

class StudentDetailsCubit extends Cubit<StudentDetailsState> {
  StudentDetailsCubit()
      : super(StudentDetailsInitial(
            student_List:
                Hive.box<StudentDetail>("studentDetails").values.toList(), ));

  void addData(StudentDetail list) {
    Hive.box<StudentDetail>('studentDetails').add(list);
    emit(StudentDetailsInitial(
        student_List:
            Hive.box<StudentDetail>("studentDetails").values.toList()));
  }

  void delete(int key) {
    Hive.box<StudentDetail>('studentDetails').delete(key);
    emit(StudentDetailsInitial(
        student_List:
            Hive.box<StudentDetail>("studentDetails").values.toList()));
  }
  void addImage(String image){
    emit(StudentDetailsInitial(image: image,student_List:Hive.box<StudentDetail>("studentDetails").values.toList()));
  }
  void update(StudentDetail list,dynamic key){
     Hive.box<StudentDetail>('studentDetails').put(key,list);
    emit(StudentDetailsInitial(
        student_List:
            Hive.box<StudentDetail>("studentDetails").values.toList()));
  }

  }

