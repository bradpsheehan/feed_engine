describe("Route", function() {

  var route = null;

  beforeEach(function() {
    var attributes = {
      id: "1"
    };

    route = new RunLine.Entities.Route(attributes);

  });

  it("has an id", function() {
    expect(route.id).toEqual(1)
  });

  it("has points", function() {
    expect(route.points).toEqual(jasmine.any(RunLine.Entities.Points));
  });


});
