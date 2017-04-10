*** Settings ***
Suite Setup
Library           Selenium2Library
Library           BuiltIn
Library           Screenshot
Library           os
Library           AutoItLibrary
Library           Telnet

*** Variables ***
${URL}            http://192.168.1.69
${IP}             192.168.1.69
${OMC}            192.168.1.32    # 有效地址
${ID}             FFffffFF    # 测试设置ID
${name}           IIS_FC00
${soft-version}    V01.03.01.bin B2016-11-04 15:28:42
${IPtools-Dir}    C:\\Users\\iis\\Desktop\\discoverb.exe
${设备类型}           FC00_A1

*** Test Cases ***
login-test
    [Documentation]    *登录测试*
    ...    _验证异常名称字符_
    [Tags]    web
    [Setup]    打开浏览器
    [Template]
    登录测试    /    /    用户名密码不正确，请重新输入！
    登录测试    r的    ${EMPTY}    用户名密码不正确，请重新输入！
    登录测试    v 地方v上的地方赛迪网    32    用户名密码不正确，请重新输入！
    登录测试    2342 23    4    用户名密码不正确，请重新输入！
    登录测试    ${EMPTY}    ${SPACE}    用户名密码不正确，请重新输入！
    登录测试    RFID    Iis    用户名密码不正确，请重新输入！
    登录测试    Rfid    iis    用户名密码不正确，请重新输入！
    登录测试    !!!!!!!!!!!!!!!#@#@$#%$^%&*($##%#$%#$%$#%#$%#$5Rfid    :>$@#$?@#$?#?$%?#?$?#%$?#?%?$#    用户名密码不正确，请重新输入！
    [Teardown]    退出

NameAndID-config-test
    [Documentation]    *设备ID参数配置*
    ...    _ID位数输入值验证_
    ...    0-F十六进制，长度8位
    [Tags]    web
    [Setup]    登录
    [Timeout]    2 minutes 40 seconds
    ID配置    1234567890000    000000    [名称]必须以字母或汉字开头，包括字母、数字、下划线和汉字，不超过25个字符的字符串！    #数字
    ID配置    @#@....1234567890000    12345    [名称]必须以字母或汉字开头，包括字母、数字、下划线和汉字，不超过25个字符的字符串！    #字符
    ID配置    号    A    保存成功！
    ID配置    大1111111111111111111111111    12    [名称]必须以字母或汉字开头，包括字母、数字、下划线和汉字，不超过25个字符的字符串！    #名称超范围
    ID配置    好人    .02222222222222222222222222222222222222222222222222218585858585858585    [ID]最长为8位的十六进制数！    #ID超范围
    ID配置    好人    hllllfasfsdf是否    [ID]最长为8位的十六进制数！
    ID配置    k大手大脚地方哈绝对不会jasdd0...    1230456789    [名称]必须以字母或汉字开头，包括字母、数字、下划线和汉字，不超过25个字符的字符串！
    ID配置    k大手    ${ID}    保存成功！    #16进制
    ID配置    大好人    012345678    [ID]最长为8位的十六进制数！
    ID配置    ${name}    ${ID}    保存成功！
    ID配置    ${EMPTY}    ${EMPTY}    [ID]为必填项！
    [Teardown]    退出

IP-Config-test
    [Documentation]    *IP格式验证*
    ...    -IP格式验证-
    ...    常规检验
    [Tags]    web
    [Setup]    登录
    IP配置    12313    31231    313    [IP地址]请输入正确格式的IP!
    IP配置    大    12    大大    [IP地址]请输入正确格式的IP!
    IP配置    192.168.1.69    12    大大    [子网掩码]请输入正确格式的子网掩码!
    IP配置    192.168.1.69    255.255.0.0    大大    [默认网关]请输入正确格式的IP!
    IP配置    192.168.1.69    255.255.0.0    1.1.1.10.    [默认网关]请输入正确格式的IP!
    IP配置    192.168.1.69    255.255.0.0    1.1.1.10    保存成功！
    IP配置    ${IP}    255.255.0.0    192.168.1.1    保存成功！
    IP配置    ${EMPTY}    ${EMPTY}    ${EMPTY}    [IP地址]为必填项！
    IP配置    192.168.1.69    ${EMPTY}    ${EMPTY}    [子网掩码]为必填项！
    IP配置    ${IP}    255.255.0.0    ${EMPTY}    [默认网关]为必填项！
    [Teardown]    退出

