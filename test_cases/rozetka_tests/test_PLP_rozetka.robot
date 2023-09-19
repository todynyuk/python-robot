*** Settings ***
Library  SeleniumLibrary
Resource    ../../keywords/main_keywords.robot
Resource    ../../keywords/subcategory_page_ keywords.robot
Resource    ../../keywords/devices_category_page_keywords.robot
Resource    ../../keywords/device_page_keywords.robot
Resource    ../../keywords/shopping_basket_keywords.robot
Resource    ../../variables/variables.robot
Resource    ../../keywords/utils.robot
Variables    ../../page_objects/header_locators.py
Variables    ../../page_objects/wishlist_page_locators.py
Variables    ../../page_objects/shopping_basket_locators.py
Variables    ../../page_objects/burger_menu_locators.py
Variables    ../../page_objects/compare_modal_window.py
Variables    ../../page_objects/compare_page_locators.py

*** Variables ***
#${browser}  chrome
#${url}  https://rozetka.com.ua/ua/
#${category}     Смартфони
#${second_category}  Ноутбуки
#${subcategory}     Мобільні
#${second_subcategory}   моноблоки
#${filterLowToHigh}  Від дешевих до дорогих
#${filterHighToLow}  Від дорогих до дешевих
#НОВИНКА

*** Test Cases ***
testVerifySortByPrice
    [Tags]  maintainer=todynyuk
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    clickDropdownMenu   ${FILTER_LOW_TO_HIGH}
    ${is_good_prices_low_to_hight}=  isAllGoodsSortedByPrice     5  l
    should be true    ${is_good_prices_low_to_hight}    "One or more prices not sorted from low to high price"
    clickDropdownMenu   ${FILTER_HIGH_TO_LOW}
    ${is_good_prices_hight_to_low}=  isAllGoodsSortedByPrice     5  h
    should be true    ${is_good_prices_hight_to_low}    "One or more prices not sorted from high to low price"
    [Teardown]  close browser

testVerifySortByNewest
    [Tags]  Newest
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    login_Service
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    clickDropdownMenu   ${FILTER_NEWEST}
    ${counter}    convert to integer    3
#    ${newest_goods_counter}    isAllGoodsSortedByNewest    3
    ${newest_goods_counter}    isAllGoodsSortedByNewest    ${counter}
#    log to console    newest counter
#    log to console    ${newest_goods_counter}
#    should be equal  ${newest_goods_counter}  convert to integer    3
    should be equal  ${newest_goods_counter}  ${counter}
#    isAllGoodsSortedByNewest    3

testAddToWishlist
    [Tags]  Wishlist
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    login_Service
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    ${good_title_text}    get text    (//span[@class='goods-tile__title'])[1]
    click element    (//button[contains(@class,'wish-button')])[1]
    element should be enabled    ${wishlist_counter}
    click element    ${wishlist_header_button}
    ${wish_item_title_text}    get text    ${goods_title_text}
    should be equal    ${good_title_text}    ${wish_item_title_text}
#    log to console    this step is finish
#    @{item_elements}    Get WebElements    ${item_cards}
#    ${countBien}=    Get Element Count     //div[@class="colonne
#    ${item_elements}=    Get WebElements    ${item_cards}
    ${item_elements}=    Get Element Count    ${item_cards}
#    log to console    item elements:
#    log to console    ${item_elements}
#    log to console    this step when we try collect web elements is finish
#    ${wish_items_list_length}    get length    @{item_elements}
#    log to console    this step when we try get count web elements is finish
    ${items_count}    convert to integer    1
#    should be equal    ${wish_items_list_length}   ${items_count}
    should be equal    ${item_elements}   ${items_count}


testVerifySortByBrand
    [Tags]  SortByBrand
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    click_check_box_filter  Nokia
    ${brand_status}     verify_is_search_think_present_in_goods_title   Nokia
    log to console    brand_status:${brand_status}
    should be true    ${brand_status}   Search result don`t contains chosen brand
#    ${brand_status}    verify_is_search_think_present_in_goods_title     Nokia
#    should be true    ${brand_status}

testIsSocialNetworkIconsPresent
    [Tags]  SortByBrand
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    element should be enabled

testCompareItems
    [Tags]  CompareItems
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    clickCompareButtonByIndex    1
    clickCompareButtonByIndex    3
    element should be enabled    ${compare_counter}
    click element    ${compare_button}
    click element    ${compare_modal_link}
    element should be enabled    ${compare_settings}



testAddToCartAndCheckBothBaskets
    [Tags]  CheckBothBaskets
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    login_Service
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    ${good_title_text}    get text    (//span[@class='goods-tile__title'])[3]
    clickBuyButtonByIndex   3
    clickOnShoppingBasketButton
    ${basket_item_title_text}    get text     ${basket_item_title}
    should be equal    ${good_title_text}    ${basket_item_title_text}
    click element    ${basket_modal_close_button}
    click element    ${burger_menu}
    click element    ${basket_button}
    ${second_basket_item_title_text}    get text     ${basket_item_title}
    should be equal    ${good_title_text}    ${second_basket_item_title_text}


test_choose_brands_and_check
    [Tags]  maintainer=todynyuk
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
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
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    ${FirstCartGoodsCounterText}     isAddedToCartGoodsCounterTextPresent
    should not be true     ${FirstCartGoodsCounterText}   Cart Goods Counter Text is presented
    clickBuyButtonByIndex   1
    ${SecondCartGoodsCounterText}     isAddedToCartGoodsCounterTextPresent
    should be true    ${SecondCartGoodsCounterText}   Cart Goods Counter Text isn't presented
    ${goods_in_shopping_basket_count}      getGoodsInCartListSize


testFilterByBrandNameMaxCustomPrice
     [Tags]  maintainer=todynyuk
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    ${title}    get title
    should contain    ${title}  ${SMARTPHONES_SUBCATEGORY}
    click_check_box_filter  Samsung
    clear_and_set_sorting_price     max     4000
    click_ok_button
    ${status}   check_is_goods_prices_less_than_choosen     5   4000
    should be true    ${status}     One or more things have price more than chosen
    ${brand_status}     verify_is_search_think_present_in_goods_title   Samsung
    should be true    ${brand_status}   Search result don`t contains chosen brand


testVerifyItemRamMatrixTypeAndProcessor
    [Tags]  maintainer=todynyuk
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${LAPTOP_CATEGORY}
    click_universal_subcategory_menu_link   ${LAPTOP_SUBCATEGORY}
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


