'use strict';

/**
 * @ngdoc service
 * @name tusLibrosApp.user
 * @description
 * # user
 * Service in the tusLibrosApp.
 */
angular.module('tusLibrosApp')
    .service('UserService', ['$http', '$q', 'CartService', function ($http, $q, CartService) {
        this.request_login = function request_login(user) {
            return $http.post('http://localhost:3000/carts', {
                username: user.name,
                password: user.password
            }).then(function (response){
                CartService.cart_id = response.data.cart_id;
                return response.data;
            });
        };
    }]);
