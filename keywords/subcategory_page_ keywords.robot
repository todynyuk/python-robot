*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
click_universal_subcategory_menu_link
    [Arguments]     ${value}
    click element   xpath://a[contains(@class,'tile-cats__heading') and contains(.,'${value}')]