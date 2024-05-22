import { StripNonAlphanumericPipe } from './strip-non-alphanumeric.pipe';

describe('StripNonAlphanumericPipe', () => {
  it('create an instance', () => {
    const pipe = new StripNonAlphanumericPipe();
    expect(pipe).toBeTruthy();
  });
});
