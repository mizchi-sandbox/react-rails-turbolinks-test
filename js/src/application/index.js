global.app = {
  component: null;
};
const ROOT_SELECTOR = '#content';
const HEADER_OBJECT = T;
const HEADER_PREFIX = 'T.';

Turbolinks.setRootSelector(ROOT_SELECTOR);

function parseProps(el) {
  let str = el.getAttribute('data-react-props');
  try {
    return JSON.parse(str);
  } catch (e) {
    return {};
  }
}

function getComponentClass(el) {
  let str = el.getAttribute('data-react-class');
  let componentName = str.replace(HEADER_PREFIX, '')
  return HEADER_OBJECT[componentName];
}

var lastComponent = null;
function onLoad() {
  let root = document.querySelector(ROOT_SELECTOR);
  let renderedRoot = document.querySelector(ROOT_SELECTOR + ' > *');

  let props = parseProps(renderedRoot);
  let component = getComponentClass(renderedRoot);
  if (app.component && lastComponent === component) {
    app.component.setProps(props);
  } else {
    app.component = React.render(React.createElement(component, props), root);
    lastComponent = app.component;
  }
}

window.addEventListener("DOMContentLoaded", onLoad);
window.addEventListener("page:load", onLoad);
