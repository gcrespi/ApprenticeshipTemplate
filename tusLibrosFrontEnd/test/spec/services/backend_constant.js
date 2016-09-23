'use strict';

describe('Service: BACKENDCONSTANT', function () {

  // load the service's module
  beforeEach(module('tusLibrosApp'));

  // instantiate service
  var BACKENDCONSTANT;
  beforeEach(inject(function (_BACKENDCONSTANT_) {
    BACKENDCONSTANT = _BACKENDCONSTANT_;
  }));

  it('should do something', function () {
    expect(!!BACKENDCONSTANT).toBe(true);
  });

});
