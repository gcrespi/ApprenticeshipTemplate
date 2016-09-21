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
            return $http.get('http://localhost:3000/books')
                .then(function onSuccess(response) {
                    return response.data;
                });
        }
    });
