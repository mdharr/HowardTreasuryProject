// export function typeText(
//   element: HTMLElement,
//   text: string,
//   interval: number = 5,
//   callback?: () => void
// ): void {
//   let charIndex = 0;

//   function type() {
//     if (charIndex < text.length) {
//       element.textContent += text.charAt(charIndex);
//       charIndex++;
//       setTimeout(type, interval);
//     } else if (callback) {
//       callback();
//     }
//   }

//   type();
// }

export function typeText(element: HTMLElement, text: string, delay: number, callback: () => void): void {
  let index = 0;

  const type = () => {
    if (index < text.length) {
      element.innerHTML += text.charAt(index);
      index++;
      setTimeout(type, delay);
    } else {
      callback();
    }
  };

  type();
}

