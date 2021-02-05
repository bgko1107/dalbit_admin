<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- table -->
<div class="col-lg-12 no-padding">
    <div class="widget-content">
        <div class="col-md-12 no-padding mt10 mb10">
            <div class="col-md-2 no-padding">
                <span id="memberDataList_searchType" onchange="memberDataList_searchType_click();"></span>
            </div>
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
        <div class="col-md-12 no-padding">
            <div class="dataTables_paginate paging_full_numbers" id="memberData_paginate_top"></div>
            <table id="memberDataTable" class="table table-sorting table-hover table-bordered mt10">
                <colgroup>
                    <col width="3%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
                    <col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
                    <col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
                    <col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="_bgColor _fontColor" data-bgColor="#416dbb" data-fontColor="white">No</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">회원No</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">성별(나이)</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">총 방송 시간</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">총 청취 시간</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">클립 등록<br/>(삭제)</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">결제금액</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">결제취소</th>
                    <th class="_bgColor" data-bgColor="#8faadc">총 지급 달<br/>(결제+무료+선물)</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">무료 지급 달</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">사용 달</th>
                    <th class="_bgColor" data-bgColor="#8faadc">잔여 달</th>
                    <th class="_bgColor" data-bgColor="#f4b183">총 획득 별<br/>(아이템+무료+환전취소)</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">무료지급 별</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">교환</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">환전승인</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">환전금액</th>
                    <th class="_bgColor" data-bgColor="#f4b183">잔여 별</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">최근 접속 일자</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">가입일자</th>
                </tr>
                </thead>
                <tbody id="tb_memberDataList">
                </tbody>
            </table>
            <div class="dataTables_paginate paging_full_numbers" id="memberData_paginate"></div>
        </div>
    </div>
</div>
<!-- //table -->

<script type="text/javascript" src="/js/code/money/resourceCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var memberDataPagingInfo = new PAGING_INFO(0,1,100);

    $(document).ready(function() {
        $("#memberDataList_searchType").html(util.getCommonCodeSelect(-1, memberDataList_searchType));
        // memberDataList();
    });

    function memberDataListTabClick(){
        $("#searchMemberArea").show();
        tabType = 3;
        slctType = 99;
        dateType(slctType);
        $("#resourceState").hide();
        $("._prevSearch").hide();
        $("._todaySearch").hide();
        $("._nextSearch").hide();
        $("#div_input").hide();

        $("#searchText").show();
        $("#searchCheck").show();
        $("#liveResourceData").hide();
        // memberDataList();
    }

    function memberDataList(pagingInfo) {
        if(!common.isEmpty(pagingInfo)){
            memberDataPagingInfo.pageNo = pagingInfo;
        }else{
            memberDataPagingInfo.pageNo = 1;
        }

        var data = {
            'pageNo': memberDataPagingInfo.pageNo
            , 'pageCnt' : 100
            // , 'searchText' : $('#txt_search').val()
            // , 'sDate' : $("#startDate").val()
            // , 'eDate' : $("#endDate").val()
            , 'searchText' : $("#searchText").val()
            , 'slctType' : $('input[name="searchCheck"]').is(":checked") ? "1" : "0"
            , 'orderType' : $("select[name='memberDataList']").val()
            , 'newSearchType' : $("#searchMember").val()
        };

        util.getAjaxData("memberDataList", "/rest/money/resource/memberDataList", data, fn_success_memberDataList);

    }

    function fn_success_memberDataList(dst_id, response, param) {

        response.data.detailList.totalCnt = response.data.totalInfo.totalCnt;

        var template = $('#tmp_memberDataTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.detailList;
        var html = templateScript(context);

        $('#tb_memberDataList').html(html);

        memberDataPagingInfo.totalCnt = response.data.totalInfo.totalCnt;
        util.renderPagingNavigation('memberData_paginate_top', memberDataPagingInfo);
        util.renderPagingNavigation('memberData_paginate', memberDataPagingInfo);

        if(response.data.length == 0) {
            $("memberDataList").find("#memberData_paginate_top").hide();
            $("memberDataList").find('#memberData_paginate').hide();
        } else {
            $("memberDataList").find("#memberData_paginate_top").show();
            $("memberDataList").find('#memberData_paginate').show();
        }
    }

    function memberDataList_searchType_click(){
        memberDataPagingInfo.pageNo = 1;
        memberDataList();
    }

</script>

<script id="tmp_memberDataTable" type="text/x-handlebars-template">
    {{#each this as |data|}}
    <tr {{#dalbit_if inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
    <td>{{indexDesc ../totalCnt rowNum}}</td>
    <td>
        {{{memNoLink mem_no mem_no}}}<br/>
        {{memNick}}
    </td>
    <td {{#dalbit_if memSex '==' 'm'}} style="color:blue" {{/dalbit_if}}
    {{#dalbit_if memSex '==' 'f'}} style="color:red" {{/dalbit_if}}>
    {{{sexIcon memSex}}}({{memAge}})<br/>
    <span style="color: #333333;">{{getMemStateName memState}}</span>
    </td>
    <td>{{timeStampDay airtime}}</td>
    <td>{{timeStampDay listentime}}</td>
    <td>
        {{#dalbit_if castcount '!=' 0}}
        {{addComma castcount}} ({{addComma castDelcount}})
        {{/dalbit_if}}
        {{#dalbit_if castcount '==' 0}}
            {{#dalbit_if castDelcount '!=' 0}}
                0 ({{addComma castDelcount}})
            {{/dalbit_if}}
        {{/dalbit_if}}
    </td>
    <td>{{addComma payAmt}}원</td>
    <td>{{addComma cancelAmt}}원</td>
    <td style="background-color: #dae3f3">{{addComma totalDal}}개</td>
    <td>{{addComma freeDal}}개</td>
    <td>{{addComma useDal}}개</td>
    <td style="background-color: #dae3f3">{{addComma nowDal}}개</td>
    <td style="background-color: #fbe5d6">{{addComma totalByeol}}개</td>
    <td>{{addComma freeByeol}}개</td>
    <td>{{addComma changeByeol}}개</td>
    <td>{{addComma exchangeByeol}}개</td>
    <td>{{addComma exchangeAmt}}원</td>
    <td style="background-color: #fbe5d6">{{addComma nowByeol}}개</td>
    <td>{{memLoginDate}}</td>
    <td>{{memJoinDateFormat}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="20">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>