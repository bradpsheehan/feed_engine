describe('Run', function() {

  var run = null;

  beforeEach(function() {
    var attributes = {
      group_name: "My Run",
      time: "10:54 AM",
      date: "2009-12-18",
      details: "These are the run details",
      friends: "",
      routeId: "1",
    };

    run = new RunLine.Entities.Run(attributes);
  });

  it("has a groupName", function() {
    expect(run.groupName).toBe("My Run");

  });

  it("has a date", function() {
    expect(run.date).toBe("2009-12-18");

  });

  it("has a time", function() {
    expect(run.time).toBe("10:54 AM");

  });

  it("has details", function() {
    expect(run.details, "These are the run details");
  });

  it("has runners", function() {
    expect(run.runners).toEqual(jasmine.any(RunLine.Entities.Users));
  });

  it("has a routeId", function() {
    expect(run.routeId).toEqual(1);
  });

  it("has a route", function() {
    expect(run.route).toEqual(jasmine.any(RunLine.Entities.Route));
  });

});
