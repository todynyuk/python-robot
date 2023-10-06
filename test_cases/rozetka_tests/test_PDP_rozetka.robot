*** Settings ***
Library  SeleniumLibrary
Library    String
Resource    ../../keywords/destination_city_keywords.robot
Resource    ../../keywords/devices_category_page_keywords.robot
Resource    ../../keywords/device_page_keywords.robot
Resource    ../../keywords/feedback_window_keywords.robot
Resource    ../../keywords/main_keywords.robot
Resource    ../../keywords/subcategory_page_ keywords.robot
Resource    ../../variables/variables.robot
Resource    ../../keywords/utils.robot
Resource    ../../page_objects/device_page_locators.py
Variables    ../../page_objects/shopping_basket_locators.py
Variables    ../../page_objects/burger_menu_locators.py
Variables    ../../page_objects/chose_city_modal_window_locators.py
Variables    ../../page_objects/device_photo_page_locators.py
Variables    ../../page_objects/credit_modal_window_locators.py
Variables    ../../page_objects/orders_page_locators.py
Variables    ../../page_objects/feedback_window_locators.py



*** Variables ***

*** Test Cases ***
ItemRamAndPriceTest
    [Tags]  maintainer=todynyuk
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    choose_ram_сapacity     12
    click_check_box_filter  Синій
    ${smartphone_price}=  getSmartphonePriceText     2
    clickLinkMoreAboutDevice    2
    ${short_characteristics}=    verify_device_short_characteristic     12
    ${chosen_device_price}=  get_chosen_product_price
    should be true    ${short_characteristics}
    should be equal    '${smartphone_price}'   '${chosen_device_price}'     "Prices are not equals"
    [Teardown]  close browser

CheckoutTest
#    [Tags]  Checkout
     [Tags]  WithoutLoginUser
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    ${good_title_text}    get text    (//span[@class='goods-tile__title'])[2]
    clickLinkMoreAboutDevice    2
    click element    ${pdp_buy_button}
    click element    //a[@data-testid='cart-receipt-submit-order']
    ELEMENT SHOULD BE ENABLED    //span[@class='checkout-product__title']
    ${order_item_title}    get text    //span[@class='checkout-product__title']
    should contain    ${order_item_title}   ${good_title_text}

CheckDestinationCityTest
#    [Tags]  DestinationCity
    [Tags]  WithoutLoginUser
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    click element    ${burger_menu}
    ${burger_menu_city_name}   get text    ${destination_city_text}
    click element    ${burger_menu_close_button}
    clickLinkMoreAboutDevice    3
    ${pdp_destination_city_name}    get text    ${destination_city_pdp}
    should contain    ${pdp_destination_city_name}    ${burger_menu_city_name}
    click element    ${burger_menu}
    click element    ${destination_city_change_button}
    clickDestinationCityByIndex    1
    click element    ${apply_button}
    ${pdp_destination_city_name_second}    get text    ${destination_city_pdp}
    click element    ${burger_menu}
    ${burger_menu_city_name_second}   get text    ${destination_city_text}
    should contain    ${pdp_destination_city_name_second}    ${burger_menu_city_name_second}

CheckDeviceColorTest
#    [Tags]  DeviceColor
    [Tags]  WithoutLoginUser
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    clickLinkMoreAboutDevice    3
    ${first_device_info_text}     get text    ${short_characteristic_title}
    ${first_device_color_text}    get text    ${active_color_text}
    ${first_chosen_color}=    Remove String        ${first_device_color_text}   ,    Колір :
    should contain    ${first_device_info_text}   ${first_chosen_color}
    chose_color_by_index    1
    ${second_device_info_text}     get text    ${short_characteristic_title}
    ${second_device_color_text}    get text    ${active_color_text}
    ${second_chosen_color}=    Remove String        ${second_device_color_text}   ,    Колір :
    should contain    ${second_device_info_text}   ${second_chosen_color}

CheckCreditPaymentTest
#    [Tags]  CreditPayment
    [Tags]  WithoutLoginUser
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    clickLinkMoreAboutDevice    3
    click element    ${buy_in_credit_button}
    ${first_chosen_credit_part_sum}=     get text    (//span[@class='credit-variant__price'])[1]
    ${first_buffer}=    Remove String    ${first_chosen_credit_part_sum}    ₴ / місяць    ' '
    ${first_credit_part_sum}=    Convert To Integer   ${first_buffer}
    click element    (//select[@id='creditPeriodSelector'])[1]
    click element    (//option[@class='ng-star-inserted'])[5]
    ${second_chosen_credit_part_sum}=     get text    (//span[@class='credit-variant__price'])[1]
    ${second_buffer}=    Remove String    ${second_chosen_credit_part_sum}    ₴ / місяць    ' '
    ${second_credit_part_sum}=    Convert To Integer   ${second_buffer}
    should not be equal    ${first_credit_part_sum}    ${second_credit_part_sum}

CheckDevicePhotoTest
#    [Tags]  DevicePhoto
    [Tags]  WithoutLoginUser
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    clickLinkMoreAboutDevice    3
    click element    ${device_photo_link}
    element should be enabled   ${device_photo}

CheckByInCreditTest
#    [Tags]  DevicePhoto
    [Tags]  WithoutLoginUser
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    clickLinkMoreAboutDevice    3
    click_bank_button_by_index    2
    click element    ${apply_for_button}
    element should be enabled    ${checkout_payments_credit}
    ${first_credit_info_text}     get text    ${credit_details_text}
    click element    ${change_credit_options_button}
    click element    (//button[@id='creditSubmitButton'])[1]
    ${second_credit_info_text}      get text    ${credit_details_text}
    should not be equal    ${first_credit_info_text}    ${second_credit_info_text}

PhotoGalleryTest
#    [Tags]  PhotoGallery
    [Tags]  WithoutLoginUser
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    clickLinkMoreAboutDevice    3
    click element    ${comments_link}
    click element    (//button[contains(@class,'photos-button')])[1]
    ${elements_count}  get element count  ${photo_indicator_item_list}
    ${status_counter}   check_switching_photos  ${elements_count}
    should be equal as integers    ${elements_count}    ${status_counter}
    click element    ${modal_close_button}
    ${count}  get element count    ${modal_window}
    should be equal as integers    ${count}     0


PhotoGallerySwitchingTest
#    [Tags]  PhotoGallerySwitching
    [Tags]  WithoutLoginUser
    launchingBrowser    ${URL}   ${BROWSER_CHROME}
    click_universal_category_link   ${SMARTPHONES_CATEGORY}
    click_universal_subcategory_menu_link   ${SMARTPHONES_SUBCATEGORY}
    clickLinkMoreAboutDevice    3
    click element    ${comments_link}
    click element    (//button[contains(@class,'photos-button')])[1]
    ${first_indicator_class_text}   Get Element Attribute    (//span[contains(@class,'indicators__item')])[1]        class
    should contain    ${first_indicator_class_text}     active
    click element    ${button_next_photo}
    ${second_indicator_class_text}   Get Element Attribute    (//span[contains(@class,'indicators__item')])[2]        class
    should contain    ${second_indicator_class_text}     active
    click element    ${button_preview_photo}
    ${new_first_indicator_class_text}   Get Element Attribute    (//span[contains(@class,'indicators__item')])[1]        class
    should contain    ${new_first_indicator_class_text}     active
    click element    ${modal_close_button}
    ${count}  get element count    ${modal_window}
    should be equal as integers    ${count}     0
#    page should not contain    ${modal_window}#also work but more slowly at the end
