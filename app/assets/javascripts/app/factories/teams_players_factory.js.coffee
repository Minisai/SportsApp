@app.factory "TeamsPlayersFactory", ["$resource", ($resource) ->
  $resource("/coaches/teams/:team_id/players/:id", {team_id: "@team_id", id: "@id"}, {update: {method: 'PUT'}})
]