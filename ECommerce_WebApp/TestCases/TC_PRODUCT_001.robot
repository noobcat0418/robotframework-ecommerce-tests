*** Comments ***
# TC_PRODUCT_001: Product Catalog - Display Verification
# Test suite for verifying product catalog display and completeness.

*** Settings ***
Documentation    Validates that the product catalog page displays all products correctly
...              with complete details including names, descriptions, prices, and images.

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
TC_008: Verify All Products Are Displayed On Catalog Page
    [Documentation]    Confirms all products are visible on the catalog page with required attributes.
    [Tags]    smoke    products    catalog

    Verify Products Are Displayed

TC_009: Verify Product Count Matches Expected Total
    [Documentation]    Validates that the total number of products matches the expected inventory count.
    [Tags]    smoke    products    catalog

    Verify Products Count    ${EXPECTED_PRODUCT_COUNT}

TC_010: Verify Each Product Has Complete Details
    [Documentation]    Verifies that every product listing includes name, description, price, and image.
    [Tags]    regression    products    catalog

    ${names}=    Get WebElements    ${INVENTORY_ITEM_NAME}
    ${descriptions}=    Get WebElements    ${INVENTORY_ITEM_DESC}
    ${prices}=    Get WebElements    ${INVENTORY_ITEM_PRICE}
    ${images}=    Get WebElements    ${INVENTORY_ITEM_IMAGE}
    ${product_count}=    Get Length    ${names}
    Should Be True    ${product_count} > 0    No products found on catalog page
    ${desc_count}=    Get Length    ${descriptions}
    ${price_count}=    Get Length    ${prices}
    ${img_count}=    Get Length    ${images}
    Should Be Equal As Numbers    ${desc_count}    ${product_count}
    Should Be Equal As Numbers    ${price_count}    ${product_count}
    Should Be True    ${img_count} >= ${product_count}
