import { StoryImage } from './story-image';
import { Collection } from "./collection";

export class Illustrator {

  id: number;
  name: string;
  imageUrl: string;
  description: string;
  collections: Collection[];
  storyImages: StoryImage[];

  constructor(
    id: number = 0,
    name: string = '',
    imageUrl: string = '',
    description: string = '',
    collections: Collection[] = [],
    storyImages: StoryImage[] = []
  ) {
    this.id = id;
    this.name = name;
    this.imageUrl = imageUrl;
    this.description = description;
    this.collections = collections;
    this.storyImages = storyImages;
  }
}
