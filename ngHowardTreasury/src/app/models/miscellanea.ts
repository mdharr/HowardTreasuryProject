import { Collection } from "./collection";

export class Miscellanea {
  id: number;
  title: string;
  // userLists: UserList[];
  collections: Collection[];

  constructor(
    id: number = 0,
    title: string = '',
    // userLists: UserList[] = [],
    collections: Collection[] = []
  ) {
    this.id = id;
    this.title = title;
    // this.userLists = userLists;
    this.collections = collections;
  }
}
