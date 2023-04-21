*** Settings ***
Library  SeleniumLibrary
Library  ExtendedSelenium2Library
Library    String
Variables    ../page_objects/device_category_locators.py

*** Keywords ***
choose_ram_сapacity
    [Arguments]     ${value}
    click element   xpath://a[contains(@class,'tile-filter__link') and contains(text(),'${value}')]

click_check_box_filter
    [Arguments]     ${value}
    click element   xpath://a[contains(@data-id,'${value}')]

getSmartphonePriceText
    [Arguments]     ${index}
    ${data}=     get text    xpath:(//span[@class='goods-tile__price-value'])[${index}]
    ${buffer}    get regexp matches    ${data}   \\d
    [Return]    ${buffer}

clickLinkMoreAboutDevice
    [Arguments]     ${index}
    scroll element into view   xpath:(//a[@class='goods-tile__heading ng-star-inserted'])[${index}]
    set focus to element    xpath:(//a[@class='goods-tile__heading ng-star-inserted'])[${index}]
    click element   xpath:(//a[@class='goods-tile__heading ng-star-inserted'])[${index}]


