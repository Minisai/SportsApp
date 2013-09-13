@app.factory "MotivationsFactory", ($resource) ->
  $resource("motivations", {id: "@id"}, {update: {method: 'PUT'}})