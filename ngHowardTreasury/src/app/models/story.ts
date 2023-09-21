import { Collection } from "./collection";

export class Story {

  id: number;
  title: string;
  textUrl: string;
  // userLists: UserList[];
  collections: Collection[];

  constructor(
    id: number = 0,
    title: string = '',
    textUrl: string = '',
    // userLists: UserList[] = [],
    collections: Collection[] = []
  ) {
    this.id = id;
    this.title = title;
    this.textUrl = textUrl;
    // this.userLists = userLists;
    this.collections = collections;
  }
}
