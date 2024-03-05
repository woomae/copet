// create-article.dto
export class CreateArticleDto {
  constructor(
    public owner_id: number,
    public title: string,
    public body: string,
    public category: string,
    public author?: string,
    public img_name?: string,
  ) {}
}
