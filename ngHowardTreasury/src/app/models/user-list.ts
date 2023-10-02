import { Miscellanea } from "./miscellanea";
import { Poem } from "./poem";
import { Story } from "./story";
import { User } from "./user";

export class UserList {
  id: number;
  name: string;
  user: User;
  stories: Story[];
  poems: Poem[];
  miscellaneas: Miscellanea[];

  constructor(
    id: number = 0,
    name: string = '',
    user: User = new User(),
    stories: Story[] = [],
    poems: Poem[] = [],
    miscellaneas: Miscellanea[] = []
  ) {
    this.id = id;
    this.name = name;
    this.user = user;
    this.stories = stories;
    this.poems = poems;
    this.miscellaneas = miscellaneas;
  }
}
