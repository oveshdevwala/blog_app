// ignore_for_file: must_be_immutable

import 'package:clean_architecture_tdd/core/app_routes/app_routes.dart';
import 'package:clean_architecture_tdd/core/theme/app_pallete.dart';
import 'package:clean_architecture_tdd/core/utiles/calculate_reading_function.dart';
import 'package:clean_architecture_tdd/features/blog/domain/entities/blog.dart';
import 'package:clean_architecture_tdd/features/blog/presentation/arguments/read_blog_argument.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  BlogEntitie? blog;
  Color? color;
  BlogCard({super.key, this.blog, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoute.readBlogPage,
            arguments: ReadBlogPageArgument(blog!));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 320, minHeight: 200),
          child: Container(
            // height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color ?? AppPallete.gradient1,
              borderRadius: BorderRadius.circular(12),
            ),
            child: blog != null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 1),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: blog!.topics
                                .map((topic) => Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppPallete.backgroundColor),
                                    child: Text(
                                      topic,
                                      style: const TextStyle(fontSize: 11),
                                    )))
                                .toList(),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Text(
                          blog!.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    // color: AppPallete.backgroundColor,
                                    border: Border.all(
                                        color: AppPallete.backgroundColor),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  'By ${blog!.posterName!}',
                                  style: const TextStyle(
                                      color: AppPallete.whiteColor),
                                )),
                            const SizedBox(width: 10),
                            Text('${calculateReadingTime(blog!.content)} min'),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
