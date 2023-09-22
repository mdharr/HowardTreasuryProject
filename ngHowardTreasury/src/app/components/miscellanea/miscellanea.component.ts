import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Miscellanea } from 'src/app/models/miscellanea';
import { AuthService } from 'src/app/services/auth.service';
import { MiscellaneaService } from 'src/app/services/miscellanea.service';

@Component({
  selector: 'app-miscellanea',
  templateUrl: './miscellanea.component.html',
  styleUrls: ['./miscellanea.component.css']
})
export class MiscellaneaComponent implements OnInit, OnDestroy {

    // properties initialization
    miscellaneas: Miscellanea[] = [];

    // subscriptions declarations
    private miscellaneaSubscription: Subscription | undefined;

    // service injections
    auth = inject(AuthService);
    miscellaneaService = inject(MiscellaneaService);

    ngOnInit(): void {

      this.miscellaneaSubscription = this.miscellaneaService.indexAll().subscribe({
        next: (data) => {
          this.miscellaneas = data;
        },
        error:(fail) => {
          console.error('Error retrieving miscellaneas');
          console.error(fail);
        }
      });
    }

    ngOnDestroy(): void {
      if (this.miscellaneaSubscription) {
        this.miscellaneaSubscription.unsubscribe();
      }
    }
}
