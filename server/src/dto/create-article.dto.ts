// create-article.dto
export class CreateArticleDto {
  constructor(
    public owner_id: number,
    public author: string,
    public title: string,
    public body: string,
    public img_name?: string,
  ) {}
}
