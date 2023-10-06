*** Settings ***
Library  SeleniumLibrary
Resource    ../../keywords/main_keywords.robot
Resource    ../../keywords/subcategory_page_ keywords.robot
Resource    ../../keywords/devices_category_page_keywords.robot
Resource    ../../keywords/shopping_basket_keywords.robot
Resource    ../../variables/variables.robot

*** Variables ***

*** Test Cases ***
testUsualPriceItemAndInBasket
    [Tags]  maintainer=todynyuk
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    ${smartphone_price}  getSmartphonePriceText     1
    ${short_characteristics}  get_goods_title_text_by_index     1
    clickBuyButtonByIndex   1
    clickOnShoppingBasketButton
    ${item_card_description_text}  get_goods_description_text_by_index   1
    should be equal    ${short_characteristics}      ${item_card_description_text}
    ${shopping_basket_item_price}    getDevicePriceText     1
    should be equal    ${smartphone_price}      ${shopping_basket_item_price}
    set_goods_count_value      3
    ${smartphone_price_multiply}=    evaluate     ${smartphone_price} * 3
    ${sum_price_basket_text}    getSumPriceText
    should be equal   ${smartphone_price_multiply}      ${sum_price_basket_text}

testAddGoodsInBasketAndCheckItEmpty
    [Tags]  maintainer=todynyuk
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    clickBuyButtonByIndex   1
    clickOnShoppingBasketButton
    ${CartGoodsCounterText}     isAddedToCartGoodsCounterTextPresent
    should be true    ${CartGoodsCounterText}   Cart Goods Counter Text isn't presented
    ${goods_in_shopping_basket_count}    getGoodsInCartListSize
    should be true    ${goods_in_shopping_basket_count} > 0   Basket is empty


testAddGoodsInBasketDeleteAndCheckIsEmpty
    [Tags]  WithoutLoginUser
#    [Tags]  DeleteItem
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    clickBuyButtonByIndex   1
    clickOnShoppingBasketButton
    ${goods_in_shopping_basket_count}    getGoodsInCartListSize
    should be true    ${goods_in_shopping_basket_count} > 0   Basket is empty
    click element   ${option_menu_button}
    click element    ${delete_item_from_cart_button}
    element should be enabled    ${empty_status_text}

