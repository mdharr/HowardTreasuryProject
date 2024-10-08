import { trigger, transition, query, style, stagger, animate } from '@angular/animations';
import { ThisReceiver } from '@angular/compiler';
import { Component, ElementRef, inject, OnDestroy, OnInit, ViewChild, AfterViewInit, ViewChildren, QueryList } from '@angular/core';
import { Subscription } from 'rxjs';
import { Person } from 'src/app/models/person';
import { AuthService } from 'src/app/services/auth.service';
import { PersonService } from 'src/app/services/person.service';
import { AnimatedCardComponent } from '../animated-card/animated-card.component';

@Component({
  selector: 'app-characters',
  templateUrl: './characters.component.html',
  styleUrls: ['./characters.component.css'],
  animations: [
    trigger('customEasingAnimation', [
      transition(':enter', [
        query('.char-card', [
          style({ opacity: 0, transform: 'translateY(20px)' }),
          stagger(100, [
            animate('0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55)', style({ opacity: 1, transform: 'none' })),
          ]),
        ], { optional: true }),
      ]),
    ]),
  ]
})
export class CharactersComponent implements OnInit, OnDestroy, AfterViewInit {
  @ViewChildren(AnimatedCardComponent) animatedCards!: QueryList<AnimatedCardComponent>;
  @ViewChild('charContainer') charContainer!: ElementRef;

  // properties initialization
  persons: Person[] = [];
  person: Person = new Person();

  // booleans
  isLoaded: boolean = false;
  loading: boolean = false;
  showAll: boolean = false;
  fadeComplete: boolean = false;

  hoveredIndex: number | null = null;
  private hoverTimeout: any;
  private leaveTimeout: any;

  // subscriptions declarations
  private personSubscription: Subscription | undefined;

  // view child
  @ViewChild('bgImage') bgImage!: ElementRef;
  @ViewChild('overlayVideo') overlayVideo!: ElementRef;

  backgroundImageUrl = 'https://reh.world/wp-content/uploads/2022/02/Kayanan-Howard-characters.png';

  // service injections
  auth = inject(AuthService);
  personService = inject(PersonService);

  ngOnInit(): void {
    window.scrollTo(0, 0);
    this.subscribeToSubscriptions();
    this.triggerCustomEasingAnimation();
  }

  subscribeToSubscriptions = () => {
    this.personSubscription = this.personService.indexAll().subscribe({
      next: (data) => {
        this.persons = data;
        this.isLoaded = true;
      },
      error:(fail) => {
        console.error('Error retrieving persons');
        console.error(fail);
      }
    });
  }

  destroySubscriptions = () => {
    if (this.personSubscription) {
      this.personSubscription.unsubscribe();
    }
  }

  ngAfterViewInit(): void {
    this.checkImagesLoaded();
  }

  checkImagesLoaded() {
    // Initialize total and loaded counts
    let totalImages = 0;
    let loadedImages = 0;

    // Iterate through each AnimatedCardComponent
    this.animatedCards.forEach((card) => {
      // Update the totalImages count
      totalImages += 2; // You have 3 images in each card

      // Listen for the imagesLoaded event in each AnimatedCardComponent
      card.imagesLoaded.subscribe(() => {
        // Increment the loadedImages count
        loadedImages++;

        // Check if all images are loaded
        if (loadedImages === totalImages) {
          this.isLoaded = true;
        }
      });
    });
  }

  triggerCustomEasingAnimation() {
    setTimeout(() => {
      this.showAll = true;
    }, 100);
  }

  onCardEnter(index: number) {
    clearTimeout(this.leaveTimeout);
    clearTimeout(this.hoverTimeout);

    if (this.hoveredIndex !== index) {
      this.hoveredIndex = index;

      this.hoverTimeout = setTimeout(() => {
        const cards = this.charContainer.nativeElement.querySelectorAll('.char-card');
        cards.forEach((card: Element, i: number) => {
          if (i !== index) {
            card.classList.add('dimmed');
          } else {
            card.classList.remove('dimmed');
          }
        });
      }, 50);
    }
  }

  onCardLeave(index: number) {
    clearTimeout(this.hoverTimeout);

    this.leaveTimeout = setTimeout(() => {
      if (this.hoveredIndex === index) {
        this.hoveredIndex = null;
        const cards = this.charContainer.nativeElement.querySelectorAll('.char-card');
        cards.forEach((card: Element) => card.classList.remove('dimmed'));
      }
    }, 50);
  }

  playVideo(video: HTMLVideoElement) {
    video.style.opacity = '1';
    video.playbackRate = 0.5;
    video.play();
  }

  ngOnDestroy() {
    this.destroySubscriptions();
    clearTimeout(this.hoverTimeout);
    clearTimeout(this.leaveTimeout);
  }
}
