# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$("#startPress").click ->
  if $("#run_stamp_jobNumber").val() == ""
    alert "Can not start with a blank Job Number"
  else
    $("#run_stamp_timeStart").val ->
      return Math.round(new Date().getTime() / 1000)
    $("#runStatus").removeClass('stopButton').addClass('goButton')
    $("#startPress").hide()
    $("#stopPress").removeClass("hidden")
    $("#reason_text").removeClass("hidden")
    $("#run_stamp_reason").removeClass("hidden")
