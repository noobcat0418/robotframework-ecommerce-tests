*** Comments ***
# TC_CART_002: Shopping Cart - Price Verification
# Test suite for verifying cart price accuracy against catalog prices.

*** Settings ***
Documentation    Validates that product prices displayed in the shopping cart
...              match the prices shown on the product catalog page.

Library          SeleniumLibrary
Library          Collections

Resource         ../resources/keywords/common_keywords.resource
Resource         ../resources/keywords/login_keywords.resource
Resource         ../resources/keywords/inventory_keywords.resource
Resource         ../resources/keywords/cart_keywords.resource

Resource         ../data/test_data.resource
Resource         ../resources/locators/inventory_locators.resource
Resource         ../resources/locators/cart_locators.resource

Suite Setup      Setup Cart And Capture Prices
Suite Teardown   Close Browser

*** Variables ***
${CATALOG_PRICE_1}    ${0}
${CATALOG_PRICE_2}    ${0}

*** Keywords ***
Setup Cart And Capture Prices
    [Documentation]    Logs in, captures catalog prices, and adds products to cart.
    Open Browser And Maximize    ${BASE_URL}
    Login To Application    ${VALID_USERNAME}    ${VALID_PASSWORD}
    ${price1}=    Get Product Price By Index    0
    ${price2}=    Get Product Price By Index    1
    Set Suite Variable    ${CATALOG_PRICE_1}    ${price1}
    Set Suite Variable    ${CATALOG_PRICE_2}    ${price2}
    Add Product To Cart By Button    ${ADD_BACKPACK_BTN}
    Add Product To Cart By Button    ${ADD_BIKE_LIGHT_BTN}
    Navigate To Cart

*** Test Cases ***
TC_022: Verify Cart Prices Match Catalog Prices
    [Documentation]    Confirms that the prices shown in the cart match the original catalog prices.
    [Tags]    smoke    cart    pricing

    ${cart_price1}=    Get Cart Product Price    ${PRODUCT_BACKPACK}
    ${cart_price2}=    Get Cart Product Price    ${PRODUCT_BIKE_LIGHT}
    Should Be Equal As Numbers    ${CATALOG_PRICE_1}    ${cart_price1}
    Should Be Equal As Numbers    ${CATALOG_PRICE_2}    ${cart_price2}

TC_023: Verify Cart Badge Reflects Item Count
    [Documentation]    Confirms the cart badge accurately shows the number of items in the cart.
    [Tags]    regression    cart    badge

    Verify Cart Badge Count    2

TC_024: Verify Cart Item Count Matches Added Products
    [Documentation]    Validates the total number of items in the cart matches what was added.
    [Tags]    regression    cart    verification

    Verify Cart Item Count    2
