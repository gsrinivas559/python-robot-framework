*** Settings ***
Documentation    The resource file holds the common reusable keywords and variables
Library    SeleniumLibrary

*** Variables ***
${url}    https://rahulshettyacademy.com/loginpagePractise/
${userName}    rahulshettyacademy
${inValidPassword}    test123
${validPassword}    learning
${browserName}    Chrome

*** Keywords ***
open the browser with the automation practice page url
    Create Webdriver    ${browserName}
    Go To    ${url}
    Maximize Browser Window

close browser session
    Close Browser
    
wait until element is visible in the page
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}
