_pages = "/":
  key: "/"
  name: "Learn Behavior Guide"
  link: "http://facebook.github.io/react"
  logo: "images/Babbel_logo.png"
  logo2: "images/react.png"

PageStore =
  getPageFromKey: (key) ->
    return null  unless _pages.hasOwnProperty(key)
    _pages[key]

  getAll: ->
    _pages

module.exports = PageStore
