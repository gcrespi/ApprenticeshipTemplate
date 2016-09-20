'use strict';

/**
 * @ngdoc function
 * @name tusLibrosApp.controller:LoginController
 * @description
 * # LoginCtrl
 * Controller of the tusLibrosApp
 */
angular.module('tusLibrosApp')
  .controller('LoginController', ['$scope', 'UserService', function ($scope, UserService) {
      $scope.user = { name: '', password: '' };

      $scope.login = function login(user) {
          var success = UserService.request_login(user);
          console.log(success);
      };
  }]);
