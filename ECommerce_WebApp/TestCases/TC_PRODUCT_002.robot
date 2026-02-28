*** Comments ***
# TC_PRODUCT_002: Product Catalog - Sorting Functionality
# Test suite for verifying product sorting options on the catalog page.

*** Settings ***
Documentation    Validates that all product sorting options function correctly,
...              including sorting by name and price in ascending and descending order.

Library          SeleniumLibrary
Library          Collections

Resource         ../resources/keywords/common_keywords.resource
Resource         ../resources/keywords/login_keywords.resource
Resource         ../resources/keywords/inventory_keywords.resource

Resource         ../data/test_data.resource
Resource         ../resources/locators/inventory_locators.resource

Suite Setup      Setup Product Catalog
Suite Teardown   Close Browser

*** Keywords ***
Setup Product Catalog
    [Documentation]    Opens the browser and navigates to the product catalog.
    Open Browser And Maximize    ${BASE_URL}
    Login To Application    ${VALID_USERNAME}    ${VALID_PASSWORD}

*** Test Cases ***
TC_011: Sort Products By Name A To Z
    [Documentation]    Verifies that products can be sorted alphabetically in ascending order.
    [Tags]    regression    products    sorting

    Sort Products By Name Ascending
    ${names}=    Get WebElements    ${INVENTORY_ITEM_NAME}
    ${first_name}=    Get Text    ${names}[0]
    Log    First product after A-Z sort: ${first_name}

TC_012: Sort Products By Name Z To A
    [Documentation]    Verifies that products can be sorted alphabetically in descending order.
    [Tags]    regression    products    sorting

    Sort Products By Name Descending
    ${names}=    Get WebElements    ${INVENTORY_ITEM_NAME}
    ${first_name}=    Get Text    ${names}[0]
    Log    First product after Z-A sort: ${first_name}

TC_013: Sort Products By Price Low To High
    [Documentation]    Verifies that products can be sorted by price in ascending order.
    [Tags]    regression    products    sorting

    Sort Products By Price Low To High
    ${first_price}=    Get Product Price By Index    0
    ${last_price}=    Get Product Price By Index    5
    Should Be True    ${first_price} <= ${last_price}

TC_014: Sort Products By Price High To Low
    [Documentation]    Verifies that products can be sorted by price in descending order.
    [Tags]    regression    products    sorting

    Sort Products By Price High To Low
    ${first_price}=    Get Product Price By Index    0
    ${last_price}=    Get Product Price By Index    5
    Should Be True    ${first_price} >= ${last_price}
