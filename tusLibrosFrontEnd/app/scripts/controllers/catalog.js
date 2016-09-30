'use strict';

/**
 * @ngdoc function
 * @name tusLibrosApp.controller:CatalogCtrl
 * @description
 * # CatalogCtrl
 * Controller of the tusLibrosApp
 */
angular.module('tusLibrosApp')
    .controller('CatalogCtrl', ['$location', '$scope', 'Book', 'CartService', 'ngToast',
        function ($location, $scope, Book, CartService, ngToast) {
            Book.query().$promise.then(function (books) {
                $scope.catalog = books;
            }).catch(function () {
                ngToast.danger('Buhh!');
            });

            $scope.addToCart = function addToCart(bookIsbn) {
                if (CartService.hasCart()) {
                    CartService.requestAddToCart(bookIsbn, 1).then(function () {
                        ngToast.create('Se ha agregado un libro con éxito!');
                    }).catch(function () {
                        ngToast.danger('Buhh!');
                    });
                } else {
                    $location.path('/login');
                    alert("Debes iniciar sesión para acceder a un carrito");
                }
            };
        }]);
