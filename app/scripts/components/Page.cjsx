# @cjsx React.DOM

PageStore = require("../stores/PageStore")
Page = React.createClass(
  getInitialState: ->
    @.initTimer()
    interval = 0
    lesson = 1
    capacity = 40
    days = 0
    hours = 0
    xp = 0
    xp = xp
    page = PageStore.getPageFromKey(@props.page or "/")
    page : page
    lesson : lesson
    capacity : capacity
    xp : xp
    days : days
    hours : hours

  initTimer:->
    setInterval(@.updateTick,500)

  lowerCapacity:(val)->
    if @state.capacity >= val
      @setState({capacity : @state.capacity-val})
      @addLesson()
      @addPoints(Math.floor(Math.random()*100))
    else
      console.log('take a rest dude!')

  addPoints:(num)->
    @setState({xp: @state.xp+num})

  addLesson:->
    @setState({lesson : @state.lesson+1})

  acomplishLesson:->
    
    @lowerCapacity(Math.floor(Math.random()*20)+10);
  acomplishTraining:->
    @addPoints(Math.floor(Math.random()*@state.lesson*2.3))
    
  addHour:->
    if @state.hours < 24
      @setState({hours : @state.hours+1})
    else
      @setState({days : @state.days+1})
      @setState({hours : 0})


  updateTick:->
    @addHour()
    #console.log("tick")
    if @state.capacity < 40
      @setState({capacity : @state.capacity+1})

# Buttons

  lessonControl: ->
    <p>test</p>
    <button onClick={@acomplishLesson}>
      make Lesson {@state.lesson}
    </button>

  trainerControl: ->
    <p>test</p>
    <button onClick={@acomplishTraining}>
      Trainig
    </button>

  render: ->
    page = @state.page
    capacity = @state.capacity
    xp = @state.xp
    days = @state.days
    hours = @state.hours
    <div id="pagebody">
      
        <h1>{page.name} </h1>
        <img src={page.logo} />
        <p>{days} days {hours} hours</p>
        <div>capacity: {capacity}</div>
        {@.lessonControl()}
        <p>Points : {xp}</p>
        {@.trainerControl()}
      

    </div>
)

module.exports = Page
 