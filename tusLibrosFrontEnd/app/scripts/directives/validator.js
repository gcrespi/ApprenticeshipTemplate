'use strict';

/**
 * @ngdoc directive
 * @name tusLibrosApp.directive:validator
 * @description
 * # validator
 */
angular.module('tusLibrosApp')
    .directive('myValidator', function () {
        return {
            templateUrl: 'views/my-validator.html',
            restrict: 'E',
            transclude: true,
            scope: {
                'validated': '=',
                'validatedForm': '=',
                'myValidations': '='
            }
        };
    });
