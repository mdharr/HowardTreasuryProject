import { CustomSnackbarComponent } from './../components/custom-snackbar/custom-snackbar.component';
import { Injectable } from '@angular/core';
import { MatSnackBar, MatSnackBarRef } from '@angular/material/snack-bar';

@Injectable({
  providedIn: 'root'
})
export class SnackbarService {
  private snackbarRef: MatSnackBarRef<CustomSnackbarComponent> | null = null;

  constructor(private snackBar: MatSnackBar) {}

  openSnackbar(message: string, action?: string, duration: number = 6000): MatSnackBarRef<CustomSnackbarComponent> {
    this.snackbarRef = this.snackBar.openFromComponent(CustomSnackbarComponent, {
      duration: duration,
      data: { message: message, action: action }
    });
    return this.snackbarRef;
  }

  updateSnackbarMessage(message: string) {
    if (this.snackbarRef) {
      this.snackbarRef.instance.data = { ...this.snackbarRef.instance.data, message: message };
      this.snackbarRef.instance['cdr'].detectChanges();
    }
  }

  dismiss() {
    if (this.snackbarRef) {
      this.snackbarRef.dismiss();
      this.snackbarRef = null;
    }
  }
}
