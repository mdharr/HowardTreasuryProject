import { CollectionImage } from "./collection-image";
import { Illustrator } from "./illustrator";
import { Miscellanea } from "./miscellanea";
import { Person } from "./person";
import { Poem } from "./poem";
import { Series } from "./series";
import { StoryImage } from "./story-image";

export class CollectionWithStoriesDTO {
  id: number;
  title: string;
  publishedAt: string; // Change the type if needed
  pageCount: number;
  description: string;
  series: any; // Define the type for Series if needed
  stories: StoryWithPageNumberDTO[];
  poems: any[]; // Define the type for Poem if needed
  persons: any[]; // Define the type for Person if needed
  miscellaneas: any[]; // Define the type for Miscellanea if needed
  collectionImages: any[]; // Define the type for CollectionImage if needed
  illustrators: any[]; // Define the type for Illustrator if needed

  isLoadingImage: boolean = true;

  constructor(
    id: number = 0,
    title: string = '',
    publishedAt: string = '',
    pageCount: number = 0,
    description: string = '',
    series: Series = new Series(),
    stories: StoryWithPageNumberDTO[] = [],
    poems: PoemWithPageNumberDTO[] = [],
    persons: Person[] = [],
    miscellaneas: MiscellaneaWithPageNumberDTO[] = [],
    collectionImages: CollectionImage[] = [],
    illustrators: Illustrator[] = []
  ) {
    this.id = id;
    this.title = title;
    this.publishedAt = publishedAt;
    this.pageCount = pageCount;
    this.description = description;
    this.series = series;
    this.stories = stories;
    this.poems = poems;
    this.persons = persons;
    this.miscellaneas = miscellaneas;
    this.collectionImages = collectionImages;
    this.illustrators = illustrators;
  }
}

export class StoryWithPageNumberDTO {
  id: number;
  title: string;
  textUrl: string;
  firstPublished: string; // Change the type if needed
  alternateTitle: string;
  isCopyrighted: boolean;
  copyrightExpiresAt: string; // Change the type if needed
  excerpt: string;
  description: string;
  storyImages: StoryImage[];
  pageNumber: number;

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
    storyImages: StoryImage[] = [],
    pageNumber: number = 0
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
    this.storyImages = storyImages;
    this.pageNumber = pageNumber;
  }
}

export class PoemWithPageNumberDTO {
  id: number;
  title: string;
  textUrl: string;
  excerpt: string;
  pageNumber: number;

  constructor(
    id: number = 0,
    title: string = '',
    textUrl: string = '',
    excerpt: string = '',
    pageNumber: number = 0
  ) {
    this.id = id;
    this.title = title;
    this.textUrl = textUrl;
    this.excerpt = excerpt;
    this.pageNumber = pageNumber;
  }
}

export class MiscellaneaWithPageNumberDTO {
  id: number;
  title: string;
  textUrl: string;
  excerpt: string;
  pageNumber: number;

  constructor(
    id: number = 0,
    title: string = '',
    textUrl: string = '',
    excerpt: string = '',
    pageNumber: number = 0
  ) {
    this.id = id;
    this.title = title;
    this.textUrl = textUrl;
    this.excerpt = excerpt;
    this.pageNumber = pageNumber;
  }
}
