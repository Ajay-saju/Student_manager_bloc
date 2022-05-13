part of 'student_details_cubit.dart';

@immutable
abstract class StudentDetailsState {
  
}

class StudentDetailsInitial extends StudentDetailsState {
  final List<StudentDetail>? student_List;
  final String? image;

  
  StudentDetailsInitial({ this.image, this.student_List}) ;

}
