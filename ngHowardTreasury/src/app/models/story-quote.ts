import { Story } from "./story";

export class StoryQuote {
    id: number;
    content: string;
    story: Story;

    constructor(
      id: number = 0,
      content: string = '',
      story: Story = new Story()
    ) {
      this.id = id;
      this.content = content;
      this.story = story;
    }
}
