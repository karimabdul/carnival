class CommentForm
  constructor: (@thread) ->
    @createElement()
    @bindEvents()

  createElement: ->
    @element = document.createElement('li')
    @element.id = 'comment-form'
    @element.className = 'comment-form'
    @element.innerHTML = "<a><span>+</span> Leave a note</a><form><div class='author'><img src=''><span></span></div><textarea placeholder='Leave a note' class='body'></textarea><input type='submit' value='Save'></form>"

  body: ->
    @element.querySelector('.body').value

  resizeTextarea: ->
    if @scrollHeight > @clientHeight
      @style.height = @scrollHeight + "px"

  bindEvents: ->
    @element.querySelector('textarea').addEventListener 'keyup', @resizeTextarea
    @element.addEventListener 'submit', (event) =>
      event.preventDefault()
      event.stopPropagation()
      @thread.add(@body())
      @element.querySelector('.body').value = ''
    @element.querySelector('a').addEventListener 'click', (event) =>
      event.preventDefault()
      event.stopPropagation()
      if Carnival.isLoggedIn()
        @showCommentForm()
      else
        Carnival.login()
    document.addEventListener 'hasLoggedIn', =>
      @showCommentForm()

  showCommentForm: ->
    @element.querySelector('a').style.display = 'none'
    @element.querySelector('form').style.display = 'block'
    @element.querySelector('.author span').innerHTML = Carnival.userName()
    @element.querySelector('.author img').src = Carnival.userGravatarUrl()
