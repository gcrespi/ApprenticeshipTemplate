'use strict';

/**
 * @ngdoc service
 * @name tusLibrosFrontEnd.catalogFactory
 * @description
 * # catalogFactory
 * Factory in the tusLibrosFrontEnd.
 */
angular.module('tusLibrosApp')
  .factory('Book', ['$resource', 'backendUrl', function ($resource, backendUrl) {
    return $resource(backendUrl + '/books');
  }]);
