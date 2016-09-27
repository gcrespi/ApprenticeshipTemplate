'use strict';

/**
 * @ngdoc overview
 * @name tusLibrosApp
 * @description
 * # tusLibrosApp
 *
 * Main module of the application.
 */
angular
    .module('tusLibrosApp', [
        'ngAnimate',
        'ngCookies',
        'ngResource',
        'ngRoute',
        'ngSanitize',
        'ngTouch'
    ])
    .config(function ($routeProvider) {
        var requireLogin = {
            "check": function ($location, CartService) {
                if (!CartService.hasCart()) {
                    $location.path('/login');
                    alert("Debes iniciar sesión para acceder a un carrito");
                }
            }
        };
        $routeProvider
            .when('/', {
                templateUrl: 'views/main.html',
                controller: 'MainCtrl',
                controllerAs: 'main'
            })
            .when('/about', {
                templateUrl: 'views/about.html',
                controller: 'AboutCtrl',
                controllerAs: 'about'
            })
            .when('/login', {
                templateUrl: 'views/login.html',
                controller: 'LoginController',
                controllerAs: 'login'
            })
            .when('/catalog', {
                templateUrl: 'views/catalog.html',
                controller: 'CatalogCtrl',
                controllerAs: 'Catalog'
            })
            .when('/purchases', {
                templateUrl: 'views/sales.html',
                controller: 'SaleCtrl',
                controllerAs: 'Sale'
            }).when('/cart', {
                templateUrl: 'views/cart.html',
                controller: 'CartController',
                controllerAs: 'cartContent',
                resolve: requireLogin
            }).when('/checkout', {
                templateUrl: 'views/checkout.html',
                controller: 'CheckoutCtrl',
                controllerAs: 'checkout',
                resolve: requireLogin
            }).when('/compraExitosa', {
                templateUrl: 'views/compraexitosa.html'
            }).otherwise({
                redirectTo: '/'
            });
    });
