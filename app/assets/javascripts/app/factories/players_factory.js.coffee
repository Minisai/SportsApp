@app.factory "PlayersFactory", ["$resource", ($resource) ->
  $resource("/coaches/players/:id", {id: "@id"}, {update: {method: 'PUT'}})
]