(function() {
  var models, nohm, redis;

  nohm = (require('nohm')).Nohm;

  models = require('../model/models');

  redis = (require('redis')).createClient();

  nohm.setClient(redis);

  nohm.setPrefix('cms-001');

  exports.index = function(req, res) {
    return res.render('index', {
      user: req.user,
      sitename: '我的小站'
    });
  };

  exports.session = function(req, res) {
    return res.redirect('/');
  };

  exports.logout = function(req, res) {
    req.logout();
    return res.redirect('/');
  };

  exports.newUser = function(req, res) {
    var user;
    user = nohm.factory('User');
    user.p({
      username: req.param('username'),
      password: req.param('password'),
      email: req.param('email'),
      firstName: req.param('firstName'),
      lastName: req.param('lastName')
    });
    return user.save(function(err) {
      if (err === 'invalid') {
        console.log('properties were invalid: ', user.errors);
        return res.json({
          result: 'err'
        });
      } else if (err) {
        console.log(err);
        return res.json({
          result: 'err'
        });
      } else {
        return res.json({
          result: 'success',
          data: user.allProperties()
        });
      }
    });
  };

}).call(this);
