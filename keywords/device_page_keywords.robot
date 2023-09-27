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

chose_color_by_index
    [Arguments]     ${index}
    click element    (//a[contains(@class,'var-options__color')])[${index}]

click_bank_button_by_index
    [Arguments]     ${index}
    click element    (//button[contains(@class,'product-pictogram__button')])[${index}]

verifyChosenParameterInShortCharacteristics
    [Arguments]     ${param}
    ${value_lower_case}    convert to lower case    ${param}
    ${short_characteristic_text}    get text    ${short_characteristic}
    ${element_lower_case}   convert to lower case    ${short_characteristic_text}
    ${string}    Set Variable    ${element_lower_case}
    ${status}  convert to boolean    False
    ${contains_word}    Run Keyword And Return Status    Should Contain    ${string}    ${value_lower_case}
    IF    '${contains_word}' == 'True'
        ${status}   convert to boolean    True
    END
    [Return]    ${status}

verifyChosenParamInAllCharacteristics
    [Arguments]     ${param}
        ${value_lower_case}    convert to lower case    ${param}
    ${short_characteristic_text}    get text    ${all_characteristic}
    ${element_lower_case}   convert to lower case    ${short_characteristic_text}
    ${string}    Set Variable    ${element_lower_case}
    ${status}  convert to boolean    False
    ${contains_word}    Run Keyword And Return Status    Should Contain    ${string}    ${value_lower_case}
    IF    '${contains_word}' == 'True'
        ${status}   convert to boolean    True
    END
    [Return]    ${status}
