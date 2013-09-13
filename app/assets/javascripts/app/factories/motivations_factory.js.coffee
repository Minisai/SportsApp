@app.factory "MotivationsFactory", ["$resource", ($resource) ->
  $resource("motivations", {id: "@id"}, {update: {method: 'PUT'}})
]