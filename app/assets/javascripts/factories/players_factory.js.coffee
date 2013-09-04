@app.factory "PlayersFactory", ($resource) ->
  $resource("players//:id.json", {id: "@id"}, {update: {method: 'PUT'}})