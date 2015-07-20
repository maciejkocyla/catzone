# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  
  $('.cat_mark').click ->
    id = $(this).data('cat-id');
    $.ajax
      url: "add_sweetness/#{id}"
      type: "POST"
      dataType: "html"
      error: (jqXHR, textStatus, errorThrown) ->
        alert "AJAX Error: #{textStatus}"
      success: ->
        console.log id
        location.reload()
        

  $('.infinite-table').infinitePages
    # debug: true
    loading: ->
      $(this).text('Loading next page...')
    error: ->
      $(this).button('There was an error, please try again')