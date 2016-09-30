'use strict';

/**
 * @ngdoc service
 * @name tusLibrosUiApp.Sale
 * @description
 * # saleFactory
 * Factory in the tusLibrosUiApp.
 */
angular.module('tusLibrosApp')
  .factory('Sale', ['$resource', 'backendUrl', function ($resource, backendUrl) {
    return $resource(backendUrl + '/purchases');
  }]);
