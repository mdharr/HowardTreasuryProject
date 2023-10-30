import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ImageZoomService {
  private zoomStateSubject = new BehaviorSubject<boolean>(false);

  setZoomState(zoomed: boolean) {
    this.zoomStateSubject.next(zoomed);
  }

  getZoomState(): Observable<boolean> {
    return this.zoomStateSubject.asObservable();
  }
}
