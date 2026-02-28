*** Comments ***
# TC_CART_001: Shopping Cart - Item Management
# Test suite for verifying shopping cart item operations.

*** Settings ***
Documentation    Validates shopping cart functionality including navigation,
...              product verification, item removal, and return to catalog.

Library          SeleniumLibrary
Library          Collections

Resource         ../resources/keywords/common_keywords.resource
Resource         ../resources/keywords/login_keywords.resource
Resource         ../resources/keywords/inventory_keywords.resource
Resource         ../resources/keywords/cart_keywords.resource

Resource         ../data/test_data.resource
Resource         ../resources/locators/inventory_locators.resource
Resource         ../resources/locators/cart_locators.resource

Suite Setup      Setup Cart With Products
Suite Teardown   Close Browser

*** Keywords ***
Setup Cart With Products
    [Documentation]    Opens the browser, logs in, and adds products to the cart.
    Open Browser And Maximize    ${BASE_URL}
    Login To Application    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Add Product To Cart By Button    ${ADD_BACKPACK_BTN}
    Add Product To Cart By Button    ${ADD_BIKE_LIGHT_BTN}

*** Test Cases ***
TC_018: Navigate To Cart And Verify Products Present
    [Documentation]    Verifies the cart page displays all added products.
    [Tags]    smoke    cart    navigation

    Navigate To Cart
    Verify Product In Cart    ${PRODUCT_BACKPACK}
    Verify Product In Cart    ${PRODUCT_BIKE_LIGHT}

TC_019: Verify Product Quantities In Cart
    [Documentation]    Confirms each product in the cart shows the correct quantity.
    [Tags]    regression    cart    verification

    Verify Product Quantity In Cart    ${PRODUCT_BACKPACK}    1
    Verify Product Quantity In Cart    ${PRODUCT_BIKE_LIGHT}    1

TC_020: Remove Product From Cart
    [Documentation]    Verifies that a product can be successfully removed from the cart.
    [Tags]    smoke    cart    removal

    Remove Product From Cart By Name    ${REMOVE_BACKPACK_BTN}
    Verify Cart Item Count    1

TC_021: Return To Product Catalog From Cart
    [Documentation]    Verifies the Continue Shopping button navigates back to the product catalog.
    [Tags]    regression    cart    navigation

    Click Continue Shopping
    Wait Until Element Is Visible    ${INVENTORY_ITEM}    ${DEFAULT_TIMEOUT}
