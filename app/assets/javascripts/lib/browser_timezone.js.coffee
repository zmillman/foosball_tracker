# Sets a timezone offset cookie which is used by the BrowserTimezone module
$ ->
  $.cookie "tzoffset", (new Date()).getTimezoneOffset()
