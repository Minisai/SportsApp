@app.factory "TeamsFactory", ($resource) ->
  $resource("teams//:id", {id: "@id"}, {update: {method: 'PUT'}})