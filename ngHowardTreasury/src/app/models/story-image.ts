import { Illustrator } from './illustrator';
import { Story } from './story';
export class StoryImage {

  id: number;
  imageUrl: string;
  stories: Story[];
  illustrators: Illustrator[];

  constructor(
    id: number = 0,
    imageUrl: string = '',
    stories: Story[] = [],
    illustrators: Illustrator[] = []
  ) {
    this.id = id;
    this.imageUrl = imageUrl;
    this.stories = stories;
    this.illustrators = illustrators;
  }
}
