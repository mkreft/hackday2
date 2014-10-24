# @cjsx React.DOM

PageStore = require("../stores/PageStore")
Page = React.createClass(
  getInitialState: ->

    lessondict =
      3: 200
      6: 400
      9: 6000
      12: 8000
      15: 10000
      18: 12000
    
    @.initTimer()
    interval = 0
    lesson = 1
    treshold = 0
    capacity = 40
    days = 0
    hours = 0
    xp = 0
    xp = xp
    page = PageStore.getPageFromKey(@props.page or "/")
    page : page
    lesson : lesson
    lessondict: lessondict
    capacity : capacity
    xp : xp
    days : days
    hours : hours
    treshold : treshold

  initTimer:->
    setInterval(@.updateTick,500)

  lowerCapacity:(val)->
    if @state.capacity >= val and @canMakeLesson()
      @setState({capacity : @state.capacity-val})
      @addPoints(Math.floor(Math.random()*100))
      @addLesson()
    else
      if @canMakeLesson()
        console.log('take a rest dude!')
  canMakeLesson:->
    @checktreshold()
  
  addPoints:(num)->
    @setState({xp: @state.xp+num})

  checktreshold:()->
    console.log('@state.xp ' +@state.xp+ ' >? ' + @state.treshold)
    if @state.lessondict[@state.lesson]
      @state.treshold = @state.lessondict[@state.lesson]
    if (@state.xp >= @state.treshold) 
      return yes
    console.log('lesson locked: train dude!')
    return no
    
  addLesson:->
    #console.log(@state.lessondict[@state.lesson])
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
    <button onClick={@acomplishLesson}>
      make Lesson {@state.lesson}
    </button>

  trainerControl: ->
    <p>test</p>
    <button onClick={@acomplishTraining}>
      use trainer
    </button>

  render: ->
    page = @state.page
    capacity = @state.capacity
    xp = @state.xp
    days = @state.days
    hours = @state.hours
    <div id="pagebody">
      
        <h1>{page.name}</h1>
        <img src={page.logo} />
        <p>{days} days {hours} hours</p>
        <div>capacity: {capacity}</div>
        {@.lessonControl()}
        <p>Points : {xp}</p>
        {@.trainerControl()}
      

    </div>
)

module.exports = Page
 