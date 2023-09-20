*** Settings ***
Library  SeleniumLibrary
Resource    ../../keywords/search_keywords.robot
Resource    ../../keywords/main_keywords.robot
Resource    ../../keywords/destination_city_keywords.robot
Resource    ../../keywords/utils.robot
Resource    ../../variables/variables.robot
Variables    ../../page_objects/sign_in_window_locators.py
Variables    ../../page_objects/burger_menu_locators.py
Variables    ../../page_objects/delivery_points_page_locators.py
Variables    ../../page_objects/chose_city_modal_window_locators.py
Variables    ../../page_objects/header_locators.py
Variables    ../../page_objects/contacts_page_locators.py

*** Variables ***
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
    login_Service
    click element    ${burger_menu}
    page should contain element    //span[contains(@class,'user-name')]

Incorrect_Login_Test
    [Tags]  IncorrectLogin
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click element    ${sign_in_button}
    input text  ${email_input_field}    " "
    input text    ${password_input_field}    12345
    ELEMENT SHOULD BE ENABLED    //p[contains(@class,'error-message')]

LogOutTest
    [Tags]  LogOut
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    ${first_login_button_present_count}  get element count   ${sign_in_button}
    should be equal as integers    ${first_login_button_present_count}      1
    login_Service
    ${second_login_button_present_status}  get element count   ${sign_in_button}
    should be equal as integers    ${second_login_button_present_status}      0
    click element    ${burger_menu}
    click element    ${logout_button}
    ${third_login_button_present_count}  get element count   ${sign_in_button}
    should be equal as integers    ${third_login_button_present_count}      1


BurgerMenuTest
    [Tags]  BurgerMenu
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    ${main_language_text}   get text    ${active_language_text}
    click element  ${burger_menu}
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

DeliveryPointsByCityTest
    [Tags]  Delivery_Points
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click element    ${burger_menu}
    ${burger_menu_city_name}   get text    ${destination_city_text}
    click element    ${burger_menu_close_button}
    click element    ${delivery_points_link}
    ${first_delivery_points_title_text}    get text    ${header_title_text}
    should contain    ${first_delivery_points_title_text}    ${burger_menu_city_name}
    click element    ${burger_menu}
    click element    ${destination_city_change_button}
    clickDestinationCityByIndex    1
    click element    ${apply_button}
    click element    ${header_logo_link}
    click element    ${delivery_points_link}
    ${second_delivery_points_title_text}    get text    ${header_title_text}
    should not contain    ${second_delivery_points_title_text}  ${burger_menu_city_name}

ContactsByCityTest
    [Tags]  ContactsByCity
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click element    ${burger_menu}
    ${burger_menu_city_name}   get text    ${destination_city_text}
    click element    ${burger_menu_close_button}
    click element    ${contacts_link}
    ${first_contacts_city_name}    get text    ${city_name_text}
    should contain    ${first_contacts_city_name}     ${burger_menu_city_name}
    click element    //button[contains(@class,'deliveries__city')]
    clickDestinationCityByIndex    1
    click element    ${apply_button}
    ${second_contacts_city_name}    get text    ${city_name_text}
    should not be equal    ${first_contacts_city_name}     ${second_contacts_city_name}

