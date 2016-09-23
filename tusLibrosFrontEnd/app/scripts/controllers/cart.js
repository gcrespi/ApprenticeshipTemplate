'use strict';

/**
 * @ngdoc function
 * @name tusLibrosApp.controller:CartController
 * @description
 * # CartCtrl
 * Controller of the tusLibrosApp
 */
angular.module('tusLibrosApp')
    .controller('CartController', ['$scope', 'CartService', function ($scope, CartService) {
        CartService.getCart();
        $scope.content = CartService.content();
        console.log($scope.content);

        $scope.addToCart = function addToCart(book_isbn) {
            CartService.requestAddToCart(book_isbn, 1).then(function onSuccess(){
                alert('Exito!');
            }).catch(function (){
                alert('Buhh!');
            });
        };
    }]);
