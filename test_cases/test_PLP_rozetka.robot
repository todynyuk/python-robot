*** Settings ***
Library  SeleniumLibrary
Resource    ../resources/main_keywords.robot
Resource    ../resources/subcategory_page_ keywords.robot
Resource    ../resources/devices_category_page_keywords.robot
Resource    ../resources/device_page_keywords.robot
Resource    ../resources/shopping_basket_keywords.robot

*** Variables ***
${browser}  chrome
${url}  https://rozetka.com.ua/ua/
${category}     Смартфони
${second_category}  Ноутбуки
${subcategory}     Мобільні
${second_subcategory}   моноблоки
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
    ${goods_in_shopping_basket_count}      getGoodsInCartListSize


testFilterByBrandNameMaxCustomPrice
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
    should be true    ${status}     One or more things have price more than chosen
    ${brand_status}     verify_is_search_think_present_in_goods_title   Samsung
    should be true    ${brand_status}   Search result don`t contains chosen brand


testVerifyItemRamMatrixTypeAndProcessor
    [Tags]  maintainer=todynyuk
    launchingBrowser    ${url}   ${browser}
    click_universal_category_link   ${second_category}
    click_universal_subcategory_menu_link   ${second_subcategory}
    click_check_box_filter      Intel Core i5
    click_check_box_filter      Моноблок
    click_check_box_filter      8 ГБ
    clickUniversalShowCheckBoxButton    Тип матриці
    click_check_box_filter      IPS
    click_check_box_filter      Новий
    click_check_box_filter      Є в наявності
    ${not_available_status}    check_is_all_goods_available   Немає в наявності
    should be true    ${not_available_status}   One or more goods are not available
    clickLinkMoreAboutDevice    1
    ${verify_processor}  verifyChosenParameterInShortCharacteristics  Intel Core i5
    should be true    ${verify_processor}     Processor name text not contains in about device text
    ${verify_RAM}  verifyChosenParameterInShortCharacteristics  8 ГБ
    should be true    ${verify_RAM}    Ram text not contains in about device text
    ${verify_matrix_type}  verifyChosenParameterInShortCharacteristics  IPS
    should be true    ${verify_matrix_type}     Matrix type text not contains in about device text
    ${verify_pc_type}  verifyChosenParamInAllCharacteristics  Моноблок
    should be true    ${verify_pc_type}     Computer type text not contains in description device text


