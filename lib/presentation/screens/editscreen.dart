import 'dart:io';

import 'package:bloc_student_manager/core/colors/const_colors.dart';
import 'package:bloc_student_manager/core/colors/sizes/const_size.dart';
import 'package:bloc_student_manager/database/hive.dart';
import 'package:bloc_student_manager/searchbloc/search_bloc.dart';
import 'package:bloc_student_manager/student_details_cubit/student_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditScreen extends StatelessWidget {
  final int index;
  final String? searchResult;
  EditScreen({Key? key, required this.index,required this.searchResult}) : super(key: key);

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late String name;
  late int age;
  late String place;
  late String domain;
  String? image;


  @override
  Widget build(BuildContext context) {
    var student_list =
        Hive.box<StudentDetail>('studentDetails').values.toList();
    String imageUrl = student_list[index].imagePath;
    name = student_list[index].name;
    age = student_list[index].age;
    place = student_list[index].place;
    domain = student_list[index].domain;




    final ImagePicker _picker = ImagePicker();

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              csize30h,
              BlocBuilder<StudentDetailsCubit, StudentDetailsState>(
                builder: (context, state) {
                  return CircleAvatar(
                    radius: 100,
                    backgroundImage: FileImage(File(image ?? imageUrl)),
                  );
                },
              ),
              csize20h,
              Form(
                  key: _globalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: student_list[index].name,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: cblack, width: 0.5)),
                          // label: Text('Name')
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Name is requred';
                          }
                          return null;
                        },
                        onChanged: (String? value) {
                          name = value!;
                        },
                      ),
                      csize20h,
                      TextFormField(
                        initialValue: student_list[index].age.toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: cblack, width: 0.5)),
                            label: Text('Age')),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Age is requred';
                          }
                          return null;
                        },
                        onChanged: (String? value) {
                          age = int.parse(value!);
                        },
                      ),
                      csize20h,
                      TextFormField(
                        initialValue: student_list[index].place,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: cblack, width: 0.5)),
                            label: Text('Place')),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Place is requred';
                          }
                          return null;
                        },
                        onChanged: (String? value) {
                          place = value!;
                        },
                      ),
                      csize20h,
                      TextFormField(
                        initialValue: student_list[index].domain,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: cblack, width: 0.5)),
                            label: Text('Domain')),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Domain is requred';
                          }
                          return null;
                        },
                        onChanged: (String? value) {
                          domain = value!;
                        },
                      ),
                      csize20h,
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        final fimage =
                            await _picker.pickImage(source: ImageSource.gallery);
                        image = fimage!.path;
                        context.read<StudentDetailsCubit>().addImage(image!);
                      },
                      child: const Text('Select Image ')),
                  ElevatedButton(
                      onPressed: () async {
                        final fimage =
                            await _picker.pickImage(source: ImageSource.camera);
                        image = fimage!.path;
                        context.read<StudentDetailsCubit>().addImage(image!);
                      },
                      child: const Text('Take Image ')),
        
                  //TextButton(onPressed: (){}, child: ),
                ],
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    update(context: context, imageUrl: imageUrl, keys: student_list[index].key);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('save')),
            ],
          ),
        ),
      )),
    );
  }

  void update({required BuildContext context, required dynamic keys, required String imageUrl}) {
    if (_globalKey.currentState!.validate()) {
      final list = StudentDetail(
          name: name,
          age: age,
          place: place,
          domain: domain,
          imagePath: image ?? imageUrl);
      final key = keys;

      context.read<StudentDetailsCubit>().update(list, key);
      context.read<SearchBloc>().add(SearchValueEvent(searchValue: searchResult ?? ''));
      // Navigator.of(context).pop();
    }
  }
}
