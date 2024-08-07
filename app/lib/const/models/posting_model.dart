import 'package:image_picker/image_picker.dart';
import 'package:pet/const/models/articles.dart';

class PostingModel{
  final String title;
  final String body;
  final String category;
  final List<Photo>? images;

  const PostingModel({
    required this.title,
    required this.body,
    required this.category,
    this.images
    }
  );
}