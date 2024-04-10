import 'package:pet/const/category_list.dart';

enum CategoryModel{
  categoryList
}

class PostingModel{
  final int? owner_id;
  final String? title;
  final String? body;
  final CategoryModel? category;

  const PostingModel({
    required this.owner_id,
    required this.title,
    required this.body,
    required this.category
}
);

}