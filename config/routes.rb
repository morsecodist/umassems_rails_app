Rails.application.routes.draw do

    #Homepage
    root 'static_pages#home'

    #static pages
    get '/staff' => 'static_pages#staff_info'
    get '/about' => 'static_pages#about_info'
    #get '/class_info' => 'static_pages#class_info'
    get '/website' => 'static_pages#website_info'
    get '/cpr' => 'static_pages#cpr_info'
    get '/join_info' => 'static_pages#join_info'
    get '/download_registration_form' => 'static_pages#download_registration_form'
    get '/download_charter' => 'static_pages#download_charter'
    get '/download_cpr_schedule' => 'static_pages#download_cpr_schedule'
    get '/member_portal/itl' => 'static_pages#itl'
    put '/member_portal/itl' => 'static_pages#classtoggle', as: :classtoggle

    #sessions
    get '/member_portal/login' => 'sessions#new'
    post '/member_portal/login' => 'sessions#create'
    get '/member_portal/logout' => 'sessions#destroy'

    #members
    get '/member_portal/users/signup' => 'users#new'
    post '/member_portal/users' => 'users#create'
    get '/member_portal/users/:id' => 'users#show', as: :user_page
    get '/member_portal/users/:id/shifts' => 'users#shifts', as: :user_shifts
    get '/member_portal/users/:id/certs' => 'users#certs', as: :user_certs
    get '/member_portal/users/:id/account_settings' => 'users#account_settings', as: :account_settings
    patch '/member_portal/users/:id/update_bio' => 'users#update_bio', as: :update_user_bio
    patch '/member_portal/users/:id/update_photo' => 'users#update_photo', as: :update_user_photo
    patch 'member_portal/users/:id/update_password' => 'users#update_password', as: :update_password

    #shifts
    resources :shifts
    get '/member_portal/shift_management' => 'shifts#index'
    get '/member_portal/shift_archive' => 'shifts#archive'
    patch '/member_portal/shift_management/:id/assign_one' => 'shifts#assign_one', as: :assign_one
    patch '/member_portal/shift_management/:id/assign_two' => 'shifts#assign_two', as: :assign_two
    patch '/member_portal/shift_management/:id/assign_volunteer' => 'shifts#assign_volunteer', as: :assign_volunteer

    #Join requests
    get '/join_info/apply' => 'join_requests#new'
    post '/join_info/apply' => 'join_requests#create', as: :join_requests
    patch '/member_portal/join_requests/accept/:id' => 'join_requests#accept', as: :accept_request
    patch '/member_portal/join_requests/reject/:id' => 'join_requests#reject', as: :reject_request
    get '/member_portal/join_requests' => 'join_requests#index'
    get '/join_request_success' => 'join_requests#form_complete'

    #Autocomplete json
    get '/member_portal/shift_management/venue_list.json' => 'shifts#shifts_venue_autocomplete'
    get '/member_portal/shift_management/event_list.json' => 'shifts#shifts_event_autocomplete'
    get '/member_portal/shift_management/user_names_list.json' => 'users#user_names_autocomplete'

    #Certificates
    patch '/member_portal/certs/:id' => 'certificates#upload', as: :upload_cert
    get '/member_portal/certs' => 'certificates#index'
    patch '/member_portal/certs/accept/:id' => 'certificates#accept_cert', as: :accept_cert
    patch '/member_portal/certs/reject/:id' => 'certificates#reject_cert', as: :reject_cert

    #Approved Accounts
    get '/member_portal/add_members' => 'approved_accounts#index'
    post '/member_portal/add_members' => 'approved_accounts#create'
    patch 'member_portal/delete_approved_account/:id' => 'approved_accounts#destroy', as: :delete_approved_account

end
