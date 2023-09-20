*** Settings ***
Resource    main_keywords.robot
Resource    ../variables/variables.robot
Library  SeleniumLibrary
Variables    ../page_objects/sign_in_window_locators.py

*** Keywords ***
login_Service
    click element    ${sign_in_button}
    input text  ${email_input_field}    0986838080
    input text  ${password_input_field}    Btim69
    click element    //label[contains(@class,'remember-checkbox')]
    click element    ${login_button}
    select frame    //*[@title='reCAPTCHA']
    click element    //span[@id='recaptcha-anchor']
    Sleep  40s