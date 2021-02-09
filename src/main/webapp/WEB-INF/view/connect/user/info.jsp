<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="row col-lg-12 form-inline">
            <div class="widget widget-table searchBoxArea">
                <table>
                    <tr>
                        <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                            <i class="fa fa-search"></i><br/>검색
                        </th>
                        <td style="text-align: left">
                            <span id="searchMemberArea" onchange="getCurrenList();"></span>
                            <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색어를 입력해주세요." ></label>

                            <button type="button" class="btn btn-success" id="bt_search">검색</button>

                            <span id="searchCheck">
                                <label class="control-inline fancy-checkbox custom-color-green">
                                    <input type="checkbox" name="search_testId" id="search_testId" value="1" checked="true">
                                    <span>테스트 아이디 제외</span>
                                </label>
                            </span>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="row col-lg-12">
            <div class="widget widget-table mb10">
                <div class="widget-header">
                    <h3><i class="fa fa-table"></i> 현재 접속자 통계 현황</h3>
                </div>
                <div class="col-md-9 no-padding">
                    <div class="widget-content no-padding mt10 mr10 ml10">
                        <jsp:include page="total.jsp"/>
                    </div>

                    <div class="widget-content no-padding mt10 mr10 ml10">
                        <table class="table table-bordered">
                            <colgroup>
                                <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/>
                                <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/>
                            </colgroup>
                            <thead>
                            <tr>
                                <th style="background-color: #ebccd1; color:red;">◈ 성별</th>
                                <th style="background-color: #ffe699">실시간</th>
                                <th>전일</th>
                                <th>증감</th>
                                <th>주간</th>
                                <th>전주</th>
                                <th>증감</th>
                                <th>월간</th>
                                <th>전월</th>
                                <th>증감</th>
                            </tr>
                            </thead>
                            <tbody id="loginLiveTableBody"></tbody>
                        </table>
                    </div>
                </div>
                <div class="col-md-3 no-padding">
                    <div class="widget-content no-padding mt10 mr10 ml10">
                        <table style="width:100%">
                            <colgroup>
                                <col width="70%"/>
                                <col width="30%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th class="_bgColor" data-bgColor="#dae3f3">IP</th>
                                    <th class="_bgColor" data-bgColor="#dae3f3">접속자 수</th>
                                </tr>
                            </thead>
                            <tbody id="ipTableInfo"></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="no-padding col-lg-12" id="infoTab">
            <jsp:include page="infoTab.jsp"/>
        </div>
    </div> <!-- // wrapper -->
</div>

<jsp:include page="../../searchArea/daySearchFunction.jsp"/>

<script type="text/javascript" src="/js/code/enter/joinCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/util/statUtil.js?${dummyData}"></script>

<script type="text/javascript">
    $(function() {

        $("#searchMemberArea").html(util.getCommonCodeSelect(1, searchMember));

        //현재 접속자 통계 현황
        getLoginLiveInfo();


        $('#searchText').on('keydown', function(e) {
            if (e.keyCode === 13) {
                $("#bt_search").click();
            };
        });
    });

    function getLoginLiveInfo(){
        util.getAjaxData("infoLive", "/rest/connect/login/info/live", null, fn_loginLive_success);
    }

    function fn_loginLive_success(data, response){
        $("#loginLiveTableBody").empty();

        var template = $('#tmp_loginLive').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.loginLive;
        var html=templateScript(context);
        $("#loginLiveTableBody").append(html);


        var template = $('#tmp_ipTableInfo').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.currentDuplIpInfo;
        var html=templateScript(context);
        $("#ipTableInfo").append(html);

    }

    $(document).on('click', '._ipSearch', function(){
       $("#searchText").val($(this).text());
        $("#searchMember").val(6);
       $("#bt_search").click();
    });

</script>

