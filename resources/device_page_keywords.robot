*** Settings ***
Library  SeleniumLibrary
Library    String
Variables    ../page_objects/device_page_locators.py

*** Keywords ***
verify_device_short_characteristic
    [Arguments]     ${value}
    ${data}=     get text    ${short_characteristic_title}
    [Return]    Element Should Contain    ${data}    ${value}   Page not contains short characteristic text


get_chosen_product_price
    ${chosen_product_price}=     get text    ${product_price}
    ${data}     get regexp matches    ${chosen_product_price}   \\d
    [Return]    ${data}