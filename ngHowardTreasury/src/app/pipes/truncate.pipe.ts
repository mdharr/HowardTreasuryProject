import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'truncate'
})
export class TruncatePipe implements PipeTransform {
  transform(value: string, maxLength: number): string {
    if (value.length <= maxLength) {
      return value;
    } else {
      const truncatedText = value.substring(0, maxLength);
      const lastSpaceIndex = truncatedText.lastIndexOf(' ');

      if (lastSpaceIndex !== -1) {
        return truncatedText.substring(0, lastSpaceIndex) + '...';
      } else {
        return truncatedText + '...';
      }
    }
  }
}
