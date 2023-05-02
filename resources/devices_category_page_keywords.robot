*** Settings ***
Library  SeleniumLibrary
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
    ${buffer}     Get Price String As Integer  ${data}
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

check_chosen_filters_contains_chosen_brands
    [Arguments]     ${brand_name}
    @{chosen_filters}=     create list
    ${counter}=  set variable    0
    @{chosen_filtersText}    Get WebElements    ${filter_links}
    FOR    ${element}    IN    @{chosen_filtersText}
        ${counter}=     evaluate    ${counter} + 1
        ${elem}  get text    ${element}
        ${buffer}   replace string   ${elem}     ' '   ''
        insert into list    ${chosen_filters}    ${counter}    ${buffer}
        ${chosen_filtersTextlenth}  get length    ${chosen_filtersText}
        exit for loop if    ${chosen_filtersTextlenth} == ${counter}
    END
    ${status}   list should contain value    ${chosen_filters}  brand_name
    [Return]   ${status}

isAddedToCartGoodsCounterTextPresent
    ${zero}    convert to integer    0
    ${count}   get element count    ${cart_goods_counter_text}
    ${status}  convert to boolean    False
    IF  ${count} != ${zero}
        ${status}   convert to boolean    True
    END
    [Return]    ${status}

clickBuyButtonByIndex
    [Arguments]     ${index}
    scroll element into view   xpath:(//button[contains(@class,'buy-button')])[${index}]
    set focus to element    xpath:(//button[contains(@class,'buy-button')])[${index}]
    click element   xpath:(//button[contains(@class,'buy-button')])[${index}]

clear_and_set_sorting_price
    [Arguments]    ${type}     ${value}
    clear element text    //input[@formcontrolname='${type}']
    input text    //input[@formcontrolname='${type}']   ${value}

click_ok_button
    click element    ${ok_button}

get_prices_list
    @{price_list}=     create list
    @{price_elements}    Get WebElements    ${device_prices}
    ${counter}=  set variable    0
    ${buffer}=  set variable    0
     FOR    ${element}    IN    @{price_elements}
        ${counter}=     evaluate    ${counter} + 1
        ${elem}  get text    ${element}
        ${buffer}     Get Price String As Integer  ${elem}
        insert into list    ${price_list}    ${counter}    ${buffer}
        ${prices_list_length}  get length    ${price_elements}
        exit for loop if    ${prices_list_length} == ${counter}
     END
     [Return]    @{price_list}

check_is_goods_prices_less_than_choosen
    [Arguments]      ${count}   ${chosen_max_price}
    ${buffer}     Convert To Integer  ${chosen_max_price}
    @{price_list}=     get_prices_list
    ${price_listTextlenth}  get length    ${price_list}
    ${counter}=  set variable    0
    FOR    ${element}    IN    @{price_list}
        IF    ${element} <= ${buffer}
            ${counter}=     evaluate    ${counter} + 1
        ELSE
            ${counter}=     evaluate    ${counter} + 0
        END
        exit for loop if    ${counter} == ${price_listTextlenth}
    END
    [Return]    should be equal    ${counter}     ${price_listTextlenth}

verify_is_search_think_present_in_goods_title
    [Arguments]     ${value}
     ${value_lower_case}    convert to lower case    ${value}
     @{title_text_elements}    Get WebElements    ${goods_title_text}
     ${title_list_texts_lenght}  get length    ${title_text_elements}
     ${counter}=  set variable    0
     FOR    ${element}    IN    @{title_text_elements}
        ${elem}  get text    ${element}
        ${element_lower_case}   convert to lower case    ${elem}
        ${string}    Set Variable    ${element_lower_case}
        ${contains_word}    Run Keyword And Return Status    Should Contain    ${string}    ${value_lower_case}
        IF    '${contains_word}' == 'True'
            ${counter}=     evaluate    ${counter} + 1
        ELSE
            ${counter}=     evaluate    ${counter} + 0
       END
        exit for loop if    ${counter} == ${title_list_texts_lenght}
     END
     ${status}   should be true    ${counter} == ${title_list_texts_lenght}
     [Return]    ${status}

clickUniversalShowCheckBoxButton
    [Arguments]     ${param}
    click element   xpath://span[@class='sidebar-block__toggle-title' and contains (., '${param}')]

check_is_all_goods_available
    [Arguments]     ${param}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    ${zero}    convert to integer    0
    ${count}   get element count    xpath://div[contains(@class,'goods-tile__availability') and contains(text(),'${param}')]
    ${status}  convert to boolean    False
    IF  ${count} == ${zero}
        ${status}   convert to boolean    True
    END
    [Return]    ${status}

get_goods_title_text_by_index
    [Arguments]     ${index}
    ${data}=     get text    xpath:(//a[contains(@class,'goods-tile__heading')])[${index}]
    [Return]    ${data}

clickOnShoppingBasketButton
    click element   ${shopping_basket_button}

get_goods_description_text_by_index
    [Arguments]     ${index}
    ${data}=     get text    xpath:(//a[@data-testid='title'])[${index}]
    [Return]    ${data}