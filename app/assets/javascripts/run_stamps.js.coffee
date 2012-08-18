# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$("#startPress").click ->
  $("#run_stamp_timeStart").val ->
    return Math.round(new Date().getTime() / 1000)
  $("#runStatus").removeClass('stopButton').addClass('goButton')
  $("#startPress").hide()
  $("#stopPress").removeClass("hidden")
