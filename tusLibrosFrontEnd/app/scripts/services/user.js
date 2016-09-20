'use strict';

/**
 * @ngdoc service
 * @name tusLibrosApp.user
 * @description
 * # user
 * Service in the tusLibrosApp.
 */
angular.module('tusLibrosApp')
  .service('UserService', function ($http) {
    this.request_login = function request_login(user) {
      return $http.post('http://localhost:3000/login', {username: user.name, password: user.password})
          .then(function (response) {
            return response.status === 200
          });
    };
  });
