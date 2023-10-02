import { StoryImage } from './story-image';
import { Collection } from "./collection";
import { Person } from './person';
import { UserList } from './user-list';

export class Story {

  id: number;
  title: string;
  textUrl: string;
  firstPublished: string;
  alternateTitle: string;
  isCopyrighted: boolean;
  copyrightExpiresAt: string;
  excerpt: string;
  description: string;
  userLists: UserList[];
  collections: Collection[];
  storyImages: StoryImage[];
  persons: Person[];

  constructor(
    id: number = 0,
    title: string = '',
    textUrl: string = '',
    firstPublished: string = '',
    alternateTitle: string = '',
    isCopyrighted: boolean = false,
    copyrightExpiresAt: string = '',
    excerpt: string = '',
    description: string = '',
    userLists: UserList[] = [],
    collections: Collection[] = [],
    storyImages: StoryImage[] = [],
    persons: Person[] = []
  ) {
    this.id = id;
    this.title = title;
    this.textUrl = textUrl;
    this.firstPublished = firstPublished;
    this.alternateTitle = alternateTitle;
    this.isCopyrighted = isCopyrighted;
    this.copyrightExpiresAt = copyrightExpiresAt;
    this.excerpt = excerpt;
    this.description = description;
    this.userLists = userLists;
    this.collections = collections;
    this.storyImages = storyImages;
    this.persons = persons;
  }
}
