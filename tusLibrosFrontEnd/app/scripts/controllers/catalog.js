'use strict';

/**
 * @ngdoc function
 * @name tusLibrosApp.controller:CatalogCtrl
 * @description
 * # CatalogCtrl
 * Controller of the tusLibrosApp
 */
angular.module('tusLibrosApp')
    .controller('CatalogCtrl', ['$location', '$scope', 'catalogService', 'CartService',
        function ($location, $scope, catalogService, CartService) {
            catalogService.getAllBooks().then(function (books) {
                $scope.catalog = books;
            }).catch(function (response) {
                alert(response.data.error);
            });

            $scope.addToCart = function addToCart(bookIsbn) {
                if (CartService.hasCart()) {
                    CartService.requestAddToCart(bookIsbn, 1).then(function () {
                        alert('Exito!');
                    }).catch(function () {
                        alert('Buhh!');
                    });
                } else {
                    $location.path('/login');
                    alert("Debes iniciar sesión para acceder a un carrito");
                }
            };
        }]);
