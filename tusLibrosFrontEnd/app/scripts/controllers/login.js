'use strict';

/**
 * @ngdoc function
 * @name tusLibrosApp.controller:LoginController
 * @description
 * # LoginCtrl
 * Controller of the tusLibrosApp
 */
angular.module('tusLibrosApp')
    .controller('LoginController', ['$scope', '$location', 'CartService',
    function ($scope, $location, CartService) {
        $scope.user = {name: '', password: ''};

        $scope.login = function login(user) {
            if ($scope.loginForm.$valid) {
                CartService.cartCreate(user).then(function () {
                    $location.path('/main/');
                }, function onFailure(response) {
                    alert(response.data.error)
                });
            } else {
                alert('El form no es válido :(');
            }
        };
    }]);
