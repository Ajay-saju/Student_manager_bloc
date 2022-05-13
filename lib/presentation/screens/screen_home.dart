import 'dart:io';

import 'package:bloc_student_manager/core/colors/const_colors.dart';
import 'package:bloc_student_manager/core/colors/sizes/const_size.dart';
import 'package:bloc_student_manager/database/hive.dart';

import 'package:bloc_student_manager/presentation/screens/aboutpage.dart';
import 'package:bloc_student_manager/presentation/screens/editscreen.dart';
import 'package:bloc_student_manager/presentation/screens/screen_add_student.dart';
import 'package:bloc_student_manager/searchbloc/search_bloc.dart';
import 'package:bloc_student_manager/student_details_cubit/student_details_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String search = '';
    List<StudentDetail> studentList =
        Hive.box<StudentDetail>('studentDetails').values.toList();

    final box = Hive.box<StudentDetail>('studentDetails');
    // box.clear();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoSearchTextField(
                onChanged: (value) {
                  search = value;
                  context
                      .read<SearchBloc>()
                      .add(SearchValueEvent(searchValue: search));
                },

                placeholderStyle:
                    TextStyle(color: Color.fromARGB(255, 42, 42, 41)),
                backgroundColor: Color.fromARGB(255, 86, 112, 89),

                // decoration: BoxDecoration(color: Colors.black),
              ),
              csize20h,
              const Screen_title(
                title: 'Student List',
              ),
              csize30h,
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  studentList = state.props[0] as List<StudentDetail>;
                  return studentList.isEmpty ? const Expanded(child: Center(child: Text('Nostudent found'),)):
                  Expanded(
                    child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (contexr) => AboutPage(
                                    index: index,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: cblack),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              width: double.infinity,
                              height: 90,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                              File(
                                                  studentList[index].imagePath),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    csize10w,
                                    Text(
                                      studentList[index].name,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: cblack,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const Spacer(),
                                    PopupMenuButton(
                                      icon: const Icon(Icons.more_rounded),
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                          value: '0',
                                          child: Text('Delete'),
                                        ),
                                        const PopupMenuItem(
                                          child: Text('Edit'),
                                          value: '1',
                                        )
                                      ],
                                      onSelected: (value) {
                                        if (value == '0') {
                                          context
                                              .read<StudentDetailsCubit>()
                                              .delete(studentList[index].key);
                                          context.read<SearchBloc>().add(
                                              SearchValueEvent(
                                                  searchValue: search));
                                        }
                                        if (value == '1') {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditScreen(
                                                        index: studentList[index].key, searchResult: search,
                                                      )));
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        separatorBuilder: (context, index) => csize10h,
                        itemCount: studentList.length),
                  );
                },
              ),
              SizedBox.fromSize(
                size: const Size(0, 30),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 86, 112, 89),
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => AddStudent(searchResult: search,)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Screen_title extends StatelessWidget {
  final String title;
  const Screen_title({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}
