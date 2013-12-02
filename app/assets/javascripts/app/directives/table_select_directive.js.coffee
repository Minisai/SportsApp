@app.directive "tableSelect", ->
  replace: false
  templateUrl: "/angular/templates/table_select.html"
  scope:
    items: "="
    selected: "="
    itemType: "="
    planItems: "="
  link: (scope) ->
    scope.selectItem = ->
      scope.selectedPlanItem.item_type = scope.itemType
      scope.planItems.push(scope.selectedPlanItem)
      scope.selectedPlanItem = null