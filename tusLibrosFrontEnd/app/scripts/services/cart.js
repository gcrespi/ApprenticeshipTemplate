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
        this.cart_id = null;

        this.requestAddToCart = function requestAddToCart(book_isbn, quantity) {
            return $http.post('http://localhost:3000/carts/' + this.cart_id + '/add_book', {
                isbn: book_isbn,
                quantity: quantity
            }).then(function (response) {
                return response.data;
            });
        };

        this.getContent = function getContent() {
            return $http.get('http://localhost:3000/carts/' + this.cart_id + '/list')
                .then(function onSuccess(response) {
                    return response.data;
                });
        }
    });
