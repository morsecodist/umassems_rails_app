#Opens and closes triple_state boxes
boxtoggler = (event) ->
    if event.target.nodeName != 'SPAN' && event.target.nodeName != 'INPUT'
        $(this).children('div.hidden').toggle();
    $('span').val(event.target.nodeName);
    
$ ->
    #Closes tripple_state boxes upon document load
    $('.hidden').hide();
    $('#clear').hide();
    
    #Removes notices when user clicks input
    $('input').click ->
        $('#notice').fadeOut(500)

#Triggers opening and closing of triple_state boxes
$(document).on 'click', '.triple_state',
    boxtoggler