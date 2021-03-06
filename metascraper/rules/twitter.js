import got from 'got';
import { JSDOM } from 'jsdom';

const getPreviewUrl = (url) => {
  const previewUrl = new URL('https://api.twitter.com/1/statuses/oembed.json');
  previewUrl.searchParams.append('id', new URL(url).pathname.split('/').pop());
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
    };
  }
};
