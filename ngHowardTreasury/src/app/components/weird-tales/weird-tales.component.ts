import { WeirdTalesService } from './../../services/weird-tales.service';
import { Component, inject, OnInit, OnDestroy, Renderer2, ViewChild, ElementRef, AfterViewInit, ViewChildren, QueryList } from '@angular/core';
import { WeirdTales } from 'src/app/models/weird-tales';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { trigger, transition, query, style, stagger, animate } from '@angular/animations';

@Component({
  selector: 'app-weird-tales',
  templateUrl: './weird-tales.component.html',
  styleUrls: ['./weird-tales.component.css']
})
export class WeirdTalesComponent implements OnInit, OnDestroy, AfterViewInit {

  @ViewChildren('magazine') magazineElements!: QueryList<ElementRef>;

  // properties
  weirdTales: WeirdTales[] = [];
  weirdTalesImages: string[] = [];

  // subscriptions declarations
  private weirdTalesSubscription: Subscription | undefined;

  // injections
  router = inject(Router);
  renderer = inject(Renderer2);
  weirdTalesService = inject(WeirdTalesService);

  ngOnInit() {
    this.subscribeToWeirdTalesService();

  }

  ngOnDestroy(): void {
    if(this.weirdTalesSubscription) {
      this.weirdTalesSubscription.unsubscribe();
    }
  }

  ngAfterViewInit() {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          setTimeout(() => {
            this.renderer.addClass(entry.target, 'visible');
          }, 1000);
        }
      });
    }, { threshold: 0.1 });

    this.magazineElements.changes.subscribe((comps: QueryList<ElementRef>) => {
      comps.forEach(el => {
        observer.observe(el.nativeElement);
      });
    });
  }

  subscribeToWeirdTalesService() {
    this.weirdTalesSubscription = this.weirdTalesService.indexAll().subscribe({
      next: (data) => {
        this.weirdTales = data;
        this.weirdTalesImages = data.slice(7).map(tale => tale.imageUrl);
      },
      error: (fail) => {
        console.error('Failed to index weird tales magazine objects');
        console.error(fail);
      }
    });
  }

}
