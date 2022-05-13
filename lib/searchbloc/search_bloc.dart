import 'package:bloc/bloc.dart';
import 'package:bloc_student_manager/database/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial(searchList: Hive.box<StudentDetail>("studentDetails").values.toList())) {
    on<SearchValueEvent>((event, emit) {
      List<StudentDetail> searchList =  Hive.box<StudentDetail>("studentDetails").values.where((element) => element.name.toLowerCase().contains(event.searchValue.toLowerCase())).toList();

     emit(SearchInitial(searchList: searchList));
      
    });
  }
}
