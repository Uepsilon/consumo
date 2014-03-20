$ ->
  $('[data-behaviour=format-number]').blur ->
    $(this).val($(this).val().replace(',', '.'))