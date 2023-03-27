*** Settings ***
Documentation       Upload a PDF and get the result as csv.
Library    RPA.Browser.Selenium    auto_close=${FALSE}
Library             RPA.Tables
Library             html_tables.py
Library    RPA.PDF
Library    String


*** Tasks ***
Upload a PDF and get the result as csv
    Open Browser
    

*** Keywords ***
Open Browser
    
#Login to Delta Dental and input information

    Open Available Browser    https://identity.deltadental.com/provider/providers_loggedin.jsp
    Input Text    //*[@id="usernameInput"]    Asmile12
    Input Password    //*[@id="passwordInput"]    Dental123!@
    Click Button    //*[@id="btn-login"] 
    Input Text    //*[@id="usernameInput"]    Asmile12
    Set Selenium Timeout    15
    Wait Until Element Is Visible    //*[@id="BES-member_ID"]
    # Wait Until Element Contains    /*[@id="BES-member_ID"]    " "
    Input Text    //*[@id="BES-member_ID"]    987468913  
    Input Text    //*[@id="BES-member_DOB"]    07221972
    Input Text    //*[@id="BES-member_firstname"]    Zhilin
    Input Text    //*[@id="BES-member_lastname"]    CAO
    Click Button    //*[@id="tab-1"]/div/div[2]/form/div/div[9]/button 
    Set Selenium Timeout    15
    Wait Until Element Is Visible    xpath=/html/body/div/div/section[1]/div[2]/div[3]/div/div/div[2]
    # ${html_table}=    Get WebElements    //*[@id="tab-1"]/div[3]/div/div/div/div/div/div/table[1]
    
#Getting the web elements from the displayed information.

    ${html_table}=    Get Text    xpath=/html/body/div/div/section[1]/div[2]/div[3]/div/div/div[3]/div/div/div/div/div/div/table[1]/tbody
    ${Insurance_Company}=    Get Text    xpath=/html/body/div/div/section[1]/div[2]/div[3]/div/div/div[3]/div/div/div/div/div/div/table[1]/tbody/tr[1]/td[2]
    ${Insureds_Employer}=    Get Text    xpath=//*[@id="tab-1"]/div[3]/div/div/div/div/div/div/table[1]/tbody/tr[5]/td[2]
    ${Group_number}=    Get Text    xpath=/html/body/div/div/section[1]/div[2]/div[3]/div/div/div[3]/div/div/div/div/div/div/table[1]/tbody/tr[4]/td[2]
    ${Eff_Date}=    Get Text    xpath=/html/body/div/div/section[1]/div[2]/div[3]/div/div/div[3]/div/div/div/div/div/div/table[1]/tbody/tr[2]/td[2]
    ${Insurance_Number}=    Get Text    xpath=/html/body/div/div/section[1]/div[2]/div[3]/div/div/div[3]/div/div/div/div/div/div/div/table/tbody/tr[2]/td[2]
    ${Max}=    Get Text    xpath=/html/body/div/div/section[1]/div[2]/div[3]/div/div/div[3]/div/div/div/div/div/div/table[8]/tbody/tr[6]/td[2]/table
    ${Mail_To}=    Get Text    xpath=/html/body/div/div/section[1]/div[2]/div[3]/div/div/div[3]/div/div/div/div/div/div/table[1]/tbody/tr[7]/td[2]
    # ${address}=    Split String    ${Mail_To}    seperator='\n'    max_split=3
    ${address}=    Split To Lines    ${Mail_To}
    
    
    # Log    ${html_table}
    # ${table}=    Read Table From Html    ${html_table}
    # ${dimensions}=    Get Table Dimensions    ${table}
    # ${first_row}=    Get Table Row    ${table}    ${0}
    # ${first_cell}=    RPA.Tables.Get Table Cell    ${table}    ${0}    ${0}
    # FOR    ${row}    IN    @{table}
    #     Log To Console    ${row}
    # END  
    
    # Close All Browsers

#Filling the PDF file 

    Open Pdf    ins_adobeformat.pdf
    Set Field Value    field_name=Patient Name   value=Zhilin CAO
    Set Field Value    field_name=Insurance Company   value=${Insurance_Company}
    # Set Field Value    field_name=Insured Policy ID or SS    value=${Claim}
    Set Field Value    field_name=EFF Date    value=06/01/2021 
    Set Field Value    field_name=Single DED    value=1419
    Set Field Value    field_name=Max    value=1500
    # Set Field Value    field_name=Mail Claims to 1    value=${Mail Claims to 1}
    Set Field Value    field_name=Insureds Name    value=Zhilin CAO
    Set Field Value    field_name=Group Number   value=${Group_number}
    # Set Field Value    Group Number    222
    Set Field Value    Email address    csddic@delta.org
    Set Field Value    Insureds DOB    07/22/1972
    Set Field Value    Phone Number    800-521-2651
    Set Field Value    Patient DOB    07/22/1972
    Set Field Value    Insureds Employer    value=${Insureds_Employer}
    Set Field Value    Insurance Phone    value=${Insurance_Number}
    Set Field Value    Mail Claims To 1    value=${address}[0]
    Set Field Value    Mail Claims To 2    value=${address}[1]
    # Set Field Value    Verified By    Delta
    # Set Field Value    Max Family DED    value=N/A
    # Set Field Value    Ben Year    value=2023
    # Set Field Value    to    2024
    # Set Field Value    Single DED    value=1419
    # Set Field Value    DED Applies    50
    Set Field Value    field_name=Patient NameRow1    value=Zhilin CAO
    Set Field Value    field_name=Patient NameRow2    value=Zhilin CAO
    Set Field Value    field_name=Patient NameRow3    value=Zhilin CAO
    Set Field Value    DateRow1    01/04/2023
    Set Field Value    DateRow2    12/11/2013

#Save the PDF 

    Save Field Values        source_path=ins_adobeformat.pdf
    ...                      output_path= Output_filled.pdf
    ...                      use_appearances_writer=True
