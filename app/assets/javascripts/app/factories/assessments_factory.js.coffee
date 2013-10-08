@app.factory "AssessmentsFactory", ["$resource", ($resource) ->
  $resource("/coaches/assessments/:id", {id: "@id"}, {update: {method: 'PUT'}})
]