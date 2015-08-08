import drafts from './routes/drafts';

export default function route(router) {
  router.route('', drafts);
}
