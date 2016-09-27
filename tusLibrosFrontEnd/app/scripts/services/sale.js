'use strict';

/**
 * @ngdoc service
 * @name tusLibrosApp.sale
 * @description
 * # sale
 * Service in the tusLibrosApp.
 */
angular.module('tusLibrosApp')
  .service('SaleService', ['$http', 'backendUrl', function ($http, backendUrl) {
    this.getAllSales = function getAllSales() {
      return $http.get(backendUrl + '/purchases')
          .then(function onSuccess(response) {
            return response.data;
          });
    }
  }]);
