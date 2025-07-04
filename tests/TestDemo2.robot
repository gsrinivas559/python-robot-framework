*** Settings ***
Documentation    To validate the login form using common resource file
Library    SeleniumLibrary
Library    Collections
Test Setup    open the browser with the automation practice page url
Test Teardown    close browser session
Resource    ../pageObjects/CommonResource.robot

*** Variables ***
${loginForm}    id:login-form
${alert}    css:.alert-danger
${homePageLoaded}    css:.navbar-fixed-top a.navbar-brand

*** Test Cases ***
Validate UnSuccessful login
    [Tags]    SMOKE
    Wait Until Element Is Visible In The Page    ${loginForm}
    fill the login form    ${userName}    ${inValidPassword}
    Wait Until Element Is Visible In The Page    ${alert}
    verify error message is correct

Validate mobile cards displayed in the shopping page
    Fill The Login Form    ${userName}    ${validPassword}
    Wait Until Element Is Visible In The Page    ${homePageLoaded}
    Verify card titles in the page
    Select the card    Nokia Edge

Validate the login functionality
    Fill the login form details

*** Keywords ***
fill the login form
#    arguments should always be declared in 1st line 
    [Arguments]    ${userName}    ${password}
    Input Text        id:username    ${userName}
    Input Password    id:password    ${password}
#    id: or css: or xpath: are optional
    Click Button    signInBtn

wait until element is visible in the page
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}
    
verify error message is correct
#    2 ways to validate
#    Method-1
#    ${alertMessage} =     Get Text    css:.alert-danger
#    Should Be Equal As Strings    ${alertMessage}    Incorrect username/password.
#    Method-2
    Element Text Should Be    ${alert}    Incorrect username/password.

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
    
Fill the login form details
    Input Text        id:username    rahulshettyacademy
    Input Password    id:password    learning
    Click Element    css:input[value='user']
    Wait Until Element Is Visible In The Page    css:.modal-body
    Click Element    css:#okayBtn
    Wait Until Element Is Not Visible    css:.modal-body
    Select From List By Label    css:select.form-control    Teacher
    Select Checkbox    terms
    Checkbox Should Be Selected    terms
    
    
    
    
    
    
    
    
    
    
    
    
    