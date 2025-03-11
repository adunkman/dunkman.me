import ky from 'ky';
import requestOptions from '../requestOptions.js';

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
    const response = await ky(getPreviewUrl(url), requestOptions).json();

    return {
      description: response.extract,
      title: response.title,
      image: response.thumbnail?.source || null,
    };
  }
};
