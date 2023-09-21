import { Collection } from "./collection";

export class Series {

  id: number;
  title: string;
  collections: Collection[];

  constructor(
    id: number = 0,
    title: string = '',
    collections: Collection[] = []
  ) {
    this.id = id;
    this.title = title;
    this.collections = collections;
  }
}
