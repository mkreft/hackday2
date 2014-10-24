# @cjsx React.DOM

PageStore = require("../stores/PageStore")
Page = React.createClass(
  getInitialState: ->
    @.initTimer()
    interval = 0
    capacity = 0
    page = PageStore.getPageFromKey(@props.page or "/")
    page : page
    capacity : capacity

  initTimer:->
    setInterval(@.updateTick,100)

  acomplishLesson:->
    console.log('0')
    @setState({capacity : 0})

  updateTick:->
    #console.log("tick")
    if @state.capacity < 40
      @setState({capacity : @state.capacity+1})

  lessonControl: ->
    <p>test</p>
    <button onClick={@acomplishLesson}>
      CLICK ME
    </button>

  render: ->
    page = @state.page
    capacity = @state.capacity
    <div id="pagebody">
      
        <h1>{page.name} </h1>
        <img src={page.logo} />
        <div>capacity: {capacity}</div>
        
        {@.lessonControl()}
      

    </div>
)

module.exports = Page
 