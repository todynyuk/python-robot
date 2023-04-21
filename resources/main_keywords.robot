*** Settings ***
Library  SeleniumLibrary
Variables    ../page_objects/main_page_locators.py

*** Keywords ***
launchingBrowser
    [Arguments]     ${webUrl}   ${webBrowser}
    open browser    ${webUrl}   ${webBrowser}
    maximize browser window
    set selenium speed  2seconds

click_universal_category_link
    [Arguments]     ${value}
    click element   xpath://a[@class='menu-categories__link' and contains(.,'${value}')]
