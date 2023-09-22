import { Component, inject, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Miscellanea } from 'src/app/models/miscellanea';
import { AuthService } from 'src/app/services/auth.service';
import { MiscellaneaService } from 'src/app/services/miscellanea.service';

@Component({
  selector: 'app-miscellanea-details',
  templateUrl: './miscellanea-details.component.html',
  styleUrls: ['./miscellanea-details.component.css']
})
export class MiscellaneaDetailsComponent {

}
