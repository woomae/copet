// Create-comment.dto
export class CreateCommentDto {
  constructor(
    public user_id: number,
    public connected_article_id: number,
    public comment: string,
    public comment_owner_id?: number,
    public nickname?: string,
  ) {}
}
