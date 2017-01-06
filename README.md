# UMass EMS Rails App

## Description

This was made to be a website with accounts for UMass EMS. It would allow users to log in and be assigned shifts. It would also allow directors to perform their duties like approving certificates and reading join applications. Unfortunately it never went into full production due to hosting costs. Instead an Angular App without accounts is now used, also developed by me. The current site is [www.umass.edu/ems](www.umass.edu/ems/#/home) and the repository is [here](https://github.com/morsecodist/umassemsapp). This is my first webapp and is not 100% complete because it never went into full production. Particularly the aesthetic is not in its final stage. Please visit [www.umass.edu/ems](www.umass.edu/ems/#/home), which has a more complete and polished aesthetic, to get a feel for how this web app would look in full production. 

The original repository had many more commits but some contained sensitive information so I started a new repository to display the code.

## Usage

If you wanted to build this you would need to set up a PostgreSQL database and fill in the information in `config/secrets.yml` and `config/database.yml`. You would also need to migrate and seed the database with a master user as per the schema.

## Features

### Accounts

User sessions. Flash message upon login failure. Passwords salted with bcrypt.

![login](/readme_images/login.png)

![rejected](/readme_images/login_fail.png)

![account page](/readme_images/user_page.png)

### User Roles

A master user can see every option.

![master](/readme_images/user_page.png)

The director of operations can see options related to shift creation.

![director of operations](/readme_images/role_do.png)

A regular user just sees the basic user options.

![normal user](/readme_images/role_pleb.png)

### Mobile Design

Not responsive design since it detects mobile browsers and uses different html and stylesheets. Uses a mobile menu on mobile that can be swiped out.

![mobie homepage](/readme_images/mobile.png)

![mobie menu](/readme_images/mobile_menu.png)



### File Upload

Users can upload files and access those files.

Upload a profile picture on the homepage.

![user page](/readme_images/user_page.png)

Privileged users can access uploaded certificates.

![cert approval](/readme_images/cert_red.png)

### Seamless Text Changes

Users can update fields with text areas dynamically appearing and disappearing for instant editing. All handled via AJAX so no need for page refresh.

![seamless before](/readme_images/seamless_before.png)

![seamless after](/readme_images/seamless_after.png)

### Date Picker

![date picker](/readme_images/datepicker.png)

### Form Autofill

Every previous entry becomes an autofill suggestion. Suggestions narrowed down while user types.

![autofill](/readme_images/autofill.png)

### Custom Forms and Data Display

Applicants fill out a custom join form.

![form](/readme_images/join_request.png)

Administrators can view form responses in a concise way customized to the data.

![join app](/readme_images/join_app.png)

Open for more data.

![join app open](/readme_images/join_app_open.png)

And approve immediately by clicking the checkmark.

![join app open green](/readme_images/join_app_open_green.png)

Administrators can view and approve uploaded certificates like driver's licenses in the same way.

![cert rejected](/readme_images/cert_red.png)

![cert approved](/readme_images/cert_green.png)
