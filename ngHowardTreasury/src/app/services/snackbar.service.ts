import { CustomSnackbarComponent } from './../components/custom-snackbar/custom-snackbar.component';
import { Injectable } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';

@Injectable({
  providedIn: 'root'
})
export class SnackbarService {

  constructor(private snackBar: MatSnackBar) {}

  openSnackbar(message: string, action?: string, duration: number = 4000) {
    this.snackBar.openFromComponent(CustomSnackbarComponent, {
      duration: duration,
      data: { message: message, action: action }
    });
  }
}
