import got from 'got';
import { JSDOM } from 'jsdom';

const getPreviewUrl = (url) => {
  const previewUrl = new URL('https://publish.twitter.com/oembed.json');
  previewUrl.searchParams.append('url', url);
  previewUrl.searchParams.append('dnt', 'true');
  return previewUrl.toString();
};

const extractTweet = (html) => {
  const dom = new JSDOM(html);
  return dom.window.document.querySelector('p').innerHTML;
};

export default {
  matches: (url) => {
    const { host, pathname } = new URL(url);
    return host.includes('twitter.com') && pathname.includes('/status/');
  },
  preview: async (url) => {
    const response = await got(getPreviewUrl(url), {
      resolveBodyOnly: true,
      responseType: 'json',
    });

    return {
      description: extractTweet(response.html),
      title: `${response.author_name} (@${new URL(response.author_url).pathname.split('/').pop()})`,
      logo: "https://abs.twimg.com/responsive-web/client-web-legacy/icon-ios.b1fc7276.png",
      url
    };
  }
};
