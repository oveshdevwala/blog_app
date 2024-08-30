import 'dart:async';
import 'dart:io';

import 'package:clean_architecture_tdd/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'upload_blog_event.dart';
part 'upload_blog_state.dart';

class UploadBlogBloc extends Bloc<UploadBlogEvent, UploadBlogState> {
  final UploadBlogUseCase _uploadBlogUseCase;
  UploadBlogBloc(UploadBlogUseCase uploadBlogUseCase)
      : _uploadBlogUseCase = uploadBlogUseCase,
        super(UploadBlogInitial()) {
    on<BlogUploadEvent>(_uploadBlogEvent);
  }
  FutureOr<void> _uploadBlogEvent(
      BlogUploadEvent event, Emitter<UploadBlogState> emit) async {
    emit(UploadBlogLoadingState());
    final res = await _uploadBlogUseCase(UploadBlogParam(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics));
    res.fold((e) => emit(UploadBlogFailureState(error: e.message)),
        (r) => emit(UploadBlogSuccesState()));

  }
}
