'use strict';

describe('Service: catalogFactory', function () {

  // load the service's module
  beforeEach(module('tusLibrosFrontEnd'));

  // instantiate service
  var catalogFactory;
  beforeEach(inject(function (_catalogFactory_) {
    catalogFactory = _catalogFactory_;
  }));

  it('should do something', function () {
    expect(!!catalogFactory).toBe(true);
  });

});