NTP-Config-test
    [Documentation]    *NTP参数配置*
    ...    -NTP服务地址输入验证-
    [Setup]    登录
    NTP配置    133....33    33...    [首选IP地址]请输入正确格式的IP!
    NTP配置    1.1.1.1    33..    [备选IP地址]请输入正确格式的IP!
    NTP配置    19.0.0.0    19.0.23.0    [首选IP地址]undefined
    NTP配置    19.0.0.255    19.0.23.0    [首选IP地址]undefined
    NTP配置    1.0.0.1    1.0.23.255    [备选IP地址]undefined
    NTP配置    198.333.2255.666    2.0.3999.255    [首选IP地址]请输入正确格式的IP!
    NTP配置    1.0.0.1    1.0.23.0    [备选IP地址]undefined
    NTP配置    ${EMPTY}    ${EMPTY}    [首选IP地址]为必填项！
    NTP配置    192.168.1.32    ${EMPTY}    [备选IP地址]为必填项！
    [Teardown]    退出

ALM-time-test
    [Documentation]    *告警参数配置*
    ...    _告警输入值验证_
    ...    0为立即告警
    ...    其他数字（1-24小时）整数
    [Tags]    web
    [Setup]    登录
    ALM-time-配置    0.1    [超时时间]0-24之间的整数
    ALM-time-配置    有意义    [超时时间]0-24之间的整数
    ALM-time-配置    25    [超时时间]0-24之间的整数
    ALM-time-配置    0    保存成功！
    ALM-time-配置    24    保存成功！
    ALM-time-配置    1    保存成功！
    [Teardown]    退出

OMC-Config-test
    [Documentation]    *OMC服务地址配置*
    ...    _服务地址和端口验证_
    [Tags]    web
    [Setup]    登录
    服务配置（OMC）    133....33    33...    [IP地址]请输入正确格式的IP!
    服务配置（OMC）    1.1.1.1    0    [端口号]请填写4-5位数字！
    服务配置（OMC）    192.168.1.1    33...    [端口号]请填写4-5位数字！
    服务配置（OMC）    1.1.1.1    0023    [端口号]监听端口号数值有误，请在[1024,65535]选择一个，5083和8088端口除外！
    服务配置（OMC）    ${OMC}    5084    保存成功！
    服务配置（OMC）    ${OMC}    6084    保存成功！    #与OMC建链用
    [Teardown]    退出

Fan-speed-test
    [Documentation]    *风扇控制测试*
    ...    _风扇转速检测_
    [Tags]    web
    [Setup]    登录
    风扇测试
    [Teardown]    退出

login-Screenshot
    [Documentation]    *设备信息截图*
    [Tags]    web
    [Setup]    登录
    [Template]
    Wait Until Page Contains    重启
    take Screenshot    版本信息
    退出
    [Teardown]    退出

deviceInfo-test
    [Documentation]    *设备信息获取*
    ...    _设备状态获取_
    [Tags]    web
    [Setup]    登录
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
    [Teardown]    退出

版本查询
    [Documentation]    *设备版本查询*
    ...    _版本验证_
    [Tags]    web
    [Setup]    登录
    Wait Until Page Contains    版本信息
    ${text}    gettext    id=verNo
    log many    版本信息:${text}
    [Teardown]    退出

设备类型
    [Documentation]    *设备类型*
    ...    _设备类型查询_
    [Tags]    web
    [Setup]    登录
    Wait Until Page Contains    版本信息
    ${text}    gettext    id=eqptType
    log many    版本信息:${text}
    Should Be Equal As Strings    ${text}    FC00_A1
    [Teardown]    退出

