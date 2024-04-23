class PostingModel{
  final int owner_id;
  final String title;
  final String body;
  final String category;
  final List<String>? imagePaths;

  const PostingModel({
    required this.owner_id,
    required this.title,
    required this.body,
    required this.category,
    this.imagePaths
    }
  );
}