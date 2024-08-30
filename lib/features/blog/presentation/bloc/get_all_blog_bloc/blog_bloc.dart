// ignore_for_file: unused_field

import 'dart:async';

import 'package:clean_architecture_tdd/core/usecase/usecase.dart';
import 'package:clean_architecture_tdd/features/blog/domain/entities/blog.dart';
import 'package:clean_architecture_tdd/features/blog/domain/usecases/get_all_blog_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final GetAllBlogUseCase _getAllBlogUseCase;
  BlogBloc(
      {
      required GetAllBlogUseCase getAllBlogUseCase})
      : _getAllBlogUseCase = getAllBlogUseCase,
        super(BlogInitialState()) {
    // on<BlogEvent>((event, emit) => emit(BlogLoadingState()));

    on<GetAllBlogEvent>(_getAllBlogEvent);
  }

  FutureOr<void> _getAllBlogEvent(
      GetAllBlogEvent event, Emitter<BlogState> emit) async {
    emit(BlogLoadingState());
    final res = await _getAllBlogUseCase.call(NoParams());
    res.fold(
      (e) => emit(BlogFailureState(error: e.message)),
      (r) => emit(BlogSuccesState(r)),
    );
  }
}
