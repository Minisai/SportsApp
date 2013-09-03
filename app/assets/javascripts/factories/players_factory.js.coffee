@app.factory "PlayersFactory", ($resource) ->
  $resource("/players/:id", {id: "@id"}, {update: {method: 'PUT'}})