硬件版本
    [Documentation]    *硬件版本*
    ...    _硬件版本查询_
    ...    代表生产时的硬件状态如PCB编号
    [Tags]    硬件版本0    web
    [Setup]    登录
    Wait Until Page Contains    版本信息
    ${text}    gettext    id=hardwareVerInfo
    log many    版本信息:${text}
    Should Be Equal As Strings    ${text}    0
    [Teardown]    退出

控制器信息获取
    [Documentation]    *控制器信息获取*
    ...    _ID/SN和MAC信息查询_
    [Tags]    web
    [Setup]    登录
    Wait Until Page Contains    机柜控制器信息
    ${txtECode}    getvalue    id=txtECode
    log    电子序列号：${txtECode}
    ${txtMac }    getvalue    id=txtMac
    log    MAC地址(HEX)：${txtMac }
    [Teardown]    退出

IP更改验证
    [Documentation]    *IP参数修改*
    ...    _默认设置192.168.1.69_
    ...    修改为192.168.1.233
    [Tags]    web
    [Setup]    登录
    Wait Until Page Contains    重启
    获取IP
    IP配置    192.168.1.233    255.255.255.0    192.168.1.1    保存成功！
    重启
    sleep    5
    [Teardown]    退出

IP更改恢复验证
    [Documentation]    *IP参数修改恢复*
    ...    _默认设置192.168.1.69_
    [Tags]    web
    [Setup]    open browser    http://192.168.1.233
    输入用户名    rfid
    输入密码    iis
    点击登录
    IP配置    ${IP}    255.255.255.0    192.168.1.1    保存成功！
    重启
    sleep    5
    [Teardown]    退出

ID更改验证
    [Documentation]    *ID参数修改*
    [Tags]    web
    [Setup]    登录
    wait until page contains    重启
    获取ID
    ID配置    test123    ABCD    保存成功！
    重启
    sleep    5
    登录
    sleep    3
    wait until page contains    重启
    ${txtID}    getvalue    id=txtID
    Should Be Equal As Strings    ${txtID}    ABCD
    log    ${txtID}
    [Teardown]    退出

ID更改恢复验证
    [Documentation]    *ID参数修改恢复*
    [Tags]    web
    [Setup]    登录
    wait until page contains    重启
    ID配置    ${name}    ${ID}    保存成功！
    重启
    sleep    5
    [Teardown]    退出

服务断链验证
    [Documentation]    *OMC链路验证*
    ...    _OMC服务开启，端口6084_
    ...    关闭链路，查看设备链路状态
    [Tags]    web
    [Setup]    登录
    Wait Until Page Contains    服务器设置
    服务配置（OMC）    ${OMC}    7784    保存成功！
    保存
    取消
    重启
    sleep    5
    登录
    Wait Until Page Contains    服务器设置
    ${text}    gettext    id=linkStatus
    log many    链路状态    :${text}
    Should Be Equal    ${text}    未连接
    [Teardown]    退出

服务断链恢复验证
    [Documentation]    *OMC链路验证*
    ...    _OMC服务开启，端口6084_
    ...    恢复链路，查看设备链路状态
    [Tags]    web
    [Setup]    登录
    Wait Until Page Contains    服务器设置
    服务配置（OMC）    ${OMC}    6084    保存成功！
    保存
    取消
    重启
    sleep    5
    登录
    Wait Until Page Contains    服务器设置
    ${text}    gettext    id=linkStatus
    log many    链路状态    :${text}
    Should Be Equal    ${text}    已连接
    [Teardown]    退出

温度传感器-外部
    [Documentation]    *外接的温度传感器温度采集*
    [Tags]    web
    [Setup]    登录
    comment    板上温度传感器测试
    Wait Until Page Contains    重启
    ${sensorTemp}    gettext    id=sensorTemp
    log    ${sensorTemp}
    run keyword if    ${sensorTemp}>=20    log    温度传感器不小于20°
    ...    ELSE IF    ${sensorTemp}<20    log    温度范围小于20°
    ...    ELSE    \    \    \    log
    [Teardown]    退出

