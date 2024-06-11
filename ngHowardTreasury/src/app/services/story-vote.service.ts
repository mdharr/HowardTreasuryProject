import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, tap } from 'rxjs';
import { environment } from 'src/environments/environment';
import { StoryVote } from '../models/story-vote';
import { StoryService } from './story.service';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class StoryVoteService {
  private url = environment.baseUrl + 'api/votes';

  constructor(private http: HttpClient, private storyService: StoryService, private authService: AuthService) {}

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.authService.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  getVotesByUserId(userId: number): Observable<StoryVote[]> {
    return this.http.get<StoryVote[]>(`${this.url}/users/${userId}`);
  }

  getVotesByStoryId(storyId: number): Observable<StoryVote[]> {
    return this.http.get<StoryVote[]>(`${this.url}/stories/${storyId}`, this.getHttpOptions());
  }

  getVoteByUserIdAndStoryId(userId: number, storyId: number): Observable<StoryVote> {
    return this.http.get<StoryVote>(`${this.url}/${userId}/${storyId}`, this.getHttpOptions());
  }

  createVote(vote: StoryVote): Observable<any> {  // Changed type to 'any' to allow custom structure
    const customVote = {
      "storyId": vote.story.id,
      "userId": vote.user.id,
      "voteType": vote.voteType
    }
    return this.http.post<StoryVote>(this.url, customVote, this.getHttpOptions()).pipe(
      tap(() => this.storyService.loadStories())
    );
  }

  updateVote(vote: StoryVote): Observable<any> {
    const customVote = {
      "storyId": vote.story.id,
      "userId": vote.user.id,
      "voteType": vote.voteType
    }
    return this.http.put<StoryVote>(`${this.url}/${vote.id}`, customVote, this.getHttpOptions()).pipe(
      tap(() => this.storyService.loadStories())
    );
  }

  deleteVote(voteId: number): Observable<void> {
    return this.http.delete<void>(`${this.url}/${voteId}`, this.getHttpOptions()).pipe(
      tap(() => this.storyService.loadStories())
    );
  }

}
