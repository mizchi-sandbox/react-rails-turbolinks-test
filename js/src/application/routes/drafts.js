let DraftComponent = require('../../components/draft-component');

// handle drafts/:mode
export default ({mode}) => {
  app.mountRoot(DraftComponent, {type: mode});
}
