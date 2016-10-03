'use strict';

/**
 * @ngdoc function
 * @name tusLibrosApp.controller:CheckoutCtrl
 * @description
 * # CheckoutCtrl
 * Controller of the tusLibrosApp
 */
angular.module('tusLibrosApp')
    .controller('CheckoutCtrl', ['_', '$scope', '$location', 'CartService', 'ngToast',
        function (_, $scope, $location, CartService, ngToast) {
            var currentYear = new Date().getFullYear();

            $scope.monthValidations = {
                'required' : 'Este campo es obligatorio'
            };

            $scope.ownerValidations = {
                'required' : 'Este campo es obligatorio',
                'maxlength' : 'El nombre del dueño es demasiado largo'
            };

            $scope.numberValidations =  {
                'required' : 'Este campo es obligatorio',
                'pattern' : 'El número de la tarjeta debe estar compuesto por 16 dígitos'
            };

            $scope.card = {
                owner: '',
                number: '',
                expiration_date: {
                    day: 1,
                    month: null,
                    year: null
                }
            };

            $scope.months = _.range(1, 13);
            $scope.years = _.range(currentYear, currentYear + 30);

            $scope.checkout = function checkout(aCard) {
                if ($scope.checkoutForm.$valid) {
                    CartService.checkout(aCard).then(function () {
                        $location.path('/compraExitosa');
                    }).catch(function () {
                        ngToast.danger('Buhh!');
                    });
                } else {
                    ngToast.danger('El form no es valido :(');
                }
            }
        }]);
