import { Story } from "./story";
import { User } from "./user";

export class StoryVote {
  id: number;
  story: Story;
  user: User;
  voteType: string;

  constructor(id: number, story: Story, user: User, voteType: string) {
    this.id = id;
    this.story = story;
    this.user = user;
    this.voteType = voteType;
  }
}

