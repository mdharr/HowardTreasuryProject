import { ApplicationRef, ComponentFactoryResolver, EmbeddedViewRef, Injectable, Injector } from '@angular/core';
import { FullscreenImageComponent } from '../components/fullscreen-image/fullscreen-image.component';

@Injectable({
  providedIn: 'root'
})
export class FullscreenImageService {

  constructor(
    private componentFactoryResolver: ComponentFactoryResolver,
    private appRef: ApplicationRef,
    private injector: Injector
  ) {}

  open(imageUrl: string) {
    // Create a component reference from the component
    const componentRef = this.componentFactoryResolver
      .resolveComponentFactory(FullscreenImageComponent)
      .create(this.injector);

    // Set the image URL
    componentRef.instance.imageUrl = imageUrl;

    // Attach the component to the appRef so that it's inside the ng component tree
    this.appRef.attachView(componentRef.hostView);

    // Get the DOM element from the component
    const domElem = (componentRef.hostView as EmbeddedViewRef<any>)
      .rootNodes[0] as HTMLElement;

    // Append the DOM element to the body
    document.body.appendChild(domElem);

    // Listen to close event to remove the component
    componentRef.instance.closed.subscribe(() => {
      this.appRef.detachView(componentRef.hostView);
      componentRef.destroy();
    });

    // Open the full screen image
    componentRef.instance.open();
  }
}
