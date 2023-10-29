import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'stripHtml'
})
export class StripHtmlPipe implements PipeTransform {
  transform(value: string): string {
    if (!value) {
      return value;
    }
    // Use a regular expression to strip HTML tags and other elements
    let text = value.replace(/<[^>]*>/g, ''); // Remove HTML tags

    // Use regular expressions to replace HTML entities
    text = text.replace(/&nbsp;/g, ' ');
    text = text.replace(/&ldquo;/g, '“');
    text = text.replace(/&rdquo;/g, '”');
    text = text.replace(/&rsquo;/g, '’');
    text = text.replace(/&mdash;/g, '—');
    text = text.replace(/&ndash;/g, '–');
    text = text.replace(/&lsquo;/g, '‘');
    text = text.replace(/&amp;/g, '&');
    text = text.replace(/&hellip;/g, '…');
    // Add more replacements as needed

    return text;
  }
}
