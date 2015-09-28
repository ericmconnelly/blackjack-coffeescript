class window.GameModelView extends Backbone.View
  template: _.template '
    <div class="gamearea">
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button><button class="retry-button">RePlay</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    </div>
    '
  messageTemplate: _.template '
    <div>
    <div class = "gameMessage <%= cl %>"><%= message %>
    </div>
    <button class = "retry-button">Play Again?
    </button>
    </div>
    '

  # loseTemplate: _.template '
  #   <div class ="gameLose">
  #   <div class ="gameMessage loseMessage">YOU 
  #   </div>
  #   <button class = "retry-button">Play Again?</button>
  #   </div>
  #   '

  # templateWin: _.template '<div class="newGameWin zoomIn animated"> 
  #                         <div class="gameMessage winMessage">
  #                         </div>
  #                         <button class="retry-button">Play Again?</button>
  #                         </div>'

  # templateLose: _.template '<div class="newGameLose zoomIn animated"> 
  #                         <div class="gameMessage loseMessage">
  #                         </div>
  #                         <button class="retry-button">Play Again?</button>
  #                       </div>'

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> 
      @model.get('playerHand').stand()
      @trigger "stand"

  initialize: ->
    @model.on 'win', @renderWinMessage, @
    @model.on 'lose', @renderLoseMessage, @
    @model.on 'replay', @render, @
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderWinMessage: ->
    console.log 'i win!'
    $('.hit-button').prop('disabled', true)
    $('.stand-button').prop('disabled', true)
    #$('#gameMessage').addClass('winMessage')
    @$el.prepend(@messageTemplate({message: "YOU WIN!", cl:'winMessage'}))

  renderLoseMessage: ->
    ('.hit-button').prop('disabled', true)
    ('.stand-button').prop('disabled', true)
    @$el.prepend(@messageTemplate({message: "YOU LOSE!", cl:'loseMessage'}))

  # renderWin: ->
  #   console.log('win!!!')
  #   $('.hit-button').prop('disabled', true)
  #   $('.stand-button').prop('disabled', true)
  #   @$el.prepend(@templateWin)

  # renderLose: =>
  #   console.log('loose!!')
  #   $('.hit-button').prop('disabled', true)
  #   $('.stand-button').prop('disabled', true)
  #   @$el.prepend @templateLose()


 

