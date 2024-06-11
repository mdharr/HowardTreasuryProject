import { ChatMessage } from "./chat-message";
import { ChatRoom } from "./chat-room";
import { StoryVote } from "./story-vote";
import { UserList } from "./user-list";

export class User {
  id: number;
  username: string;
  password: string;
  confirmPassword: string;
  enabled: boolean;
  role: string;
  email: string;
  imageUrl: string;
  profileDescription: string;
  userLists: UserList[];
  chatRooms?: ChatRoom[];
  chatMessages?: ChatMessage[];
  storyVotes?: StoryVote[];

  constructor(
    id: number = 0,
    username: string = '',
    password: string = '',
    confirmPassword: string = '',
    enabled: boolean = false,
    role: string = '',
    email: string = '',
    imageUrl: string = '',
    profileDescription: string = '',
    userLists: UserList[] = [],
    storyVotes?: StoryVote[]
  ) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.confirmPassword = confirmPassword;
    this.enabled = enabled;
    this.role = role;
    this.email = email;
    this.imageUrl = imageUrl;
    this.profileDescription = profileDescription;
    this.userLists = userLists;
    this.storyVotes = storyVotes || [];
  }
}
