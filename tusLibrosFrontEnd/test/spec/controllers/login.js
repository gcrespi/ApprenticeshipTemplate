'use strict';

describe('Controller: LoginCtrl', function () {

  beforeEach(module('tusLibrosApp'));

  var LoginCtrl, scope, user = {
      name: 'cosme',
      password: '123'
  };

  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    LoginCtrl = $controller('LoginCtrl', {
      $scope: scope,
      UserService: {
          request_login: function(user) {
            return true;
          }
      }
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(LoginCtrl.login(user)).toBe(true);
  });
});
