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
            $scope.user = {name: 'cosme', password: '123'};

            $scope.login = function login(user) {
                if ($scope.loginForm.$valid) {
                    CartService.cartCreate(user).then(function () {
                        $location.path('/main/');
                    }, function onFailure(response) {
                        ngToast.danger(response.data.error);
                    });
                } else {
                    ngToast.danger('Revisá los campos, alguno no fué ingresado correctamente');
                }
            };
        }]);
