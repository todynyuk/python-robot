*** Settings ***
Library  SeleniumLibrary
Resource    ../resources/main_keywords.robot
Resource    ../resources/subcategory_page_ keywords.robot
Resource    ../resources/devices_category_page_keywords.robot
Resource    ../resources/device_page_keywords.robot

*** Variables ***
${browser}  chrome
${url}  https://rozetka.com.ua/ua/
${category}     Смартфони
${subcategory}     Мобільні
${filterLowToHigh}  Від дешевих до дорогих
${filterHighToLow}  Від дорогих до дешевих

*** Test Cases ***
testVerifySortByPrice
    [Tags]  maintainer=todynyuk
    launchingBrowser    ${url}   ${browser}
    click_universal_category_link   ${category}
    click_universal_subcategory_menu_link   ${subcategory}
    clickDropdownMenu   ${filterLowToHigh}
    ${is_good_prices_low_to_hight}=  isAllGoodsSortedByPrice     5  l
    should be true    ${is_good_prices_low_to_hight}    "One or more prices not sorted from low to high price"
    clickDropdownMenu   ${filterHighToLow}
    ${is_good_prices_hight_to_low}=  isAllGoodsSortedByPrice     5  h
    should be true    ${is_good_prices_hight_to_low}    "One or more prices not sorted from high to low price"
    [Teardown]  close browser