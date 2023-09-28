*** Settings ***
Library  SeleniumLibrary
#Variables    ../page_objects/main_page_locators.py
Variables    ..${/}page_objects${/}main_page_locators.py

*** Keywords ***
launchingBrowser
    [Arguments]     ${webUrl}   ${webBrowser}
    SeleniumLibrary.Open Browser    ${webUrl}   ${webBrowser}
    maximize browser window
    set selenium speed  2seconds

click_universal_category_link
    [Arguments]     ${value}
    click element   xpath://a[@class='menu-categories__link' and contains(.,'${value}')]

click_some_element
    [Arguments]     ${xpath_value}
    click element   ${xpath_value}


