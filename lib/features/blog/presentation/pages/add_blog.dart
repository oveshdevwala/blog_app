// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:io';
import 'package:clean_architecture_tdd/core/commons/app_user_cubit/app_user_cubit.dart';
import 'package:clean_architecture_tdd/core/theme/app_pallete.dart';
import 'package:clean_architecture_tdd/core/utiles/pick_image.dart';
import 'package:clean_architecture_tdd/core/utiles/show_snackbar.dart';
import 'package:clean_architecture_tdd/features/blog/presentation/bloc/upload_bloc/upload_blog_bloc.dart';
import 'package:clean_architecture_tdd/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/select_categories_widgets.dart';

class AddBlogPostPage extends StatefulWidget {
  const AddBlogPostPage({super.key});

  @override
  State<AddBlogPostPage> createState() => _AddBlogPostPageState();
}

class _AddBlogPostPageState extends State<AddBlogPostPage> {
  final titleContoller = TextEditingController();
  final contentContoller = TextEditingController();
  List<String> selectedTopic = [];
  File? selectedImage;
  final formKey = GlobalKey<FormState>();
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopic.isNotEmpty &&
        selectedImage != null) {
      String posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedInState)
              .userEntitie!
              .uId;
      context.read<UploadBlogBloc>().add(BlogUploadEvent(
          posterId: posterId,
          title: titleContoller.text.trim(),
          content: contentContoller.text.trim(),
          image: selectedImage!,
          topics: selectedTopic));

      posterId = '';
      titleContoller.clear();
      contentContoller.clear();
      selectedImage = null;
      selectedTopic = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.back)),
        actions: [
          IconButton(
              onPressed: () => uploadBlog(), icon: const Icon(Icons.done)),
          const SizedBox(width: 20)
        ],
      ),
      body: BlocConsumer<UploadBlogBloc, UploadBlogState>(
          listener: (context, state) {
        if (state is UploadBlogFailureState) {
          showSnackBar(context, state.error);
        } else if (state is UploadBlogSuccesState) {
          showSnackBar(context, 'Blog Upload');
         
          // Navigator.pushNamedAndRemoveUntil(
          //     context, AppRoute.homeScreen, (route) => false);
        }
        //  if(state is BlogLoadingState){
        //   Navigator.pop(context);
        // }
      }, builder: (context, state) {
        if (state is UploadBlogLoadingState) {
          return const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Please Wait...'),
            ],
          ));
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      selectImage();
                    },
                    child: selectedImage != null
                        ? Container(
                            width: double.infinity,
                            height: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: FileImage(selectedImage!),
                                    fit: BoxFit.cover)),
                          )
                        : DottedBorder(
                            dashPattern: const [20, 5],
                            strokeWidth: 1,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            color: AppPallete.borderColor,
                            strokeCap: StrokeCap.round,
                            child: const SizedBox(
                              width: double.infinity,
                              height: 160,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.folder_open_rounded,
                                    size: 40,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Select Your Image",
                                    style:
                                        TextStyle(color: AppPallete.greyColor),
                                  ),
                                ],
                              ),
                            )),
                  ),
                  const SizedBox(height: 20),
                  SelectCategoriesWidgets(selectedTopic: selectedTopic),
                  const SizedBox(height: 20),
                  BlogEditor(
                      controller: titleContoller,
                      hint: 'Blog Title',
                      miniLine: 1),
                  const SizedBox(height: 10),
                  BlogEditor(
                      controller: contentContoller, hint: 'Blog Discription'),
                  // ElevatedButton(
                  //     onPressed: () async {
                  //       var pref = await SharedPreferences.getInstance();
                  //       pref.setString(PrefsConst.userId, '');
                  //       // var auth = FirebaseAuth.instance;
                  //       // auth.signOut().then((value) {
                  //       Navigator.pushNamedAndRemoveUntil(
                  //         context,
                  //         AppRoute.signIn,
                  //         (route) => false,
                  //       );
                  //       // });
                  //     },
                  //     child: const Text('Sign In')),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
