import fetch from 'node-fetch';
import { URL } from 'url';
import { xml2js } from 'xml-js';

interface Sitemap {
  urlset: { url: Array<SitemapUrl> };
}

interface SitemapUrl {
  loc: { _text: string };
  lastmod: { _text: string };
}

const getSitePages = async (host?: string) => {
  if (!host) {
    throw new Error('host to fetch sitemap from is not defined');
  }

  const response = await fetch(`${host}/sitemap.xml`);
  const xml = await response.text();
  const data = xml2js(xml, { compact: true }) as Sitemap;

  return data.urlset.url.map(u => changeHost(new URL(host), u.loc._text));
};

const changeHost = ({ host }: URL, url: string) => {
  const parsedUrl = new URL(url);
  parsedUrl.host = host;
  return parsedUrl.toString();
};

export {
  getSitePages
};
