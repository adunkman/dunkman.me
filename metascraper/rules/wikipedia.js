import got from 'got';

const getPreviewUrl = (url) => {
  const previewUrl = new URL(url);
  previewUrl.pathname = previewUrl.pathname.replace('/wiki/', '/api/rest_v1/page/summary/');
  return previewUrl.toString();
}

export default {
  matches: (url) => {
    return new URL(url).host.includes('wikipedia.org');
  },
  preview: async (url) => {
    const response = await got(getPreviewUrl(url), {
      resolveBodyOnly: true,
      responseType: 'json',
    });

    return {
      description: response.extract,
      title: response.displaytitle,
      image: response.thumbnail?.source || null,
    };
  }
};
