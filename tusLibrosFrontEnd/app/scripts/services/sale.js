'use strict';

/**
 * @ngdoc service
 * @name tusLibrosApp.sale
 * @description
 * # sale
 * Service in the tusLibrosApp.
 */
angular.module('tusLibrosApp')
    .service('SaleService', ['backendUrl', 'Sale', function (backendUrl, Sale) {
        this.getAllSales = function getAllSales() {
            return Sale.query().$promise;
        }
    }]);
