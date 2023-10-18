import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-stop-light-test',
  templateUrl: './stop-light-test.component.html',
  styleUrls: ['./stop-light-test.component.css']
})
export class StopLightTestComponent implements OnInit {

  states: string[] = ['go', 'slow', 'stop'];
  currentState: string = '';

  ngOnInit() {
    this.currentState = this.states[0];
    setInterval(() => {
      if (this.currentState == this.states[0]) {
        this.currentState = this.states[1];
      }
      else if(this.currentState == this.states[1]) {
        this.currentState = this.states[2];
      }
      else {
        this.currentState = this.states[0];
      }
    }, 5000);
  }

}
