import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class OpenAiService {

  private url = environment.baseUrl + 'api/adventure/response'

  constructor(private http: HttpClient) {}

  getAdventureResponse(message: string): Observable<any> {
    return this.http.post<any>(this.url, { message });
  }
}
