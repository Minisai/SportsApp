@app.service "BootstrapModalService", ["$q", "$modal", ($q, $modal) ->
  modalPromise = (scope, modalName) ->
    $modal(
            template: "/angular/templates/#{modalName}.html",
            persist: true,
            show: false,
            backdrop: 'static',
            scope: scope )

  @showModal = (scope, modalName)->
    $q.when(modalPromise(scope, modalName)).then (modalEl) ->
      scope[modalName] = modalEl
      modalEl.modal("show")
]