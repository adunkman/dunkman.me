import metascraper from 'metascraper';
import description from 'metascraper-description';
import image from 'metascraper-image';
import favicon from 'metascraper-logo-favicon';
import title from 'metascraper-title';
import url from 'metascraper-url';
import got from 'got';
import express from 'express';
import { requestCache } from './lib/requestCache.js';
import wikipedia from './rules/wikipedia.js';
import twitter from './rules/twitter.js';

const parser = metascraper([
  description(),
  image(),
  favicon(),
  title(),
  url(),
]);

const app = express();
app.set('json spaces', 2);

app.get('/', (req, res) => {
  res.sendStatus(200);
});

app.get('/expand', async (req, res, next) => {
  let metadata;

  try {
    // Twitter may return unpredictable status codes on their homepage; use the
    // API exclusively.
    if (twitter.matches(req.query.url)) {
      metadata = await twitter.preview(req.query.url);
    }
    else {
      const { body: html, url } = await got(req.query.url, { cache: requestCache });
      metadata = await parser({ html, url, validateUrl: false });

      if (wikipedia.matches(req.query.url)) {
        Object.assign(metadata, await wikipedia.preview(req.query.url));
      }
    }
  }
  catch (err) {
    next(err);
  }

  res.send(metadata);
});

app.use((err, req, res, next) => {
  res.status(500).send({
    name: err.name,
    message: err.message,
    code: err.code,
    stack: err.stack ? err.stack.split('\n').map(s => s.trim()) : null,
  });
});

app.listen(process.env.PORT, () => {
  console.log(`listening on ${process.env.PORT}`)
});
