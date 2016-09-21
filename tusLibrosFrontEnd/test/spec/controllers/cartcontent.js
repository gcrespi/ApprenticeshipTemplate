'use strict';

describe('Controller: CartcontentCtrl', function () {

  // load the controller's module
  beforeEach(module('tusLibrosApp'));

  var CartcontentCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    CartcontentCtrl = $controller('CartcontentCtrl', {
      $scope: scope
      // place here mocked dependencies
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(CartcontentCtrl.awesomeThings.length).toBe(3);
  });
});
