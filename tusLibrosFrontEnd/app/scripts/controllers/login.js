'use strict';

/**
 * @ngdoc function
 * @name tusLibrosApp.controller:LoginController
 * @description
 * # LoginCtrl
 * Controller of the tusLibrosApp
 */
angular.module('tusLibrosApp')
    .controller('LoginController', ['$rootScope', '$scope', '$location', 'UserService',
    function ($rootScope, $scope, $location, UserService) {
        $scope.user = {name: '', password: ''};

        $scope.login = function login(user) {
            if ($scope.loginForm.$valid) {
                UserService.request_login(user).then(function onSuccess() {
                    $location.path('/main/');
                }, function onFailure(response) {
                    alert(response.data.error)
                });
            } else {
                alert('El form no es valido :(')
            }
        };
    }]);
