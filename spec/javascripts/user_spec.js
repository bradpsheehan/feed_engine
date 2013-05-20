describe("User", function() {

  var user = null;

  beforeEach(function() {
    var attributes = {
      name: "Bob",
      imageURL: "http://example.com"

    };

    user = new RunLine.Entities.User(attributes);

  });

  it("has a name", function() {
    expect(user.name).toEqual("Bob");
  });

  it("has an imageURL", function() {
    expect(user.imageURL).toEqual("http://example.com");
  });

  it("has runs", function() {
    expect(user.runs).toEqual(jasmine.any(RunLine.Entities.Runs));
  });

  xit("has activites", function() {
    expect(user.feeds).toBeDefined();
  });


});
