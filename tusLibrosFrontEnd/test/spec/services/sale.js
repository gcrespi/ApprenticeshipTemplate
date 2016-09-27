'use strict';

describe('Service: sale', function () {

  // load the service's module
  beforeEach(module('tusLibrosApp'));

  // instantiate service
  var sale;
  beforeEach(inject(function (_sale_) {
    sale = _sale_;
  }));

  it('should do something', function () {
    expect(!!sale).toBe(true);
  });

});
