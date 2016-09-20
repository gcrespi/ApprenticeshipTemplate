'use strict';

/**
 * @ngdoc service
 * @name tusLibrosApp.CartService
 * @description
 * # Cart
 * Service in the tusLibrosApp.
 */
angular.module('tusLibrosApp')
  .service('CartService', function ($http) {
    this.requestCreateCart = function createCart() {
      return $http.post('http://localhost:3000/carts', {})
          .then(function (response) {
              return response.data;
          });
    };
  });
