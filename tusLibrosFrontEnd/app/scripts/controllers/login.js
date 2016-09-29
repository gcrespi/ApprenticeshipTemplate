'use strict';

/**
 * @ngdoc function
 * @name tusLibrosApp.controller:LoginController
 * @description
 * # LoginCtrl
 * Controller of the tusLibrosApp
 */
angular.module('tusLibrosApp')
    .controller('LoginController', ['$scope', '$location', 'CartService', 'ngToast',
        function ($scope, $location, CartService, ngToast) {
            $scope.user = {name: '', password: ''};

            $scope.login = function login(user) {
                if ($scope.loginForm.$valid) {
                    CartService.cartCreate(user).then(function () {
                        $location.path('/main/');
                    }, function onFailure(response) {
                        ngToast.create('response.data.error');
                    });
                } else {
                    ngToast.create('Revisá los campos, alguno no fué ingresado correctamente');
                }
            };
        }]);
