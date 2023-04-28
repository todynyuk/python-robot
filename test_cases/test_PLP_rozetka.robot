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
${count}


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

test_choose_brands_and_check
    [Tags]  maintainer=todynyuk
    launchingBrowser    ${url}   ${browser}
    click_universal_category_link   ${category}
    click_universal_subcategory_menu_link   ${subcategory}
    click_check_box_filter  Huawei
    click_check_box_filter  Infinix
    click_check_box_filter  Motorola
    ${check_is_first_brand_selected}    check_chosen_filters_contains_chosen_brands     Huawei
    should be true    ${check_is_first_brand_selected}  Brand Huawei is not selected
    ${check_is_second_brand_selected}    check_chosen_filters_contains_chosen_brands     Infinix
    should be true    ${check_is_second_brand_selected}  Brand Infinix is not selected
    ${check_is_third_brand_selected}    check_chosen_filters_contains_chosen_brands     Motorola
    should be true    ${check_is_third_brand_selected}  Brand Motorola is not selected
    [Teardown]  close browser

testAddingAndCountGoodsInBasket
    [Tags]  maintainer=todynyuk
    launchingBrowser    ${url}   ${browser}
    click_universal_category_link   ${category}
    click_universal_subcategory_menu_link   ${subcategory}
    ${FirstCartGoodsCounterText}     isAddedToCartGoodsCounterTextPresent
    should not be true     ${FirstCartGoodsCounterText}   Cart Goods Counter Text is presented
    clickBuyButtonByIndex   1
    ${SecondCartGoodsCounterText}     isAddedToCartGoodsCounterTextPresent
    should be true    ${SecondCartGoodsCounterText}   Cart Goods Counter Text isn't presented


testFilterByBrandNameMaxCustomPriceAndAvailable
     [Tags]  maintainer=todynyuk
    launchingBrowser    ${url}   ${browser}
    click_universal_category_link   ${category}
    click_universal_subcategory_menu_link   ${subcategory}
    ${title}    get title
    should contain    ${title}  ${subcategory}
    click_check_box_filter  Samsung
    clear_and_set_sorting_price     max     4000
    click_ok_button
    ${status}   check_is_goods_prices_less_than_choosen     5   4000
    should be true    ${status}
    ${brand_status}     verify_is_search_think_present_in_goods_title   Samsung
