*** Settings ***
Library  SeleniumLibrary
Variables    ../page_objects/main_page_locators.py

*** Keywords ***
inputSearchField
    [Arguments]     ${searchValue}
    input text  ${search_input}    ${searchValue}

clickSearchButton
    click element   ${search_button}

verifySearchTitle
    [Arguments]     ${searchValue}
    Element Should Contain    ${search_title_text}    ${searchValue}   Page not contains search text

verifyProductTitle
    [Arguments]     ${searchValue}
    Element Should Contain    ${first_item_title_text}    ${searchValue}   Page not contains search text

verifyNotFoundText
    element should be enabled   ${not_found_text}
