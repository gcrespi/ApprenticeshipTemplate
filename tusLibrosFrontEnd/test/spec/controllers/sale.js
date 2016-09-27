'use strict';

describe('Controller: SaleCtrl', function () {

  // load the controller's module
  beforeEach(module('tusLibrosApp'));

  var SaleCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    SaleCtrl = $controller('SaleCtrl', {
      $scope: scope
      // place here mocked dependencies
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(SaleCtrl.awesomeThings.length).toBe(3);
  });
});
