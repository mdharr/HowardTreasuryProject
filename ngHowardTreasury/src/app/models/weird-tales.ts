import { Story } from "./story";

export class WeirdTales {

  id: number;
  title: string;
  description: string;
  publishedAt: string;
  pageCount: number;
  thumbnailUrl: string;
  imageUrl: string;
  fileUrl: string;
  stories: Story[];

  constructor(
    id: number = 0,
    title: string = '',
    description: string = '',
    publishedAt: string = '',
    pageCount: number = 0,
    thumbnailUrl: string = '',
    imageUrl: string = '',
    fileUrl: string = '',
    stories: Story[] = []
  ) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.publishedAt = publishedAt;
    this.pageCount = pageCount;
    this.thumbnailUrl = thumbnailUrl;
    this.imageUrl = imageUrl;
    this.fileUrl = fileUrl;
    this.stories = stories;
  }
}
