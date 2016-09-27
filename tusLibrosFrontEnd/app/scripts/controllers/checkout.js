'use strict';

/**
 * @ngdoc function
 * @name tusLibrosApp.controller:CheckoutCtrl
 * @description
 * # CheckoutCtrl
 * Controller of the tusLibrosApp
 */
angular.module('tusLibrosApp')
    .controller('CheckoutCtrl', ['_', '$scope', '$location', 'CartService', 'CardService',
        function (_, $scope, $location, CartService, CardService) {
            var currentYear = new Date().getFullYear();

            $scope.card = CardService.card;
            $scope.months = _.range(1, 13);
            $scope.years = _.range(currentYear, currentYear + 30);

            $scope.classRulesFor = function classRulesFor(anInput) {
                return {
                    'has-error': anInput.$touched && anInput.$invalid,
                    'has-success': anInput.$valid
                };
            };

            $scope.checkout = function checkout(aCard) {
                if ($scope.checkoutForm.$valid) {
                    CartService.checkout(aCard).then(function () {
                        $location.path('/compraExitosa');
                    }).catch(function () {
                        alert('Buhh!');
                    });
                } else {
                    alert('El form no es valido :(');
                }
            }
        }]);
