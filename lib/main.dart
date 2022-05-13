import 'package:bloc_student_manager/database/hive.dart';
import 'package:bloc_student_manager/presentation/screens/screen_home.dart';
import 'package:bloc_student_manager/searchbloc/search_bloc.dart';
import 'package:bloc_student_manager/student_details_cubit/student_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentDetailAdapter());
  
  await Hive.openBox<StudentDetail>('studentDetails');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      
      providers: [
BlocProvider(create: (context) => StudentDetailsCubit(),),
BlocProvider(create: (context)=>SearchBloc())

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
