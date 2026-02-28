*** Comments ***
# TC_PRODUCT_003: Product Catalog - Add To Cart
# Test suite for verifying add-to-cart functionality from the product catalog.

*** Settings ***
Documentation    Validates that users can add products to the shopping cart
...              from the product catalog page and the cart badge updates correctly.

Library          SeleniumLibrary
Library          Collections

Resource         ../resources/keywords/common_keywords.resource
Resource         ../resources/keywords/login_keywords.resource
Resource         ../resources/keywords/inventory_keywords.resource
Resource         ../resources/keywords/cart_keywords.resource

Resource         ../data/test_data.resource
Resource         ../resources/locators/inventory_locators.resource
Resource         ../resources/locators/cart_locators.resource

Suite Setup      Setup Product Catalog
Suite Teardown   Close Browser

*** Keywords ***
Setup Product Catalog
    [Documentation]    Opens the browser and navigates to the product catalog.
    Open Browser And Maximize    ${BASE_URL}
    Login To Application    ${VALID_USERNAME}    ${VALID_PASSWORD}

*** Test Cases ***
TC_015: Add Single Product To Cart From Catalog
    [Documentation]    Verifies that a single product can be added to the cart from the catalog page.
    [Tags]    smoke    products    cart

    Add Product To Cart By Button    ${ADD_BACKPACK_BTN}
    Verify Cart Badge Count    1

TC_016: Add Multiple Products To Cart
    [Documentation]    Verifies that multiple products can be added to the cart.
    [Tags]    smoke    products    cart

    Add Product To Cart By Button    ${ADD_BIKE_LIGHT_BTN}
    Add Product To Cart By Button    ${ADD_BOLT_TSHIRT_BTN}
    Verify Cart Badge Count    3

TC_017: Add All Available Products To Cart
    [Documentation]    Verifies that all products in the catalog can be added to the cart.
    [Tags]    regression    products    cart

    Add Product To Cart By Button    ${ADD_FLEECE_JACKET_BTN}
    Add Product To Cart By Button    ${ADD_ONESIE_BTN}
    Add Product To Cart By Button    ${ADD_RED_TSHIRT_BTN}
    Verify Cart Badge Count    ${EXPECTED_PRODUCT_COUNT}
