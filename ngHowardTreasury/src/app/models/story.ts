import { StoryImage } from './story-image';
import { Collection } from "./collection";
import { Person } from './person';
import { UserList } from './user-list';
import { WeirdTales } from './weird-tales';
import { StoryVote } from './story-vote';

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
  weirdTales: WeirdTales[];
  selected: boolean = false;
  storyVotes?: StoryVote[];

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
    persons: Person[] = [],
    weirdTales: WeirdTales[] = [],
    storyVotes?: StoryVote[]
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
    this.weirdTales = weirdTales;
    this.storyVotes = storyVotes || [];
  }
}
