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
      catalogService.getAllBooks().then(function onSuccess(books) {
          $scope.catalog = books;
      }, function onFailure(response){
          alert(response.data.error);
      });

      $scope.addToCart = function addToCart(book_isbn) {
          if(CartService.hasCart()) {
              CartService.requestAddToCart(book_isbn, 1).then(function (){
                  alert('Exito!');
              }).catch(function (){
                  alert('Buhh!');
              });
          } else {
              $location.path('/login');
              alert("Debes iniciar sesión para acceder a un carrito");
          }
      };
  }]);
