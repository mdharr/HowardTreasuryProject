import { Collection } from "./collection";

export class CollectionImage {

  id: number;
  imageUrl: string;
  collections: Collection[];

  constructor(
    id: number = 0,
    imageUrl: string = '',
    collections: Collection[] = []
  ) {
    this.id = id;
    this.imageUrl = imageUrl;
    this.collections = collections;
  }
}
