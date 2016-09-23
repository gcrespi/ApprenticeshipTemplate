'use strict';

/**
 * @ngdoc service
 * @name tusLibrosApp.CartService
 * @description
 * # Cart
 * Service in the tusLibrosApp.
 */
angular.module('tusLibrosApp')
    .service('CartService', ['$http', '$resource', function ($http, $resource) {
        var cart = null;
        var Cart = $resource(backendUrl + '/carts/:id/', {id:'@id'},
            {'addBooks': {method:'POST', url: backendUrl + '/carts/:id/addBooks'}});

        this.cartCreate = function cartCreate(user) {
            cart = new Cart();
            return cart.$save({username: user.name, password: user.password});
        };

        this.requestAddToCart = function requestAddToCart(book_isbn, quantity) {
            return cart.$addBooks({isbn: book_isbn, quantity: quantity});
        };

        this.refresh = function refresh() {
            return cart.$get().then(function (aCart) {
                cart = aCart;
            });
        };

        this.content = function() {
        return cart.content;
        }
    }]);
