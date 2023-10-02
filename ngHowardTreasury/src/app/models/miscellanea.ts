import { Collection } from "./collection";
import { Person } from "./person";
import { UserList } from "./user-list";

export class Miscellanea {
  id: number;
  title: string;
  textUrl: string;
  excerpt: string;
  userLists: UserList[];
  collections: Collection[];
  persons: Person[];

  constructor(
    id: number = 0,
    title: string = '',
    textUrl: string = '',
    excerpt: string = '',
    userLists: UserList[] = [],
    collections: Collection[] = [],
    persons: Person[] = []
  ) {
    this.id = id;
    this.title = title;
    this.textUrl = textUrl;
    this.excerpt = excerpt;
    this.userLists = userLists;
    this.collections = collections;
    this.persons = persons;
  }
}
