describe "CreatePlanController", ->
  beforeEach ->
    module("sports-app")
  scope = null
  httpMock = null
  notification = {
    error: ->
    success: ->
  }
  drill = {id: 1, name: 'Drill'}
  planItems = [{item_type: 'PlanSession', days_attributes: [], name: 'Session 1'},
               {item_type: 'Reward', name: 'Reward 1'}, {item_type: 'Assessment', name: 'Assessment 1'}]
  days = [{exercises_attributes:[]}, {exercises_attributes: [{drill_id: 1, name: 'Drill', repetitions: 1}]}, {exercises_attributes:[]}]

  beforeEach inject(($rootScope, $controller, $httpBackend) ->
    scope = $rootScope.$new()
    $controller "CreatePlanController", $scope: scope, $notification: notification
    spyOn(notification, 'success')
    spyOn(notification, 'error')
    spyOn(window, 'confirm').andReturn(true)
    httpMock = $httpBackend
  )

  it "should initialize plan", ->
    expect(scope.plan).toEqual({})
  it "should initialize planItems", ->
    expect(scope.planItems).toEqual([])
  it "should initialize assessment", ->
    expect(scope.droppedDrill).toEqual({})

  describe 'methods testing', ->
    beforeEach ->
      scope.planItems =  JSON.parse(JSON.stringify(planItems))  #used for cloning object

    # For plan items
    describe 'addSessionClick', ->
      beforeEach ->
        scope.addSessionClick()
      it 'should add new session to scope.planItems', ->
        expect(scope.planItems).toEqual([ {item_type: 'PlanSession', days_attributes: [], name: 'Session 1'},
                                          {item_type: 'Reward', name: 'Reward 1'},
                                          {item_type: 'Assessment', name: 'Assessment 1'},
                                          {item_type: 'PlanSession', days_attributes: [], name: 'Session 2'} ])
    describe 'planItemSelection', ->
      describe 'when select 1 element', ->
        beforeEach ->
          scope.planItemSelection(scope.planItems[0])
        it 'selected should be true', ->
          expect(scope.planItems[0].selected).toBe(true)
      describe 'when select and unselect the element', ->
        beforeEach ->
          scope.planItemSelection(scope.planItems[0])
          scope.planItemSelection(scope.planItems[0])
        it 'selected should be false', ->
          expect(scope.planItems[0].selected).toBe(false)
      describe 'when select 1+ elements', ->
        beforeEach ->
          scope.planItemSelection(scope.planItems[0])
          scope.planItemSelection(scope.planItems[1])
        it 'selected of both should be true', ->
          expect(scope.planItems[0].selected).toBe(true)
          expect(scope.planItems[1].selected).toBe(true)

    describe 'planItemUpClick', ->
      describe 'valid index', ->
        beforeEach ->
          scope.planItemUpClick(1)
        it 'should change order', ->
          expect(scope.planItems).toEqual([ {item_type: 'Reward', name: 'Reward 1'},
                                            {item_type: 'PlanSession', days_attributes: [], name: 'Session 1'},
                                            {item_type: 'Assessment', name: 'Assessment 1'}])
      describe 'invalid index', ->
        beforeEach ->
          scope.planItemUpClick(0)
        it 'should not change order', ->
          expect(scope.planItems).toEqual(planItems)

    describe 'planItemDownClick', ->
      describe 'valid index', ->
        beforeEach ->
          scope.planItemDownClick(1)
        it 'should change order', ->
          expect(scope.planItems).toEqual([ {item_type: 'PlanSession', days_attributes: [], name: 'Session 1'},
                                            {item_type: 'Assessment', name: 'Assessment 1'},
                                            {item_type: 'Reward', name: 'Reward 1'}])
      describe 'invalid index', ->
        beforeEach ->
          scope.planItemDownClick(scope.planItems.length)
        it 'should not change order', ->
          expect(scope.planItems).toEqual(planItems)

    describe 'planItemRemoveClick', ->
      beforeEach ->
        scope.planItemRemoveClick(0)
      it 'should remove plan_item', ->
        expect(scope.planItems).toEqual([ {item_type: 'Reward', name: 'Reward 1'},
                                          {item_type: 'Assessment', name: 'Assessment 1'}])

    # For days
    describe 'days functionality', ->
      beforeEach ->
        scope.planItems[0].days_attributes = JSON.parse(JSON.stringify(days))
      describe 'addDayClick', ->
        describe "plan_item == 'planSession'", ->
          beforeEach ->
            scope.addDayClick(scope.planItems[0])
          it 'should add day', ->
            expect(scope.planItems[0].days_attributes).toEqual([{exercises_attributes:[]},
                                                                {exercises_attributes: [{drill_id: 1, name: 'Drill', repetitions: 1}]},
                                                                {exercises_attributes: []}, {exercises_attributes:[]}])
        describe "plan_item != 'planSession'", ->
          beforeEach ->
            scope.addDayClick(scope.planItems[1])
          it 'should add day', ->
            expect(scope.planItems[1].days_attributes).toBeUndefined()

      describe 'daySelection', ->
        describe 'when select 1 element', ->
          beforeEach ->
            scope.daySelection(scope.planItems[0].days_attributes[0])
          it 'selected should be true', ->
            expect(scope.planItems[0].days_attributes[0].selected).toBe(true)
        describe 'when select and unselect the element', ->
          beforeEach ->
            scope.planItemSelection(scope.planItems[0].days_attributes[0])
            scope.planItemSelection(scope.planItems[0].days_attributes[0])
          it 'selected should be false', ->
            expect(scope.planItems[0].days_attributes[0].selected).toBe(false)
        describe 'when select 1+ elements', ->
          beforeEach ->
            scope.planItemSelection(scope.planItems[0].days_attributes[0])
            scope.planItemSelection(scope.planItems[0].days_attributes[1])
          it 'selected of both should be true', ->
            expect(scope.planItems[0].days_attributes[0].selected).toBe(true)
            expect(scope.planItems[0].days_attributes[1].selected).toBe(true)

      describe 'dayUpClick', ->
        describe 'valid index', ->
          beforeEach ->
            scope.dayUpClick(scope.planItems[0], 1)
          it 'should change order', ->
            expect(scope.planItems[0].days_attributes).toEqual([ {exercises_attributes: [{drill_id: 1, name: 'Drill', repetitions: 1}]},
                                                                 {exercises_attributes:[]}, {exercises_attributes:[]}])
        describe 'invalid index', ->
          beforeEach ->
            scope.dayUpClick(scope.planItems[0], 0)
          it 'should not change order', ->
            expect(scope.planItems[0].days_attributes).toEqual(days)

      describe 'dayDownClick', ->
        describe 'valid index', ->
          beforeEach ->
            scope.dayDownClick(scope.planItems[0], 1)
          it 'should change order', ->
            expect(scope.planItems[0].days_attributes).toEqual([ {exercises_attributes:[]}, {exercises_attributes:[]},
                                                                 {exercises_attributes: [{drill_id: 1, name: 'Drill', repetitions: 1}]}])
        describe 'invalid index', ->
          beforeEach ->
            scope.dayDownClick(scope.planItems[0], scope.planItems[0].days_attributes.length)
          it 'should not change order', ->
            expect(scope.planItems[0].days_attributes).toEqual(days)

      describe 'dayRemoveClick', ->
        beforeEach ->
          scope.dayRemoveClick(scope.planItems[0], 2)
        it 'should remove plan_item', ->
          expect(scope.planItems[0].days_attributes).toEqual([ {exercises_attributes:[]},
                                                               {exercises_attributes: [{drill_id: 1, name: 'Drill', repetitions: 1}]}])

    # For drills
    describe 'drillSelection', ->
      beforeEach ->
        scope.drillSelection(drill)
      it 'should assign drill data to selectedDrill', ->
        expect(scope.selectedDrill).toEqual(drill)

    describe 'dragDrillHandler', ->
      beforeEach ->
        scope.dragDrillHandler(null, null, drill)
      it 'should assign passed drill to draggedDrill', ->
        expect(scope.draggedDrill).toEqual(drill)

    describe 'dropDrillHandler', ->
      beforeEach ->
        scope.draggedDrill = drill
        scope.planItems = [{days_attributes: [{exercises_attributes:[]}]}]
        scope.dropDrillHandler(null, null, 0, 0)
      it 'should add exercise with draggedDrill', ->
        expect(scope.planItems[0].days_attributes[0].exercises_attributes).toEqual([{drill_id: scope.draggedDrill.id, name: scope.draggedDrill.name, repetitions: 1}])

    describe 'removeDrillClick', ->
      beforeEach ->
        scope.planItems = [{days_attributes: [{exercises_attributes:[
          {drill_id: 1, name: 'Drill 1', repetitions: 1},
          {drill_id: 2, name: 'Drill 2', repetitions: 1},
          {drill_id: 3, name: 'Drill 3', repetitions: 1}] }]}]
        scope.removeDrillClick(scope.planItems[0].days_attributes[0], 1)
      it 'should remove exercise from scope.exercises by index', ->
        expect(scope.planItems[0].days_attributes[0].exercises_attributes).toEqual([
          {drill_id: 1, name: 'Drill 1', repetitions: 1},
          {drill_id: 3, name: 'Drill 3', repetitions: 1}])

    # For plan
    describe 'createPlan', ->
      describe 'success request mock', ->
        beforeEach ->
          httpMock.whenPOST("/coaches/plans").respond(message: "Plan was created successfully")
          scope.createPlan()
          httpMock.flush()

        it 'should clear form', ->
          expect(scope.plan).toEqual({})
          expect(scope.planItems).toEqual([])

        it 'should show success notifcation', ->
          expect(notification.success).toHaveBeenCalled();

      describe 'failed request mock', ->
        beforeEach ->
          httpMock.whenPOST("/coaches/plans").respond(403, message: 'error')
          scope.createPlan()
          httpMock.flush()

        it 'should show error notifcation', ->
          expect(notification.error).toHaveBeenCalled();