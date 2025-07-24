*** Settings ***
Library    Collections
Library    RequestsLibrary

*** Variables ***
# alternate base_url - http://216.10.245.166
${base_url}    https://rahulshettyacademy.com
${book_id}
${book_name}    RobotFramework
*** Test Cases ***
Play around dictionary
    [Tags]    API
    &{data}=    Create Dictionary    name=Srinivas    course=RobotFramework    platform=Udemy
    Log    ${data}
    Dictionary Should Contain Key    ${data}    name
    # 2 ways to fetch value from dict using key
    # Method 1
    Log    ${data}[name] 
    # Method 2
    ${courseName}=    Get From Dictionary    ${data}    course
    Log    ${courseName}

Add book into library database
    [Tags]    API
    # each time when we run, we have to change isbn or aisle values to add the book
    # we are not handling random way as of now, if we run with same data then we get Book Already Exists
    &{req_body}=    Create Dictionary    name=${book_name}    isbn=121221    aisle=12314567    author=Srinivas
    ${response}=    POST    ${base_url}/Library/Addbook.php    json=${req_body}    expected_status=200
    Log    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}    ID
    ${book_id}=    Get From Dictionary    ${response.json()}    ID
    Set Global Variable    ${book_id}
    Log    ${book_id}
    Should Be Equal As Strings    successfully added    ${response.json()}[Msg]
    Status Should Be    200    ${response}

Get book details which got added
    [Tags]    API
    ${get_response}=    GET    ${base_url}/Library/GetBook.php   params=ID=${book_id}    expected_status=200
    Log    ${get_response.json()}
    # we get response in list of dictionaries
    # [{'book_name': 'RobotFramework', 'isbn': '121221', 'aisle': '124567', 'author': 'Srinivas'}]
    # To check bookname, we have to get value from 0 index from list which would be dictionary
    # from dict, we can perform validation
    Should Be Equal As Strings    ${book_name}    ${get_response.json()}[0][book_name]

Delete the book from database
    [Tags]    API
    &{delete_req}=    Create Dictionary    ID=${book_id}
    ${delete_response}=    POST    ${base_url}/Library/DeleteBook.php    json=${delete_req}    expected_status=200
    Log    ${delete_response.json()}
    Should Be Equal As Strings    book is successfully deleted    ${delete_response.json()}[msg]