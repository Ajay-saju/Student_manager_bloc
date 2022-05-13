// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bloc_student_manager/core/colors/const_colors.dart';
import 'package:bloc_student_manager/core/colors/sizes/const_size.dart';
import 'package:bloc_student_manager/database/hive.dart';
import 'package:bloc_student_manager/presentation/screens/screen_home.dart';
import 'package:bloc_student_manager/searchbloc/search_bloc.dart';
import 'package:bloc_student_manager/student_details_cubit/student_details_cubit.dart';

class AddStudent extends StatelessWidget {
  final String? searchResult;
  AddStudent({
    Key? key,
   required this.searchResult,
  }) : super(key: key);
  String name = '';
  int age = 0;
  String domain = '';
  String place = '';
  String image = '';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Screen_title(title: "Add Student details"),
                csize20h,
                Neumorphic(
                    style: NeumorphicStyle(
                        shadowDarkColor: cblack,
                        shape: NeumorphicShape.convex,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(10)),
                        depth: 8,
                        lightSource: LightSource.topLeft,
                        color: Colors.transparent),
                    child:
                        BlocBuilder<StudentDetailsCubit, StudentDetailsState>(
                      builder: (context, state) {
                        state as StudentDetailsInitial;

                        if (state.image != null) {
                          return Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(File(state.image!)))),
                          );
                        } else {
                          return const Icon(
                            Icons.person_add_alt,
                            size: 70,
                            color: Colors.white54,
                          );
                        }
                      },
                    )),
                csize20h,
                Form(
                    key: _globalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: cblack, width: 0.5)),
                              label: Text('Name')),
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
                          final fimage = await _picker.pickImage(
                              source: ImageSource.gallery);
                          image = fimage!.path;
                          context.read<StudentDetailsCubit>().addImage(image);
                        },
                        child: const Text('Select Image ')),
                    ElevatedButton(
                        onPressed: () async {
                          final fimage = await _picker.pickImage(
                              source: ImageSource.camera);
                          image = fimage!.path;
                          context.read<StudentDetailsCubit>().addImage(image);
                        },
                        child: const Text('Take Image ')),

                    //TextButton(onPressed: (){}, child: ),
                  ],
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      addData(context);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('save')),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void addData(BuildContext context) {
    if (_globalKey.currentState!.validate()) {
      final list = StudentDetail(
          name: name, age: age, place: place, domain: domain, imagePath: image);

      context.read<StudentDetailsCubit>().addData(list);
      context.read<SearchBloc>().add(SearchValueEvent(searchValue: searchResult ?? ''));
      Navigator.pop(context);
    }
  }
}

class InputoFormFields extends StatelessWidget {
  final IconData icon;
  final String hintText;
  const InputoFormFields({
    Key? key,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: cblack, width: 0.5)),
          filled: true,
          hintText: hintText,
          prefixIcon: Icon(icon),
          labelText: hintText,
          hintStyle: const TextStyle(fontSize: 18),
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: cgrey))),
    );
  }
}
