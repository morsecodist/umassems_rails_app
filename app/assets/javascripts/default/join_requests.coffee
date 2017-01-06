$ ->
    #This is for the form
    $('#new_join_submit').click ->
        if $('#join_request_cert_source_other').is(':checked')
            $('#join_request_cert_source_other').val($('#join_request_cert_source_input').val())
        if $('#join_request_career_goal_other').is(':checked')
            $('#join_request_career_goal_other').val($('#join_request_career_goal_input').val())
    $('#join_request_cert_source_input').click ->
        $('#join_request_cert_source_other').prop('checked', true)
        $(this).removeClass("greytext")
    $('#join_request_career_goal_input').click ->
        $('#join_request_career_goal_other').prop('checked', true)
        $(this).removeClass('greytext')

    $(document).click ->
        if !$('#join_request_cert_source_other').is(':checked')
            $('#join_request_cert_source_input').addClass('greytext')
        else 
            $('#join_request_cert_source_input').removeClass('greytext')
            
        if !$('#join_request_career_goal_other').is(':checked')
            $('#join_request_career_goal_input').addClass('greytext')
        else
            $('#join_request_career_goal_input').removeClass('greytext')

        if $('#join_request_none').is(':checked')
            $('div.not_none input').attr('disabled', true).attr('checked', false)
        else
            $('div.not_none input').removeAttr('disabled')

    #This is for the index
    $('#processed_requests').hide()

    $('#processed_button').click ->
        $('#processed_button').addClass('selected')
        $('#pending_button').removeClass('selected')
        $('#pending_requests').hide()
        $('#processed_requests').show()
        $('.hidden').hide()

    $('#pending_button').click ->
        $('#processed_button').removeClass('selected')
        $('#pending_button').addClass('selected')
        $('#pending_requests').show()
        $('#processed_requests').hide()
        $('.hidden').hide()