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
        $scope.content = CartService.content();
    }]);
