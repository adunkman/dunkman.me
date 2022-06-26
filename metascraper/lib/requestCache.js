import Keyv from 'keyv';
import { KeyvFile } from 'keyv-file';
import { resolve } from 'path';

export const requestCache = new Keyv({
  store: new KeyvFile({
    filename: resolve(process.cwd(), 'cache/requests.json'),
  }),
});
