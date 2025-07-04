*** Settings ***
Documentation    To have all the page objects and keywords
Library    SeleniumLibrary
Library    Collections
Resource    ../pageObjects/CommonResource.robot

*** Variables ***
${homePageLoaded}    css:.navbar-fixed-top a.navbar-brand
${checkout}    css:li.active a

*** Keywords ***
wait until element is visible in the page
    Sleep    5
    CommonResource.Wait Until Element Is Visible In The Page    ${homePageLoaded}

verify card titles in the page
#    list should start with @{} and @{} should only be used to create list and later when referring we have to use ${}
    @{expectedCardTitles} =    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${cardElements} =    Get Webelements    css:.card-title
    @{actualCardTitles} =    Create List
    FOR    ${element}    IN        @{cardElements}
        Log    ${element.text}
        Append To List    ${actualCardTitles}    ${element.text}
    END

    Lists Should Be Equal    ${actualCardTitles}    ${expectedCardTitles}

Select the card
    [Arguments]    ${cardName}
    ${cardElements} =    Get Webelements    css:.card-title
    ${index} =    Set Variable    1
     FOR    ${element}    IN        @{cardElements}
        Exit For Loop If   '${element.text}' == '${cardName}'
        ${index} =    Evaluate     ${index} + 1
     END
     Click Button    xpath:(//div[@class='card-footer'])[${index}]/button

is checkout page opened
    ${IsElementVisible}=  Run Keyword And Return Status    Element Should Not Be Visible    ${checkout}
    Run Keyword If    ${IsElementVisible}  checkout element is not present  ELSE  Click Element  ${checkout}