<script type="text/x-handlebars-template" id="tmp_loginLive">
    <tr style="color: blue">
        <th>{{{sexIcon 'm'}}}</th>
        <td style="background-color: #fff2cc">{{addComma m_now_cnt}}</td>
        <td>{{addComma m_yes_cnt}}</td>
        <td class="{{upAndDownClass m_now_inc_cnt}}"><i class="fa {{upAndDownIcon m_now_inc_cnt}}"></i> {{addComma m_now_inc_cnt}}</td>
        <td>{{addComma m_week_cnt}}</td>
        <td>{{addComma m_bweek_cnt}}</td>
        <td class="{{upAndDownClass m_week_inc_cnt}}"><i class="fa {{upAndDownIcon m_week_inc_cnt}}"></i> {{addComma m_week_inc_cnt}}</td>
        <td>{{addComma m_month_cnt}}</td>
        <td>{{addComma m_bmonth_cnt}}</td>
        <td class="{{upAndDownClass m_month_inc_cnt}}"><i class="fa {{upAndDownIcon m_month_inc_cnt}}"></i> {{addComma m_month_inc_cnt}}</td>
    </tr>
    <tr style="color: red">
        <th>{{{sexIcon 'f'}}}</th>
        <td style="background-color: #fff2cc">{{addComma f_now_cnt}}</td>
        <td>{{addComma f_yes_cnt}}</td>
        <td class="{{upAndDownClass f_now_inc_cnt}}"><i class="fa {{upAndDownIcon f_now_inc_cnt}}"></i> {{addComma f_now_inc_cnt}}</td>
        <td>{{addComma f_week_cnt}}</td>
        <td>{{addComma f_bweek_cnt}}</td>
        <td class="{{upAndDownClass f_week_inc_cnt}}"><i class="fa {{upAndDownIcon f_week_inc_cnt}}"></i> {{addComma f_week_inc_cnt}}</td>
        <td>{{addComma f_month_cnt}}</td>
        <td>{{addComma f_bmonth_cnt}}</td>
        <td class="{{upAndDownClass f_month_inc_cnt}}"><i class="fa {{upAndDownIcon f_month_inc_cnt}}"></i> {{addComma f_month_inc_cnt}}</td>
    </tr>
    <tr>
        <th>알수없음</th>
        <td style="background-color: #fff2cc">{{addComma n_now_cnt}}</td>
        <td>{{addComma n_yes_cnt}}</td>
        <td class="{{upAndDownClass n_now_inc_cnt}}"><i class="fa {{upAndDownIcon n_now_inc_cnt}}"></i> {{addComma n_now_inc_cnt}}</td>
        <td>{{addComma n_week_cnt}}</td>
        <td>{{addComma n_bweek_cnt}}</td>
        <td class="{{upAndDownClass n_week_inc_cnt}}"><i class="fa {{upAndDownIcon n_week_inc_cnt}}"></i> {{addComma n_week_inc_cnt}}</td>
        <td>{{addComma n_month_cnt}}</td>
        <td>{{addComma n_bmonth_cnt}}</td>
        <td class="{{upAndDownClass n_month_inc_cnt}}"><i class="fa {{upAndDownIcon n_month_inc_cnt}}"></i> {{addComma n_month_inc_cnt}}</td>
    </tr>
    <tr>
        <th>합계</th>
        <td style="background-color: #fff2cc">{{addComma t_now_cnt}}</td>
        <td>{{addComma t_yes_cnt}}</td>
        <td class="{{upAndDownClass t_now_inc_cnt}}"><i class="fa {{upAndDownIcon t_now_inc_cnt}}"></i> {{addComma t_now_inc_cnt}}</td>
        <td>{{addComma t_week_cnt}}</td>
        <td>{{addComma t_bweek_cnt}}</td>
        <td class="{{upAndDownClass t_week_inc_cnt}}"><i class="fa {{upAndDownIcon t_week_inc_cnt}}"></i> {{addComma t_week_inc_cnt}}</td>
        <td>{{addComma t_month_cnt}}</td>
        <td>{{addComma t_bmonth_cnt}}</td>
        <td class="{{upAndDownClass t_month_inc_cnt}}"><i class="fa {{upAndDownIcon t_month_inc_cnt}}"></i> {{addComma t_month_inc_cnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_ipTableInfo">
    {{#each this}}
        <tr>
            <td><a href="javascript://" class="_ipSearch">{{ip}}</a></td>
            <td>{{ipCnt}}</td>
        </tr>
    {{/each}}
</script>