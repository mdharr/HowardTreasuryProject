import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, map } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class OpenAiService {

  private url = environment.baseUrl + 'api/adventure/response'

  constructor(private http: HttpClient) {}

  getAdventureResponse(messages: { role: string, content: string }[]): Observable<string> {
    return this.http.post<any>(this.url, messages).pipe(
      map(response => response.content)
    );
  }
}
