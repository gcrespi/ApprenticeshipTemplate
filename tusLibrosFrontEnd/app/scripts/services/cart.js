'use strict';

/**
 * @ngdoc service
 * @name tusLibrosApp.CartService
 * @description
 * # Cart
 * Service in the tusLibrosApp.
 */
angular.module('tusLibrosApp')
    .service('CartService', ['$http', '$resource', 'backendUrl', function ($http, $resource, backendUrl) {
        var cart = null;
        var Cart = $resource(backendUrl + '/carts/:id/', {id: '@id'}, {
            'addBooks': {method: 'POST', url: backendUrl + '/carts/:id/addBooks'},
            'checkout': {method: 'POST', url: backendUrl + '/carts/:id/checkout'}
        });

        this.cartCreate = function cartCreate(user) {
            cart = new Cart();
            return cart.$save({username: user.name, password: user.password});
        };

        this.requestAddToCart = function requestAddToCart(book_isbn, quantity) {
            return cart.$addBooks({isbn: book_isbn, quantity: quantity}).then(function () {
                refresh();
            });
        };

        this.checkout = function checkout(aCard) {
            cart.credit_card = aCard;
            return cart.$checkout().then(function () {
                cart = null;
            });
        };

        var refresh = function refresh() {
            return cart.$get();
        };

        this.hasCart = function hasCart() {
            return cart != null;
        };

        this.content = function () {
            return cart.content;
        };
    }]);
