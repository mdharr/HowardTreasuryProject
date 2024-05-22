import { Component, OnInit, AfterViewInit } from '@angular/core';

@Component({
  selector: 'app-about',
  templateUrl: './about.component.html',
  styleUrls: ['./about.component.css']
})
export class AboutComponent implements OnInit, AfterViewInit {

  isLoaded: boolean = false;

  ngOnInit() {
    window.scrollTo(0, 0);
  }

  ngAfterViewInit() {
    this.checkImageLoaded();
  }

  checkImageLoaded() {
    const image = new Image();
    image.onload = () => {
      this.isLoaded = true;
    };
    image.src = "https://goodman-games.com/wp-content/uploads/2021/01/REH-colofon.jpg";
  }

}
