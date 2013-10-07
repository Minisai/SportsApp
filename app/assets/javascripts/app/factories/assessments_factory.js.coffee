@app.factory "AssessmentsFactory", ["$resource", ($resource) ->
  $resource("../assessments/:id", {id: "@id"}, {update: {method: 'PUT'}})
]