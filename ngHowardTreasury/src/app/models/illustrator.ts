import { StoryImage } from './story-image';
import { Collection } from "./collection";

export class Illustrator {

  id: number;
  name: string;
  collections: Collection[];
  storyImages: StoryImage[];

  constructor(
    id: number = 0,
    name: string = '',
    collections: Collection[] = [],
    storyImages: StoryImage[] = []
  ) {
    this.id = id;
    this.name = name;
    this.collections = collections;
    this.storyImages = storyImages;
  }
}
