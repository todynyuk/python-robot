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

*** Test Cases ***
ItemRamAndPriceTest
    launchingBrowser    ${url}   ${browser}
    click_universal_category_link   ${category}
    click_universal_subcategory_menu_link   ${subcategory}
    choose_ram_сapacity     12
    click_check_box_filter  Синій
    ${smartphone_price}=  getSmartphonePriceText     2
    clickLinkMoreAboutDevice    2
    ${short_characteristics}=    verify_device_short_characteristic     12
    ${chosen_device_price}=  get_chosen_product_price
    should be true    ${short_characteristics}
    should be equal    '${smartphone_price}'   '${chosen_device_price}'     "Prices are not equals"
    [Teardown]  close browser