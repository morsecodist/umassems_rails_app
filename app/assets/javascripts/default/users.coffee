$ ->
    #This handles updating the user bio on the profile page
    $('#update-bio').hide()
    $('#bioedit').click ->
        $('#self-bio').toggle()
        $('#update-bio').show()