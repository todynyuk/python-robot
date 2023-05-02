*** Settings ***
Library  SeleniumLibrary
Library    String
Library    Collections
Variables    ../page_objects/shopping_basket_locators.py
Library    String

*** Keywords ***
Get Price String As Integer
    [Arguments]    ${string}
    ${price}=    Remove String    ${string}    ₴    ' '
    ${value}=    Convert To Integer   ${price}
    [Return]    ${value}

set_goods_count_value
    [Arguments]    ${value}
    clear element text    //input[@data-testid='cart-counter-input']
    input text    //input[@data-testid='cart-counter-input']   ${value}

getDevicePriceText
    [Arguments]     ${index}
    ${data}=     get text    xpath:(//p[@data-testid='cost'])[${index}]
    ${buffer}     Get Price String As Integer  ${data}
    [Return]    ${buffer}

getSumPriceText
    ${data}=     get text    ${sum_price_text}
    ${buffer}     Get Price String As Integer  ${data}
    [Return]    ${buffer}

getGoodsInCartListSize
    @{priceItemText}    Get WebElements    ${goods_in_cart_title_price}
    ${length}=    Get Length    ${priceItemText}
    [Return]    ${length}