'use strict';

describe('Service: saleFactory', function () {

  // load the service's module
  beforeEach(module('tusLibrosApp'));

  // instantiate service
  var saleFactory;
  beforeEach(inject(function (_saleFactory_) {
    saleFactory = _saleFactory_;
  }));

  it('should do something', function () {
    expect(!!saleFactory).toBe(true);
  });

});
