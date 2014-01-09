# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#todo list sort
jQuery ->
  $('#todo_items').sortable
    axis: 'y'
    handle: '.handle'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))

#todo list update
jQuery.fn.submitOnCheck = ->
  @find('input[type=submit]').remove()
  @find('input[type=checkbox]').click ->
    $(this).parent('form').submit()

jQuery ->
  $('.edit_market_todo_item').submitOnCheck()
