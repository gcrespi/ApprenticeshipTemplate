'use strict';

/**
 * @ngdoc service
 * @name tusLibrosApp.catalogService
 * @description
 * # catalog
 * Service in the tusLibrosApp.
 */
angular.module('tusLibrosApp')
    .service('catalogService', function ($http, $q) {
        this.getAllBooks = function getAllBooks() {
            return $http.get(backendUrl + '/books')
                .then(function onSuccess(response) {
                    return response.data;
                });
        }
    });
