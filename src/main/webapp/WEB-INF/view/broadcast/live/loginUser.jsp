<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 현재 접속자 > 현재 접속 회원 -->
<div class="widget-table mb10">
    <div class="col-md-12 no-padding">
        <div class="col-md-12 no-padding pull-right mt5">
            <div class="col-md-2 no-padding pull-right">
                <table class="table table-sorting table-hover table-bordered">
                    <colgroup>
                        <col width="15%"/><col width="65%"/>
                    </colgroup>
                    <tr>
                        <td style="background-color: #dae3f3"></td><td>테스트 아이디</td>
                    </tr>
                </table>
            </div>
        </div>
        <table id="loginUser_tableList" class="table table-sorting table-hover table-bordered datatable">
            <thead id="tableTop_detail">
            </thead>
            <tbody id="tableBody_detail">
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript" src="/js/code/connect/connectCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    $("#loginUserType").html(util.getCommonCodeSelect(1, currentType,"Y"));

    $(function(){

    });

    var slctType = 1;

    var dtList_info_loginUser;
    function getLoginUserList_tabClick(tmp){
        $("#selJoinDate").hide();
        liveState = tmp;
        if(liveState == 4){
            $("#divLive").hide();
            $("#divLiveListen").hide();
            $("#divLiveGuest").hide();
            $("#divLivelogin").show();
            $("#seldate").hide();
        }
        var dtList_data = function (data) {
            data.slctType = slctType;
            data.pageCnt = 100;
            data.searchText = $("#searchText").val();
            data.inner = -1;
            data.broad = 0;
            data.newSearchType = slctType == 1 ? $("#searchMember").val() : $("#searchBroad").val();
        };
        dtList_info_loginUser = new DalbitDataTable($("#loginUser_tableList"), dtList_data, BroadcastDataTableSource.loginUser);
        dtList_info_loginUser.setPageLength(100);
        dtList_info_loginUser.useCheckBox(false);
        dtList_info_loginUser.useIndex(true);
        dtList_info_loginUser.createDataTable(loginNextFunc);

        livePageTabCount();
    }

    function loginNextFunc(json){
        var template = $("#loginUser_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
        };
        var html = templateScript(data);
        $("#login_summaryArea").html(html);
    }

</script>


<script id="loginUser_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right no-margin" style="width: 100%">
        <tr>
            <th colspan="6" style="background-color: #2f5597;color: white">방송방 외 접속회원</th>
        </tr>
        <tr>
            <th colspan="3" style="background-color: #d9d9d9;color: black">플랫폼</th>
            <th colspan="3" style="background-color: #d9d9d9;color: black">성별</th>
        </tr>
        <tr>
            <td style="background-color: #dae3f3" class="font-bold">Android</td>
            <td style="background-color: #dae3f3" class="font-bold">IOS</td>
            <td style="background-color: #dae3f3" class="font-bold">PC</td>
            <td style="background-color: #dae3f3">{{{sexIcon 'm'}}}</td>
            <td style="background-color: #dae3f3">{{{sexIcon 'f'}}}</td>
            <td style="background-color: #dae3f3">{{{sexIcon 'n'}}}</td>
        </tr>
        <tr>
            <td>{{addComma content.aosCnt}}</td>
            <td>{{addComma content.iosCnt}}</td>
            <td>{{addComma content.pcCnt}}</td>
            <td>{{addComma content.maleCnt}}</td>
            <td>{{addComma content.femaleCnt}}</td>
            <td>{{addComma content.noneCnt}}</td>
        </tr>
        <tr>
            <td colspan="6" class="font-bold" style="background-color: #7f7f7f;color: white">총 수 {{addComma content.totalCnt}}</td>
        </tr>
    </table>
</script>