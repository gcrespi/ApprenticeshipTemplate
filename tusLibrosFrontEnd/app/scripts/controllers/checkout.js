'use strict';

/**
 * @ngdoc function
 * @name tusLibrosApp.controller:CheckoutCtrl
 * @description
 * # CheckoutCtrl
 * Controller of the tusLibrosApp
 */
angular.module('tusLibrosApp')
    .controller('CheckoutCtrl', ['$scope', '$location', 'CartService', function ($scope, $location, CartService) {
        $scope.card = {
            owner: '',
            number: '',
            expiration_date: {
                day: 1,
                month: null,
                year: null
            }
        };

        $scope.checkout = function checkout(aCard) {
            CartService.checkout(aCard).then(function (){
                $location.path('/compraExitosa');
            }).catch(function (){
                alert('Buhh!');
            });
        }
    }]);
