import { Collection } from "./collection";

export class Story {

  id: number;
  title: string;
  textUrl: string;
  firstPublished: string;
  alternateTitle: string;
  isCopyrighted: boolean;
  copyrightExpiresAt: string;
  excerpt: string;
  // userLists: UserList[];
  collections: Collection[];

  constructor(
    id: number = 0,
    title: string = '',
    textUrl: string = '',
    firstPublished: string = '',
    alternateTitle: string = '',
    isCopyrighted: boolean = false,
    copyrightExpiresAt: string = '',
    excerpt: string = '',
    // userLists: UserList[] = [],
    collections: Collection[] = []
  ) {
    this.id = id;
    this.title = title;
    this.textUrl = textUrl;
    this.firstPublished = firstPublished;
    this.alternateTitle = alternateTitle;
    this.isCopyrighted = isCopyrighted;
    this.copyrightExpiresAt = copyrightExpiresAt;
    this.excerpt = excerpt;
    // this.userLists = userLists;
    this.collections = collections;
  }
}
