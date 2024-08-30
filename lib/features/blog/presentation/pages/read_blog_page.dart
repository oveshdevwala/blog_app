import 'package:clean_architecture_tdd/core/theme/app_pallete.dart';
import 'package:clean_architecture_tdd/core/utiles/calculate_reading_function.dart';
import 'package:clean_architecture_tdd/core/utiles/formate_date.dart';
import 'package:clean_architecture_tdd/features/blog/presentation/arguments/read_blog_argument.dart';
import 'package:flutter/material.dart';

class ReadBlogPage extends StatelessWidget {
  const ReadBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as ReadBlogPageArgument;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  arg.blog.title,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'By ${arg.blog.posterName!}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppPallete.greyColor),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      formateDateByDMMMYYYY(arg.blog.uploadAt),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppPallete.greyColor),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      '${calculateReadingTime(arg.blog.content)} min',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppPallete.greyColor),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      arg.blog.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  arg.blog.content,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 15, color: AppPallete.greyColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
