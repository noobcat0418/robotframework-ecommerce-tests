*** Comments ***
# TC_CHECKOUT_001: Checkout - Complete Purchase Flow
# Test suite for verifying the end-to-end checkout process.

*** Settings ***
Documentation    Validates the complete checkout workflow including filling checkout
...              information, completing the purchase, and returning to the product catalog.

Library          SeleniumLibrary
Library          Collections

Resource         ../resources/keywords/common_keywords.resource
Resource         ../resources/keywords/login_keywords.resource
Resource         ../resources/keywords/inventory_keywords.resource
Resource         ../resources/keywords/cart_keywords.resource
Resource         ../resources/keywords/checkout_keywords.resource

Resource         ../data/test_data.resource
Resource         ../resources/locators/inventory_locators.resource
Resource         ../resources/locators/cart_locators.resource
Resource         ../resources/locators/checkout_locators.resource

Suite Setup      Setup Checkout Flow
Suite Teardown   Close Browser

*** Keywords ***
Setup Checkout Flow
    [Documentation]    Logs in, adds a product, and navigates to the cart.
    Open Browser And Maximize    ${BASE_URL}
    Login To Application    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Add Product To Cart By Button    ${ADD_BACKPACK_BTN}
    Navigate To Cart

*** Test Cases ***
TC_025: Complete Checkout With Valid Information
    [Documentation]    Verifies that a user can complete checkout by filling valid shipping details.
    [Tags]    smoke    checkout    e2e

    Click Checkout Button
    Fill Checkout Information    ${CHECKOUT_FIRST_NAME}    ${CHECKOUT_LAST_NAME}    ${CHECKOUT_POSTAL_CODE}
    Finish Checkout

TC_026: Verify Order Confirmation Message
    [Documentation]    Confirms the order confirmation page displays the success message.
    [Tags]    smoke    checkout    confirmation

    Verify Checkout Complete

TC_027: Return To Product Catalog After Checkout
    [Documentation]    Verifies that the user can navigate back to the product catalog after checkout.
    [Tags]    regression    checkout    navigation

    Return To Products From Checkout
    Wait Until Element Is Visible    ${INVENTORY_ITEM}    ${DEFAULT_TIMEOUT}
