import fetch from 'node-fetch';
import { axe, toHaveNoViolations } from 'jest-axe';
import { getSitePages } from './lib/sitemap';

expect.extend(toHaveNoViolations);

let pages: string[];

beforeAll(async () => {
  pages = await getSitePages(process.env.APP_HOST);
});

it('passes axe tests on all pages', async () => {
  for (const url of pages) {
    const response = await fetch(url);
    const html = await response.text();

    expect(response.status).toBe(200);
    expect(await axe(html), url).toHaveNoViolations();
  }
});
