*** Settings ***
Documentation    To have all the page objects and keywords
Library    SeleniumLibrary
Library    Collections
Resource    ../pageObjects/CommonResource.robot

*** Variables ***
${terms}        css:.checkbox label
${purchase}    css:[value='Purchase']

*** Keywords ***
enter the country and select terms
    [Arguments]    ${countryName}
    CommonResource.Wait Until Element Is Visible In The Page    country
    Input Text    country    ${countryName}
    Sleep    5
    CommonResource.Wait Until Element Is Visible In The Page    //a[text()='${countryName}']
    Click Element    //a[text()='${countryName}']
    Click Element    ${terms}

purchase the product and confirm the purchase
    Click Element    ${purchase}
    Page Should Contain    Success!