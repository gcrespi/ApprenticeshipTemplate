'use strict';

/**
 * @ngdoc function
 * @name tusLibrosApp.controller:SaleCtrl
 * @description
 * # SaleCtrl
 * Controller of the tusLibrosApp
 */
angular.module('tusLibrosApp')
    .controller('SaleCtrl', ['$location', '$scope', 'SaleService', function ($location, $scope, SaleService) {
        SaleService.getAllSales().then(function (sales) {
            $scope.sales = sales;
        }).catch(function (response) {
            alert(response.data.error);
        });
    }]);
