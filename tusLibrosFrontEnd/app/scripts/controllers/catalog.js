'use strict';

/**
 * @ngdoc function
 * @name tusLibrosApp.controller:CatalogCtrl
 * @description
 * # CatalogCtrl
 * Controller of the tusLibrosApp
 */
angular.module('tusLibrosApp')
  .controller('CatalogCtrl', ['$scope', 'catalogService', function ($scope, catalogService) {
      catalogService.getAllBooks().then(function onSuccess(books) {
          $scope.catalog = books;
      }, function onFailure(response){
          alert(response.data.error);
      });
  }]);
