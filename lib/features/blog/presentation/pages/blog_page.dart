// ignore_for_file: must_be_immutable

import 'package:clean_architecture_tdd/core/app_routes/app_routes.dart';
import 'package:clean_architecture_tdd/core/const/blog_topic_const.dart';
import 'package:clean_architecture_tdd/core/const/constants.dart';
import 'package:clean_architecture_tdd/core/theme/app_pallete.dart';
import 'package:clean_architecture_tdd/core/utiles/show_snackbar.dart';
import 'package:clean_architecture_tdd/features/blog/domain/entities/blog.dart';
import 'package:clean_architecture_tdd/features/blog/presentation/bloc/get_all_blog_bloc/blog_bloc.dart';
import 'package:clean_architecture_tdd/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: Constants.topics.length, vsync: this);
    context.read<BlogBloc>().add(GetAllBlogEvent());
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blog'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.addPostblog);
                },
                icon: const Icon(CupertinoIcons.add_circled)),
            const SizedBox(width: 20)
          ],
          bottom: TabBar(
              isScrollable: true,
              controller: tabController,
              tabs: Constants.topics.map((e) {
                return Tab(
                  text: e,
                  height: 45,
                );
              }).toList()),
        ),
        body: TabBarView(
            controller: tabController,
            children: Constants.topics.map((e) {
              return  AllBlogs(topic: e);
            }) .toList()));
  }
}
// Bloggers

class AllBlogs extends StatelessWidget {
  String? topic;
  AllBlogs({super.key, this.topic});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocConsumer<BlogBloc, BlogState>(listener: (context, state) {
            if (state is BlogFailureState) {
              showSnackBar(context, state.error);
            }
          }, builder: (context, state) {
            if (state is BlogLoadingState) {
              return ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return BlogCard(
                    blog: null,
                    color: AppPallete.greyColor,
                  );
                },
              );
            }
            if (state is BlogFailureState) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is BlogSuccesState) {
              List<BlogEntitie> programingBlog = [];
              if (topic == 'For you') {
                programingBlog = state.blog;
              } else {
                for (var blog in state.blog) {

                  if (blog.topics.contains(topic)) {
                    programingBlog.add(blog);
                  
                  }
                }
              }
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: programingBlog.length,
                  itemBuilder: (context, index) {
                    final blog = programingBlog[index];
                    return BlogCard(
                      blog: blog,
                      color: topic == null
                          ? null
                          : blog.topics.contains(BlogTopicConst.technology)
                              ? AppPallete.gradient1
                              : blog.topics.contains(BlogTopicConst.business)
                                  ? AppPallete.gradient2
                                  : blog.topics
                                          .contains(BlogTopicConst.programing)
                                      ? AppPallete.gradient3
                                      : AppPallete.gradient4,
                    );
                  });
            }
            return const Center(
              child: Text('Hello'),
            );
          }),
        ],
      ),
    );
  }
}
