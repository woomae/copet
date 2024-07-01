class Comments{
  final int count;
  final List<Comment> comments;

  Comments({required this.count, required this.comments});
  Comments.fromJson(Map<String, dynamic> json):
      count = json['count'],
  comments = json['comments'];
}
class Comment{
  final int id;
  final int ownerId;
  final String nickname;
  final String comment;

  Comment({
    required this.comment,
    required this.nickname,
    required this.id,
    required this.ownerId
});

  Comment.fromJson(Map<String, dynamic> json) :
        comment = json['comment'],
    nickname = json['nickname'],
    id = json['_id'],
    ownerId = json['owner_id'] ;
}