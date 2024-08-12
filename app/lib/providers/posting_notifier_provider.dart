import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet/const/models/articles.dart';
import 'package:pet/const/models/posting_model.dart';

final PostingProvider = StateNotifierProvider<PostingNotifier, PostingModel>(
        (ref) => PostingNotifier());

class PostingNotifier extends StateNotifier<PostingModel> {
  PostingNotifier() :
        super(const PostingModel(
          title: '',
          body: '',
          category: '',
          images: null
      ));

  void updatePosting(
      {String? title, String? body, String? category, List<Photo>? imageFiles}) {
    final List<Photo>? images = imageFiles == null ? state.images : [...?state.images,...imageFiles] ;
    state = PostingModel(
        title: title ?? state.title,
        body: body ?? state.body,
        category: category ?? state.category,
        images: images
    );
  }
}