import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { StoryVote } from '../models/story-vote';

@Injectable({
  providedIn: 'root'
})
export class StoryVoteService {
  private url = environment.baseUrl + 'api/votes';

  constructor(private http: HttpClient) {}

  getVotesByUserId(userId: number): Observable<StoryVote[]> {
    return this.http.get<StoryVote[]>(`${this.url}/users/${userId}`);
  }

  getVotesByStoryId(storyId: number): Observable<StoryVote[]> {
    return this.http.get<StoryVote[]>(`${this.url}/stories/${storyId}`);
  }

  getVoteByUserIdAndStoryId(userId: number, storyId: number): Observable<StoryVote> {
    return this.http.get<StoryVote>(`${this.url}/${userId}/${storyId}`);
  }

  createVote(vote: StoryVote): Observable<StoryVote> {
    return this.http.post<StoryVote>(this.url, vote);
  }

  deleteVote(voteId: number): Observable<void> {
    return this.http.delete<void>(`${this.url}/${voteId}`);
  }
}
