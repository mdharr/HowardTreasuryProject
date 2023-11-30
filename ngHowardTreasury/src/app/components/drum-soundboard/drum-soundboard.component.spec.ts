import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DrumSoundboardComponent } from './drum-soundboard.component';

describe('DrumSoundboardComponent', () => {
  let component: DrumSoundboardComponent;
  let fixture: ComponentFixture<DrumSoundboardComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [DrumSoundboardComponent]
    });
    fixture = TestBed.createComponent(DrumSoundboardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
