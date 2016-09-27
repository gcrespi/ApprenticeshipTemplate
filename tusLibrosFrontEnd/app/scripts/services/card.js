'use strict';

/**
 * @ngdoc service
 * @name tusLibrosApp.Card
 * @description
 * # Card
 * Service in the tusLibrosApp.
 */
angular.module('tusLibrosApp')
    .service('CardService', function () {
        this.card = {
            owner: '',
            number: '',
            expiration_date: {
                day: 1,
                month: null,
                year: null
            }
        };
    });
