// Create-comment.dto
export class CreateCommentDto {
  constructor(
    public connected_article_id: number,
    public nickname: string,
    public comment: string,
  ) {}
}
