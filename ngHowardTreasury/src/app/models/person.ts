import { Collection } from "./collection";

export class Person {

  id: number;
  name: string;
  collections: Collection[];

  constructor(
    id: number = 0,
    name: string = '',
    collections: Collection[] = []
  ) {
    this.id = id;
    this.name = name;
    this.collections = collections;
  }
}
