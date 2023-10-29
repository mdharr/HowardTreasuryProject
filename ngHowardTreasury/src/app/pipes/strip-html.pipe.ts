import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'stripHtml'
})
export class StripHtmlPipe implements PipeTransform {
  transform(value: string): string {
    // Use a regular expression to strip HTML tags and other elements
    const regex = /(<([^>]+)>)/gi;
    const text = value.replace(regex, '');

    return text;
  }
}
