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
                controllerAs: 'catalogService'
            })
            .when('/carts/new', {
                templateUrl: 'views/new_cart.html',
                controller: 'CartController',
                controllerAs: 'login'
            })
            .when('/cart', {
                templateUrl: 'views/cart.html',
                controller: 'CartController',
                controllerAs: 'cartContent'
            })
            .otherwise({
                redirectTo: '/'
            });
    });
