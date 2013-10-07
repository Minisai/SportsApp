@app.factory "DrillsFactory", ["$resource", ($resource) ->
  $resource("/drills/:id", {id: "@id"}, {update: {method: 'PUT'}})
]