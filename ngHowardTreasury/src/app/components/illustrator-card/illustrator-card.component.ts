import { Component, Input } from '@angular/core';
import { Illustrator } from 'src/app/models/illustrator';

@Component({
  selector: 'app-illustrator-card',
  templateUrl: './illustrator-card.component.html',
  styleUrls: ['./illustrator-card.component.css']
})
export class IllustratorCardComponent {
  @Input() illustrator: Illustrator = new Illustrator();
}
