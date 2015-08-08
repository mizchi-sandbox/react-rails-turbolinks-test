let template = require('./templates/foo');
module.exports = React.createClass({
  render() {
    return template(this);
  }
});
