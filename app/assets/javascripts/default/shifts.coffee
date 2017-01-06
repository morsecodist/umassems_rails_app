#This function determines the class to add to triple state shifts
determine_class = (box) ->
    answer = 'completed'
    box.find('input.one_assign').each () ->
        if $(this).val() == 'None'
            answer = 'failed'
    box.find('input.two_assign').each () ->
        if $(this).val() == 'None'
            answer = 'failed'
    if answer == 'failed'
        return 'failed'
    box.find('input.volunteer_assign').each () ->
        if $(this).val() == 'None'
            answer = 'pending'
    answer

#This function switches triple state classes
refresh_class = () ->
    $(this).closest('.full-shift-box').removeClass('completed pending failed', 'fast')
    $(this).closest('.full-shift-box').addClass(determine_class($(this).closest('.full-shift-box')), 'fast')

$ ->
    #This adds a datepicker to the shift creation form
    $('#shift_date').datepicker
        orientation: 'top'
    
    #This adds autocomplete functionality to venue on the shift creation form
    $('#shift_venue_name').autocomplete
        autoFocus: true
        source: (request, response) ->
            $.ajax
                url: "/member_portal/shift_management/venue_list.json"
                dataType: 'json'
                success: (data) ->
                    re = $.ui.autocomplete.escapeRegex(request.term)
                    matcher = new RegExp("^" + re, "i")
                    response($.grep(data, (item) -> matcher.test(item)))
        minLength: 1
        autoFill: true
    
    #This adds autocomplete functionality to event on the shift creation form
    $('#shift_event').autocomplete
        autoFocus: true
        source: (request, response) ->
            $.ajax
                url: "/member_portal/shift_management/event_list.json"
                dataType: 'json'
                success: (data) ->
                    re = $.ui.autocomplete.escapeRegex(request.term)
                    matcher = new RegExp("^" + re, "i")
                    response($.grep(data, (item) -> matcher.test(item)))
        minLength: 1
        autoFill: true
    
    #This adds a timepicker to the time on the shift creation form
    $('#time').timepicker
        timeFormat: 'H:i'
        step: 5
        className: 'bloop'
        
    #This adds autocomplete functionality to adding users to shifts
    $('.user_input').autocomplete
        autoFocus: true
        source: (request, response) ->
            $.ajax
                url: "/member_portal/shift_management/user_names_list.json"
                dataType: 'json'
                success: (data) ->
                    re = $.ui.autocomplete.escapeRegex(request.term)
                    matcher = new RegExp("^" + re, "i")
                    response($.grep(data, (item) -> matcher.test(item)))
        minLength: 1
        autoFill: true

#This allows the class to refresh on shifts, even ones that were just rendered
$(document).on 'submit', '.assign_shift', 
    refresh_class