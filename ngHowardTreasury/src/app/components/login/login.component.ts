import { ChangeDetectorRef, Component, inject } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  loginUser: User = new User();

  public onlineUserCount: number = 0;

  public loggedInUserCount: number = 0;

  auth = inject(AuthService);
  router = inject(Router);
  modalService = inject(NgbModal);
  snackBar = inject(MatSnackBar);
  cdr = inject(ChangeDetectorRef);

  login(loginUser: User) {
    console.log("logging in");
    this.auth.login(loginUser.username, loginUser.password).subscribe({
      next: (loggedInUser) => {
        console.log("login success")
        console.log(loggedInUser);
        this.cdr.detectChanges();
        this.modalService.dismissAll();
        // this.router.navigateByUrl('home');
        this.snackBar.open('Login Success!', 'Dismiss', {
          duration: 4000,
          panelClass: ['mat-toolbar', 'mat-primary'],
          verticalPosition: 'bottom'
        });
      },
      error: (fail) => {
        console.error('login fail');
        console.error(fail);
        this.snackBar.open('Incorrect username or password', 'Dismiss', {
          duration: 1000,
          panelClass: ['mat-toolbar', 'mat-primary'],
          verticalPosition: 'bottom'
        });
      }
    })

  }

  dismissModal() {
    this.modalService.dismissAll();
  }
}
