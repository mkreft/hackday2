# @cjsx React.DOM

PageStore = require("../stores/PageStore")
Page = React.createClass(
  getInitialState: ->

    lessondict =
      3: 150
      6: 300
      9: 600
      12: 850
      15: 1200
      18: 1400
    
    @.initTimer()
    interval = 0
    lesson = 1
    treshold = 0
    capacity = 40
    days = 0
    lastday = 0
    hours = 0
    xp = 0
    xp = xp
    output = "welcome, NEO"
    page = PageStore.getPageFromKey(@props.page or "/")
    page : page
    lesson : lesson
    lessondict: lessondict
    capacity : capacity
    xp : xp
    days : days
    hours : hours
    treshold : treshold
    output : output
    lastday : lastday

  initTimer:->
    setInterval(@.updateTick,300)
    setInterval(@.moveBar,300)
  moveBar:()->

    $('.progress-wrap').data('progress-percent', @state.capacity*2.5)
    moveProgressBar()
    if @state.capacity >= 15 and @canMakeLesson()
      @enableLessonBtn()
  lowerCapacity:(val)->
    if @state.capacity >= val and @canMakeLesson()
      @setState({capacity : @state.capacity-val})
      @moveBar()
      @addPoints(Math.floor(Math.random()*100))
      @addLesson()
      @makeoutput('well done')
    else
      if @canMakeLesson()
        @disableLessonBtn()
        @makeoutput('take a rest dude!')
  canMakeLesson:->
    @checktreshold()

  enableLessonBtn:->
    $('#lessonbtn').removeClass('disabled');
    $('#lessonbtn').attr("disabled", false);


  disableLessonBtn:->
    $('#lessonbtn').addClass('disabled');
    $('#lessonbtn').attr("disabled", true);
  
  addPoints:(num)->
    @setState({xp: @state.xp+num})
    @setState({lastday: @state.days})
    #check last day you added points


  makeoutput:(out)->
    @setState({output : out})


  checktreshold:()->
    #@makeoutput('@state.xp ' +@state.xp+ ' >? ' + @state.treshold)
    if @state.lessondict[@state.lesson]
      @state.treshold = @state.lessondict[@state.lesson]
    if (@state.xp >= @state.treshold) 
      return yes
    @makeoutput('lesson locked: train dude! You need ' +  @state.treshold + " points")
    @disableLessonBtn()
    #@makeoutput('lesson locked: train dude!')
    return no
    
  addLesson:->
    #@makeoutput(@state.lessondict[@state.lesson])
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
      if @state.days-@state.lastday > 1
        @makeoutput("You're #{@state.days-@state.lastday} day away. Please, come back!")


  updateTick:->
    @addHour()
    #@makeoutput("tick")
    if @state.capacity < 40
      @setState({capacity : @state.capacity+1})


# Buttons

  lessonControl: ->
    <button className="myButton" id="lessonbtn" onClick={@acomplishLesson}>
      do Lesson {@state.lesson}
    </button>




  trainerControl: ->
    <p>test</p>
    <button className="myButton" onClick={@acomplishTraining}>
      review learned stuff
    </button>

  # progressbar:->
  #   <div class="progress progress-bar"/></div>
  #   <div id="my-progressbar">

  render: ->
    page = @state.page
    capacity = @state.capacity
    xp = @state.xp
    days = @state.days
    hours = @state.hours
    output = @state.output
    <div id="pagebody">
      <img id="logo" src={page.logo} />
      <img id="logo2" src={page.logo2} />
        <h1>{page.name}</h1>
        
        <h2>{days} days {hours} hours</h2>
        <div className="progress-wrap progress" data-progress-percent={capacity*2.5}><div className="progress progress-bar"/></div>
        <h2>points : {xp}</h2>
        {@.lessonControl()}
        {@.trainerControl()}

        <div id="userconsole">
          {output}
        </div>
      

    </div>
)

module.exports = Page