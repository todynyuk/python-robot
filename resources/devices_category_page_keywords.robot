*** Settings ***
Library  SeleniumLibrary
Library  ExtendedSelenium2Library
Library    String
Library    Collections
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

clickDropdownMenu
    [Arguments]    ${optionName}
    click element   xpath://select[contains(@class,'select-css')]/option[contains(text(),'${optionName}')]

isAllGoodsSortedByPrice
    [Arguments]    ${count}     ${type}
    @{price_list}=     create list
    @{priceItemText}    Get WebElements    ${device_prices}
    ${counter}=  set variable    0
    ${buffer}=  set variable    0
     FOR    ${element}    IN    @{priceItemText}
        ${counter}=     evaluate    ${counter} + 1
        ${elem}  get text    ${element}
        ${buffer}     Get Price String As Integer  ${elem}
        insert into list    ${price_list}    ${counter}    ${buffer}
        exit for loop if    ${count} == ${counter}
    END
    IF  '${type}' == 'l'
        ${check_sorted_list}    CheckListFromLowToHigh    ${price_list}
    END
    IF    '${type}' == 'h'
        ${check_sorted_list}    CheckListFromHighToLow    ${price_list}
    END
    ${value}=    Convert To Integer   ${count}
    ${status}   should be equal    ${check_sorted_list}     ${value}
    [Return]    ${check_sorted_list}

CheckListFromLowToHigh
    [Arguments]    ${list}
    ${counter}=  set variable    1
    ${length}=    Get Length    ${list}
    FOR     ${i}    IN RANGE    ${length}-1
        ${first}=    Set Variable    ${list}[${i}]
        ${second}=   Set Variable    ${list}\[${i}+1]
        IF    ${first} <= ${second}
            ${counter}=     evaluate    ${counter} + 1
        ELSE
            ${counter}=     evaluate    ${counter} + 0
        END
    END
    [Return]    ${counter}

CheckListFromHighToLow
    [Arguments]    ${list}
    ${counter}=  set variable    1
    ${length}=    Get Length    ${list}
    FOR     ${i}    IN RANGE    ${length}-1
        ${first}=    Set Variable    ${list}[${i}]
        ${second}=   Set Variable    ${list}\[${i}+1]
        IF    ${first} >= ${second}
            ${counter}=     evaluate    ${counter} + 1
        ELSE
            ${counter}=     evaluate    ${counter} + 0
        END
    END
    [Return]    ${counter}

Get Price String As Integer
    [Arguments]    ${string}
    ${price}=    Remove String    ${string}    ₴    ' '
    ${value}=    Convert To Integer   ${price}
    [Return]    ${value}