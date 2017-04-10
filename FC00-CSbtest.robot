*** Settings ***
Suite Setup
Library           Selenium2Library
Library           BuiltIn
Library           Screenshot
Library           os
Library           AutoItLibrary
Library           Telnet

*** Variables ***
${soft-version}    V01.03.01.bin B2016-11-04 15:28:42
${IPtools-Dir}    C:\\Users\\iis\\Desktop\\discoverb.exe

*** Test Cases ***
版本升级
    [Documentation]    *设备版本查询*
    ...    _版本验证_
    [Tags]
    [Setup]    登录
    [Teardown]    退出

自动获取设备IP
    [Documentation]    *IP自动获取-需需接入DHCP服务*
    [Setup]    登录
    [Teardown]

*** Keywords ***
打开浏览器
    Open Browser    ${URL}    ff

输入用户名
    [Arguments]    ${user}
    [Tags]    smoke
    inputtext    id=userNameId    ${user}

输入密码
    [Arguments]    ${pwd}
    inputtext    id=passWordId    ${pwd}

点击登录
    click element    id=loginBtn

验证
    [Arguments]    ${inf}
    page should contain    ${inf}

版本查询
    [Arguments]    ${Version}
    clicklink    版本管理
    clicklink    版本查询
    page should contain    ${Version}

点击链接
    [Arguments]    ${text}
    click link    ${text}

点击元素
    [Arguments]    ${name}
    clickelement    ${name}

登录测试
    [Arguments]    ${name}    ${pwd}    ${text}
    输入用户名    ${name}
    输入密码    ${pwd}
    点击登录
    验证    ${text}

退出
    close browser

登录
    打开浏览器
    输入用户名    rfid
    输入密码    iis
    点击登录

验证不含
    [Arguments]    ${not inf}
    page should not contain    ${not inf}

登录测试-验证包含
    [Arguments]    ${name}    ${pwd}    ${text}
    打开浏览器
    sleep    1
    输入用户名    ${name}
    输入密码    ${pwd}
    点击登录
    验证    ${text}
    退出
    sleep    1

ID配置
    [Arguments]    ${txtName}    ${txtID}    ${text}
    Wait Until Page Contains    ID设置
    inputtext    id=txtName    ${txtName}
    inputtext    id=txtID    ${txtID}
    保存
    Wait Until Page Contains    ${text}

IP配置
    [Arguments]    ${txtIp}    ${txtSub}    ${txtGw}    ${text}
    Wait Until Page Contains    IP设置
    inputtext    id=txtIp    ${txtIp}
    inputtext    id=txtSub    ${txtSub}
    inputtext    id=txtGw    ${txtGw}
    保存
    Wait Until Page Contains    ${text}

NTP配置
    [Arguments]    ${txtNtpIp1}    ${txtNtpIp2}    ${text}
    Wait Until Page Contains    NTP服务设置
    inputtext    id=txtNtpIp1    ${txtNtpIp1}
    inputtext    id=txtNtpIp2    ${txtNtpIp2}
    保存
    Wait Until Page Contains    ${text}

服务配置（OMC）
    [Arguments]    ${txtOmcIp}    ${txtOmcPort}    ${text}
    Wait Until Page Contains    服务器设置
    inputtext    id=txtOmcIp    ${txtOmcIp}
    inputtext    id=txtOmcPort    ${txtOmcPort}
    保存
    Wait Until Page Contains    ${text}
    sleep    1

保存
    click button    id=saveBtn

取消
    click button    id=cancleBtn

重启
    click button    id=resetBtn
    sleep    2
    Choose Ok On Next Confirmation
    Confirm action
    Wait Until Page Contains    重启成功，请稍候重新登陆。
    退出

风扇测试
    Wait Until Page Contains    设备状态
    click button    id=testFanBtn
    click button    id=cancleBtn
    sleep    5
    取消
    sleep    8
    取消
    ${text}    gettext    id=fanSpeed
    log    ${text}
    take Screenshot
    sleep    5
    取消
    ${text}    gettext    id=fanSpeed
    log    ${text}
    runkey word if    ${text}>0    log    风扇转速：${text}
    ...    ELSE    log    风扇未启动或故障

获取IP
    Wait Until Page Contains    IP设置
    ${txtIp}    getvalue    id=txtIp
    log    设备IP：${txtIp}
    ${txtSub }    getvalue    id=txtSub
    log    掩码：${txtSub }
    ${txtGw }    getvalue    id=txtGw
    log    网关：${txtGw }

获取ID
    Wait Until Page Contains    ID设置
    ${txtName}    getvalue    id=txtName
    log    设备名称：${txtName }
    ${txtID}    getvalue    id=txtID
    log    设备ID：${txtID}

设备信息获取
    Wait Until Page Contains    设备状态
    ${text}    gettext    id=fanSpeed
    log many    风扇转速(r/min):${text}
    ${text}    gettext    id=eqptTemp
    log many    设备温度(℃):${text}
    ${text}    gettext    id=sensorTemp
    log many    传感器温度(℃):${text}
    ${text}    gettext    id=magState
    log many    门磁状态:${text}
    ${text}    gettext    id=verNo
    log many    版本信息:${text}
    ${text}    gettext    id=linkStatus
    log many    链路状态    :${text}
    ${text}    gettext    id=eqptType
    log many    设备类型：${text}
    ${text}    gettext    id=hardwareVerInfo
    log many    硬件版本信息:${text}
    ${text}    gettext    id=ntpTime
    log many    NTP同步时间    :${text}
    ${text}    gettext    id=ntpFirstAddr
    ${text2}    gettext    id=ntpFirstAddrStatus
    log many    NTP同步时间:${text}:${text2}
    ${text}    gettext    id=ntpSecondAddr
    ${text2}    gettext    id=ntpSecondAddrStatus
    log many    NTP同步时间:${text}:${text2}

ALM-time-配置
    [Arguments]    ${time}    ${text}
    Wait Until Page Contains    重启
    inputtext    id=txtTimeOutAlarm    ${time}
    保存
    Wait Until Page Contains    ${text}
