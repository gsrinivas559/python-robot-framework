*** Settings ***
Documentation    To have all the page objects and keywords
Library    SeleniumLibrary
Library    Collections
Resource    ../pageObjects/CommonResource.robot

*** Variables ***
${homePageLoaded}    css:.navbar-fixed-top a.navbar-brand
${checkoutProducts}    css:h4.media-heading a
${checkoutButton}    css:button.btn-success

*** Keywords ***
verify items in the checkout page and proceed
    [Arguments]    ${expectedCheckoutProductsList}
    Sleep    5
#    CommonResource.wait until element is visible in the page    ${checkoutProducts}
    @{actualProducts}    Create List
    ${products} =    Get Webelements    ${checkoutProducts}
#    FOR    ${element}    IN        @{products}
#        Log    ${element.text}
#        Append To List    ${actualProducts}    ${element.text}
#    END
    FOR    ${product}    IN    @{products}
        Append To List    ${actualProducts}    ${product.text}
    END
    Lists Should Be Equal    ${actualProducts}    ${expectedCheckoutProductsList}
    Click Element    ${checkoutButton}

    