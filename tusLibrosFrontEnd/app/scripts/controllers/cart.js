'use strict';

/**
 * @ngdoc function
 * @name tusLibrosApp.controller:CartController
 * @description
 * # CartCtrl
 * Controller of the tusLibrosApp
 */
angular.module('tusLibrosApp')
    .controller('CartController', ['$scope', '$location', 'CartService', function ($scope, $location, CartService) {
        $scope.content = CartService.content();
        $scope.emptyCart = function () {
            return $scope.content.length == 0;
        };
    }]);
