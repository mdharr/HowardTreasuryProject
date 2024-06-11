export class StoryVote {
  id: number;
  storyId: number;
  userId: number;
  voteType: string;

  constructor(id: number, storyId: number, userId: number, voteType: string) {
    this.id = id;
    this.storyId = storyId;
    this.userId = userId;
    this.voteType = voteType;
  }
}
