@app.factory "MotivationsFactory", ($resource) ->
  $resource("motivations.json", {id: "@id"}, {update: {method: 'PUT'}})