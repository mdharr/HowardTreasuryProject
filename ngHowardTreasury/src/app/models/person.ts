import { Miscellanea } from 'src/app/models/miscellanea';
import { Collection } from "./collection";
import { Poem } from './poem';
import { Story } from './story';

export class Person {

  id: number;
  name: string;
  imageUrl: string;
  description: string;
  collections: Collection[];
  stories: Story[];
  poems: Poem[];
  miscellaneas: Miscellanea[];

  constructor(
    id: number = 0,
    name: string = '',
    imageUrl: string = '',
    description: string = '',
    collections: Collection[] = [],
    stories: Story[] = [],
    poems: Poem[] = [],
    miscellaneas: Miscellanea[] = []
  ) {
    this.id = id;
    this.name = name;
    this.imageUrl = imageUrl;
    this.description = description;
    this.collections = collections;
    this.stories = stories;
    this.poems = poems;
    this.miscellaneas = miscellaneas;
  }
}
