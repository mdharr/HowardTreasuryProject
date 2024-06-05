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

