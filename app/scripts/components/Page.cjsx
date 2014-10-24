# @cjsx React.DOM

PageStore = require("../stores/PageStore")
Page = React.createClass(
  getInitialState: ->
    @.initTimer()
    interval = 0
    seconds = 0
    page = PageStore.getPageFromKey(@props.page or "/")
    page : page
    seconds : seconds

  initTimer:->
    setInterval(@.updateTick,1000)

  updateTick:->
    #console.log("tick")
    @setState({seconds : @state.seconds+1})

  foo: ->
    
    <div>ff
      <p>nice</p>
    </div>

  render: ->
    page = @state.page
    seconds = @state.seconds
    <div>
      <a href={page.link}>
        <h1>{page.name}</h1>
        <img src={page.logo} />
        <div>Timer</div>
        <p>{seconds}</p>
        {@.foo()}

      </a>

    </div>
)

module.exports = Page
