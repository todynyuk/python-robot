*** Settings ***
Library  SeleniumLibrary
Resource    ../../keywords/search_keywords.robot
Resource    ../../keywords/main_keywords.robot
Resource    ../../keywords/utils.robot
Resource    ../../variables/variables.robot
Variables    ../../page_objects/sign_in_window_locators.py
Variables    ../../page_objects/burger_menu_locators.py

*** Variables ***
#${browser}  chrome
#${url}  https://rozetka.com.ua/ua/
${correctSearch}    AGM A9
${incorrectSearch}  jhvjhjhjhv

*** Test Cases ***
CorrectSearchTest
    [Tags]  maintainer=todynyuk
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    inputSearchField  ${correctSearch}
    clickSearchButton
    verifySearchTitle   ${correctSearch}
    verifyProductTitle  ${correctSearch}
    [Teardown]  close browser

IncorrectSearchTest
    [Tags]  maintainer=todynyuk
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    inputSearchField  ${incorrectSearch}
    clickSearchButton
    verifyNotFoundText
    [Teardown]  close browser

LoginTest
    [Tags]  Login
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
#    click_some_element   ${sign_in_button}
#    input text  ${email_input_field}    0986838080
#    input text  ${password_input_field}    Btim69
#    click element    //label[contains(@class,'remember-checkbox')]
#    click_some_element    ${login_button}
    login_Service
#    select frame    //*[@title='reCAPTCHA']
#    click element    //span[@id='recaptcha-anchor']
#    Sleep  30s
#    click_some_element    ${login_button}
    click_some_element    ${burger_menu}
    page should contain element    //span[contains(@class,'user-name')]

Incorrect_Login_Test
    [Tags]  IncorrectLogin
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_some_element   ${sign_in_button}
    input text  ${email_input_field}    " "
    input text    ${password_input_field}    12345
    ELEMENT SHOULD BE ENABLED    //p[contains(@class,'error-message')]

BurgerMenuTest
    [Tags]  BurgerMenu
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
#    ${main_language_text}   get text    //span[contains(@class,'lang__link--active')]
    ${main_language_text}   get text    ${active_language_text}
#    sleep    50s
    click element  ${burger_menu}
#    ${burger_menu_language_text}    get text    //span[contains(@class,'lang__link--active')]
    ${burger_menu_language_text}    get text    ${active_language_text}
    should be equal    ${main_language_text}     ${burger_menu_language_text}

BurgerMenuLoginTest
    [Tags]  BurgerMenuElements
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    login_Service
    click element  ${burger_menu}
    element should be enabled    ${my_orders}
    element should be enabled    ${take_orders}


ServiceCentersTest
    [Tags]  ServiceCenters
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click element    ${service_centers_link}
    click element    (//a[contains(@href,'bosch')])
    click element    (//a[@class='service-list__link'])[1]
    click element    //a[contains(text(),'Львів')]
    element should be enabled    //li[contains(@class,'service-info__item')]
    element should be enabled    //div[@class='modal-map__map']