import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'stripNonAlphanumeric'
})
export class StripNonAlphanumericPipe implements PipeTransform {

  transform(value: string): string {
    if (!value) {
      return value;
    }
    // Use a regular expression to strip HTML tags and other elements
    let text = value.replace(/[^a-zA-Z0-9]/g, ''); // Remove HTML tags

    return text;
  }

}
