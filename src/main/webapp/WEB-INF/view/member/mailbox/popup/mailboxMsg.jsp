<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div class="col-md-12 no-padding">
    <div class="widget-content">
        <div class="widget-content mt10 col-md-12 no-padding">
            <table class="table table-sorting table-hover table-bordered">
                <tr>
                    <th>우체통No</th>
                    <td><span id="chat_no"></span></td>
                </tr>
                <tr>
                    <th rowspan="2">대화참여자 (2명)</th>
                    <td id="mailboxMember"></td>
                </tr>
                <tr>
                    <th>
                        (※<span class="font-bold" style="border-radius: 5px 5px 5px 5px; background-color: red;color: white; display:inline-block;width:38px;height:16px;">0</span>는 미확인 대화 내용의 수치를 표기한 정보입니다)
                    </th>
                </tr>
            </table>
        </div>

        <div class="row col-lg-12 form-inline">
            <div class="widget widget-table searchBoxArea">
                <table>
                    <tr>
                        <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                            <i class="fa fa-search"></i><br/>검색
                            <jsp:include page="../../../searchArea/daySearchFunction.jsp"/>
                        </th>
                    </tr>
                    <tr>
                        <td style="text-align: left">
                            <jsp:include page="../../../searchArea/dateRangeSearchArea.jsp"/>
                            <input type="hidden" name="startDate" id="startDate">
                            <input type="hidden" name="endDate" id="endDate" />

                            <%--<input name="startDate" id="startDate">--%>
                            <%--<input name="endDate" id="endDate" />--%>

                            <label><input type="text" class="form-control" id="txt_search" placeholder="검색할 정보를 입력하세요"></label>
                            <button type="button" class="btn btn-success" id="bt_search">검색</button>
                            <a href="javascript://" class="_prevSearch">[이전]</a>
                            <a href="javascript://" class="_todaySearch">[오늘]</a>
                            <a href="javascript://" class="_nextSearch">[다음]</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="col-md-2 no-padding">
            <select id="msgType" name="msgType" class="form-control" style="width: 130px">
                <option value="0">대화내용(전체)</option>
                <option value="1">대화 만</option>
                <option value="3">선물 만</option>
                <option value="2">이미지 만</option>
            </select>
        </div>
        <div class="widget-content mt10 col-md-12 no-padding">
            <div class="dataTables_paginate paging_full_numbers" id="mailbox_paginate_top"></div>
            <table id="list_info" class="table table-sorting table-hover table-bordered">
                <colgroup>
                    <col width="16%"><col width="12%"><col width="30%"><col width="10%"><col width="16%">
                    <col width="7%">
                </colgroup>
                <thead>
                <tr>
                    <th>작성자</th>
                    <th>성별</th>
                    <th>내용</th>
                    <th>기간</th>
                    <th>일시</th>
                    <th>상태</th>
                </tr>
                </thead>
                <tbody id="tableBody">

                </tbody>
            </table>
            <div class="dataTables_paginate paging_full_numbers" id="mailbox_paginate"></div>
        </div>
    </div>
</div>

<script>
    var mailboxPagingInfo = new PAGING_INFO(0,1,50);

    $("#bt_search").on('click', function(){
        mailboxPagingInfo.pageNo = 1;
        msgList();
    });
    $(document).ready(function() {
        slctType = 3;
        dateType();

        $("#chat_no").html('${param.chatNo}');
    });

    function msgList(pagingNo){
        if(!common.isEmpty(pagingNo)){
            mailboxPagingInfo.pageNo = pagingNo;
        }else{
            mailboxPagingInfo.pageNo = 1;
        }

        var data = new Object();
        data.chat_no = '${param.chatNo}';
        data.startDate = $("#startDate").val() + " 00:00:00";
        data.endDate = $("#endDate").val() + " 23:59:59";
        data.inner = $('input[name="search_testId"]').is(":checked") ? "0" : "-1";
        data.searchText = common.isEmpty($("#searchText").val()) ? "" : $("#searchText").val();
        data.pageNo = mailboxPagingInfo.pageNo;
        data.pageCnt = mailboxPagingInfo.pageCnt;
        data.msgType = $("#msgType").val();

        console.log(data);
        util.getAjaxData("mailboxMsg", "/rest/member/mailbox/msg", data, fn_list_success);
    }

    function fn_list_success(dst_id, response){
        var template = $('#tmp_list').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.list;
        var html=templateScript(context);
        $("#tableBody").html(html);

        if(response.result == 'success'){
            $('#mailbox_paginate_top').show();
            $('#mailbox_paginate').show();
            mailboxPagingInfo.totalCnt = response.pagingVo.totalCnt;
            util.renderPagingNavigation('mailbox_paginate_top', mailboxPagingInfo);
            util.renderPagingNavigation('mailbox_paginate', mailboxPagingInfo);
        }else{
            $('#mailbox_paginate_top').hide();
            $('#mailbox_paginate').hide();
        }
        $("#mailboxMember").empty();
        for(var i=0;i<response.data.mailboxMember.length;i++){
            var tmp_html = '<div class="col-md-12"><span>' + '<a href="javascript://" class="_openMemberPop" data-memNo="' + response.data.mailboxMember[i].mem_no + '">' + response.data.mailboxMember[i].mem_no + '</a>' + " " + response.data.mailboxMember[i].mem_nick + '</span> ';
            tmp_html += '<span class="font-bold" style="border-radius: 5px 5px 5px 5px; background-color: red;color: white; display:inline-block;width:38px;height:16px;">' + response.data.mailboxMember[i].readCnt; + '</span>';
            $("#mailboxMember").append(tmp_html);
        }
    }

    function handlebarsPaging(targetId, pagingInfo) {
        mailboxPagingInfo = pagingInfo;
        msgList(pagingInfo.pageNo);
    }

</script>

<script id="tmp_list" type="text/x-handlebars-template">
    {{#each this}}
    <tr>
        <td>
            {{mem_no}}<br/>
            {{mem_nick}}
        </td>
        <td>{{{sexIcon mem_sex mem_birth_year}}}</td>
        <td style="word-break:break-all">
            {{#dalbit_if type '==' 1}}       <!-- 메시지 -->
            {{{replaceEnter msg}}}
            {{/dalbit_if}}
            {{#dalbit_if type '==' 2}}       <!-- 이미지 -->
            <img class="fullSize_background thumbnail" alt="your image" src="{{renderImage itemThumbnail}}" style='height:68px; width:68px; margin: auto;vertical-align:middle;' />
            {{/dalbit_if}}
            {{#dalbit_if type '==' 3}}       <!-- 아이템 -->
            <img class="_webpImage" src="{{itemThumbnail}}" width="50" height="50" data-webpImage="{{webp_image}}"/>
            {{/dalbit_if}}
        </td>
        <td>{{timeStampDay time}}</td>
        <td>{{substr last_upd_date 0 19}}</td>
        <td>
            {{#dalbit_if delete_yn '==' 0}}
                정상
            {{else}}
                <span style="color: red;">삭제</span>
            {{/dalbit_if}}

        </td>
    </tr>
    {{else}}
    <tr>
        <td colspan="6">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>