import { CollectionImage } from "./collection-image";
import { Illustrator } from "./illustrator";
import { Miscellanea } from "./miscellanea";
import { Person } from "./person";
import { Poem } from "./poem";
import { Series } from "./series";
import { Story } from "./story";

export class Collection {

  id: number;
  title: string;
  publishedAt: string;
  pageCount: number;
  description: string;
  series: Series;
  stories: Story[];
  poems: Poem[];
  persons: Person[];
  miscellaneas: Miscellanea[];
  collectionImages: CollectionImage[];
  illustrators: Illustrator[];

  constructor(
    id: number = 0,
    title: string = '',
    publishedAt: string = '',
    pageCount: number = 0,
    description: string = '',
    series: Series = new Series(),
    stories: Story[] = [],
    poems: Poem[] = [],
    persons: Person[] = [],
    miscellaneas: Miscellanea[] = [],
    collectionImages: CollectionImage[],
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
