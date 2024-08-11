import { Component, Input } from '@angular/core';
import { Collection } from 'src/app/models/collection';

@Component({
  selector: 'app-del-rey-collections',
  templateUrl: './del-rey-collections.component.html',
  styleUrls: ['./del-rey-collections.component.css']
})
export class DelReyCollectionsComponent {

  @Input() collections!: Collection[];

}