温度传感器-外部不接传感器
    [Documentation]    *外部未接传感器-外传感器情况*
    [Tags]    web
    [Setup]    登录
    comment    板上温度传感器测试
    Wait Until Page Contains    重启
    ${sensorTemp}    gettext    id=sensorTemp
    log    ${sensorTemp}
    Should Be Equal As Strings    ${sensorTemp}    无传感器
    [Teardown]    退出

温度监控测试
    [Documentation]    *外接的温度传感器温度采集*
    [Tags]    web
    [Setup]    登录
    设备信息获取
    Wait Until Page Contains    重启
    Comment    传感器温度监控输出
    ${sensorTemp}    gettext    id=sensorTemp
    run keyword if    ${sensorTemp}==20    log    传感器温度20°
    ...    ELSE IF    20<=${sensorTemp}<=45    log    温度度范围20-45°
    ...    ELSE IF    45<=${sensorTemp}<=55    log    温度范围45°-55°
    ...    ELSE IF    55<=${sensorTemp}<=65    log    温度范围55°-65°
    ...    ELSE IF    65<=${sensorTemp}<=75    log    温度范围65°-75°
    ...    ELSE IF    75<=${sensorTemp}<=85    log    温度范围75°-85°
    ...    ELSE IF    ${sensorTemp}<-20    log    温度度低于-20°
    ...    ELSE IF    ${sensorTemp}<20    log    温度度低于20°
    ...    ELSE    log    comment
    ${text}    gettext    id=fanSpeed
    log    传感器温度：${sensorTemp}
    log    风扇转速:${text}
    take Screenshot
    [Teardown]    退出

温度传感器-片内
    [Documentation]    *单板上的温度传感器温度采集*
    [Tags]    web
    [Setup]    登录
    comment    板上温度传感器测试
    Wait Until Page Contains    重启
    ${eqptTemp}    gettext    id=eqptTemp
    log    ${eqptTemp}
    run keyword if    ${eqptTemp}>20    log    设备温度高于20°
    ...    ELSE    log    未知
    [Teardown]    退出

设备类型及测试版本确认
    [Documentation]    *设备类型和软件版本*
    ...    _验证设备类型、软件版本是否是正常_
    [Tags]    硬件版本：0    FC00_A1    web
    [Setup]    登录
    Wait Until Page Contains    版本信息
    ${text}    gettext    id=eqptType
    log many    设备类型:${text}
    Should Be Equal As Strings    ${text}    ${设备类型}
    ${text1}    gettext    id=hardwareVerInfo
    log many    硬件版本信息:${text1}
    Should Be Equal As Strings    ${text1}    0
    ${text2}    gettext    id=eqptType
    log many    设备类型:${text2}
    Should Be Equal As Strings    ${text2}    ${设备类型}
    ${text3}    gettext    id=verNo
    log many    软件版本信息:${text3}
    Should Be Equal As Strings    ${text3}    ${soft-version}
    [Teardown]    退出

门状态测试-关
    [Documentation]    *检测是否门被关闭*
    [Tags]    门-close    web
    [Setup]    登录
    Wait Until Page Contains    设备状态
    ${magState}    gettext    id=magState
    Should Be Equal As Strings    ${magState}    关
    [Teardown]    退出

门状态测试-开
    [Documentation]    *检测是否门被打开*
    [Tags]    门-open    web
    [Setup]    登录
    Wait Until Page Contains    设备状态
    ${magState}    gettext    id=magState
    Should Be Equal As Strings    ${magState}    开
    [Teardown]    退出

设备复位
    [Documentation]    *设备web页面软复位操做*
    [Tags]    web
    [Setup]
    登录
    wait until page contains    重启
    重启
    [Teardown]    退出

设置自动获取IP
    [Documentation]    *IP自动获取-需需接入DHCP服务*
    [Tags]    web
    [Setup]    登录
    wait until page contains    重启
    Select Checkbox    id=checkboxDHCP
    保存
    重启
    [Teardown]

版本升级
    [Documentation]    *使用IPtools工具进行版本升级*
    [Tags]    C/S
    [Setup]    登录
    [Teardown]

自动获取设备IP
    [Documentation]    *使用IPtools工具进行IP发现*
    [Tags]    C/S
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
