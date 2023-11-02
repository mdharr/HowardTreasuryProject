import { Collection } from "./collection";

export class CollectionImage {

  id: number;
  imageUrl: string;
  thumbnailUrl: string;
  collections: Collection[];

  constructor(
    id: number = 0,
    imageUrl: string = '',
    thumbnailUrl: string = '',
    collections: Collection[] = []
  ) {
    this.id = id;
    this.imageUrl = imageUrl;
    this.thumbnailUrl = thumbnailUrl;
    this.collections = collections;
  }
}
