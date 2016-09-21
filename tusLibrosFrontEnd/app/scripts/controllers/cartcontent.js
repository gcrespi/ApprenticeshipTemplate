'use strict';

/**
 * @ngdoc function
 * @name tusLibrosApp.controller:CartContentCtrl
 * @description
 * # CartContentCtrl
 * Controller of the tusLibrosApp
 */
angular.module('tusLibrosApp')
    .controller('CartContentCtrl', ['$scope', 'CartService', function ($scope, CartService) {
        CartService.getContent().then(function (content){
           $scope.content = content;
        }, function onFailure(response){
            alert(response.data.error);
        });
    }]);
