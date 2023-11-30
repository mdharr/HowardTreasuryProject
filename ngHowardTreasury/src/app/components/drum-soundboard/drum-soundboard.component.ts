import { Component, AfterViewInit, OnInit } from '@angular/core';

@Component({
  selector: 'app-drum-soundboard',
  templateUrl: './drum-soundboard.component.html',
  styleUrls: ['./drum-soundboard.component.css']
})
export class DrumSoundboardComponent implements AfterViewInit {

  ngAfterViewInit() {
    window.addEventListener('keydown', (e) => {
      this.playAudio(e);
    });
  }

  playAudio(e: KeyboardEvent) {
    const key = e.key.toUpperCase(); // Convert to uppercase to match your data-key attributes if they are uppercase.
    const audio = document.querySelector(`audio[data-key="${key.charCodeAt(0)}"]`) as HTMLAudioElement;
    if (!audio) { return; }
    audio.currentTime = 0;
    audio.play();
  }

}
