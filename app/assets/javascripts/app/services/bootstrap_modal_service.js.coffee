@app.service "BootstrapModalService", ($q, $modal) ->
  modalPromise = (scope, modalName) ->
    $modal(
            template: "/assets/app/templates/dashboard/#{modalName}.html",
            persist: true,
            show: false,
            backdrop: 'static',
            scope: scope )

  @showModal = (scope, modalName)->
    $q.when(modalPromise(scope, modalName)).then (modalEl) ->
      eval("scope.#{modalName} = modalEl")
      modalEl.modal("show")