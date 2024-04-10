import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/const/models/posting_model.dart';

final PostingProvider = StateNotifierProvider<PostingNotifier, PostingModel>(
        (ref) => PostingNotifier());

class PostingNotifier extends StateNotifier<PostingModel>{
  PostingNotifier() :
      super(PostingModel(
          owner_id: null,
          title: null,
          body: null,
          category: null));
}