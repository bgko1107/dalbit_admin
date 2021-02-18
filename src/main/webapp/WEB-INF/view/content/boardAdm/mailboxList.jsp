<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- table -->
<div class="col-lg-12 no-padding">
    <div class="widget-content">
        <div class="dataTables_paginate paging_full_numbers" id="mailbox_paginate_top"></div>
        <table id="mailboxTable" class="table table-sorting table-hover table-bordered mt10">
            <colgroup>
                <col width="5%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="35%"/>
                <col width="10%"/><col width="8%"/><col width="5%"/>
            </colgroup>
            <thead>
            <tr>
                <th>No</th>
                <th>우체통번호</th>
                <th>개설회원</th>
                <th>참여회원</th>
                <th>대화내용</th>
                <th>대화일시</th>
                <th>기간</th>
                <th>상태</th>
            </tr>
            </thead>
            <tbody id="tb_mailboxList">
            </tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="mailbox_paginate"></div>
    </div>
</div>
<!-- //table -->

<script type="text/javascript">
    var mailboxPagingInfo = new PAGING_INFO(0,1,40);

    $(document).ready(function() {
        // mailboxList();
    });

    var memNo;
    function mailboxList(pagingNo, _tabId) {
        if(!common.isEmpty(_tabId)){
            tabId = _tabId;
        }

        if(!common.isEmpty(pagingNo)){
            mailboxPagingInfo.pageNo = pagingNo;
        }else{
            mailboxPagingInfo.pageNo = 1;
        }

        if(!common.isEmpty(memNo) && memNo != null){
            txt_search = memNo;
        }else{
            txt_search = $('#txt_search').val();
        }

        var data = {
            'pageNo': mailboxPagingInfo.pageNo
            , 'pageCnt' : mailboxPagingInfo.pageCnt
            , 'searchText' : txt_search
            , 'startDate' : $("#startDate").val()
            , 'endDate' : $("#endDate").val()
            , 'newSearchType' : $("#searchMember").val()
        };

        util.getAjaxData("mailbox", "/rest/content/boardAdm/mailbox", data, fn_success_mailbox);
    }

    function fn_success_mailbox(dst_id, response, param) {

        for(var i=0 ; i<response.data.length;i++){
            response.data[i].msg = response.data[i].msg.replace(/\\n/gi,"<br/>");
        }

        var template = $('#tmp_mailboxTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);
        $('#tb_mailboxList').html(html);

        mailboxPagingInfo.totalCnt = response.pagingVo.totalCnt;
        util.renderPagingNavigation('mailbox_paginate_top', mailboxPagingInfo);
        util.renderPagingNavigation('mailbox_paginate', mailboxPagingInfo);

        if(response.data.length == 0) {
            $("mailboxList").find("#mailbox_paginate_top").hide();
            $("mailboxList").find('#mailbox_paginate').hide();
        } else {
            $("mailboxList").find("#mailbox_paginate_top").show();
            $("mailboxList").find('#mailbox_paginate').show();

            response.summary.gift_totalCnt = response.summary.gift_mCnt + response.summary.gift_fCnt + response.summary.gift_nCnt;
            response.summary.total_giftCnt = response.summary.male_giftCnt + response.summary.female_giftCnt + response.summary.none_giftCnt;
            response.summary.total_byeolCnt = response.summary.male_byeolCnt + response.summary.female_byeolCnt + response.summary.none_byeolCnt;

            response.summary.msg_totalCnt = response.summary.msg_mCnt + response.summary.msg_fCnt + response.summary.msg_nCnt;
            response.summary.total_msgCnt = response.summary.male_msgCnt + response.summary.female_msgCnt + response.summary.none_msgCnt;

            response.summary.img_totalCnt = response.summary.img_mCnt + response.summary.img_fCnt + response.summary.img_nCnt;
            response.summary.total_imgCnt = response.summary.male_imgCnt + response.summary.female_imgCnt + response.summary.none_imgCnt;

            var template = $('#tmp_mailboxSummary').html();
            var templateScript = Handlebars.compile(template);
            var context = response.summary;
            var html = templateScript(context);
            $('#summaryArea').html(html);

            ui.paintColor();


        }
    }

    function mailboxPopUp(data){
        var date = $("#onedayDate").val();
        var popupUrl = "/member/mailbox/popup/mailboxMsg?chatNo="+ data.data('chatno')+"&searchDate="+date;
        util.windowOpen(popupUrl,"950", "1000","우체통");
    }

</script>

<script id="tmp_mailboxTable" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        <tr {{#dalbit_if inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
            <td>{{indexDesc ../pagingVo/totalCnt rowNum}}</td>
            <td>
                <a href="javascript://"  onclick="mailboxPopUp($(this))" data-chatno="{{chatNo}}">{{chatNo}}</a>
            </td>
            <td class="{{#equal data.memInner 1}}bg-testMember{{/equal}}">
                {{{memNoLink memNo memNo}}}<br/>
                {{memNick}}
            </td>
            <td class="{{#equal data.target_mem_inner 1}}bg-testMember{{/equal}}">
                {{{memNoLink targetMemNo targetMemNo}}}<br/>
                {{target_mem_nick}}
            </td>
            <td class="word-break" style="text-align: left; width: 300px">
                {{#dalbit_if msgType '==' 1}}       <!-- 메시지 -->
                    <a href="javascript://"  onclick="mailboxPopUp($(this))" data-chatno="{{chatNo}}">{{{replaceEnter msg}}}</a>
                {{/dalbit_if}}
                {{#dalbit_if msgType '==' 2}}       <!-- 이미지 -->
                    <img class="fullSize_background thumbnailImg" alt="your image" src="{{renderImage data1}}" style='height:68px; width:68px; margin: auto;vertical-align:middle;' />
                    <a href="javascript://"  onclick="mailboxPopUp($(this))" data-chatno="{{chatNo}}">이미지 전송</a>
                {{/dalbit_if}}
                {{#dalbit_if msgType '==' 3}}       <!-- 아이템 -->
                    <%--<img class="_webpImage" src="{{item_thumbnail}}" width="50" height="50" data-webpImage="{{webp_image}}"/>--%>
                    <%--<a href="javascript://"  onclick="mailboxPopUp($(this))" data-chatno="{{chatNo}}">아이템 전송</a>--%>

                    <div style="display:flex;">
                        <img src="{{item_thumbnail}}" width="50" height="50" data-webpImage="{{webp_image}}" />
                        <p>
                            <a href="javascript://"  onclick="mailboxPopUp($(this))" data-chatno="{{chatNo}}">
                                {{{viewMailBoxItemJson memNick data4}}}
                            </a>
                        </p>
                    </div>

                {{/dalbit_if}}
            </td>
            <td>{{substr lastChatDate 0 19}}</td>
            <td>{{timeStampDay diffDate}} 전</td>
            <td>
                {{#dalbit_if state '==' 0}}
                    대화전
                {{else}}
                    {{#dalbit_if state '==' 1}}
                        정상
                    {{else}}
                        퇴장
                    {{/dalbit_if}}
                {{/dalbit_if}}
            </td>
        </tr>
    {{else}}
        <tr>
            <td colspan="8">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>

<script id="tmp_mailboxSummary" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered">
        <tr>
            <th rowspan="2" class="_bgColor" data-bgcolor="#bfbfbf">구분</th>
            <th colspan="2" class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'm'}}}</th>
            <th colspan="2" class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'f'}}}</th>
            <th colspan="2" class="_bgColor" data-bgcolor="#b4c7e7">{{{sexIcon 'n'}}}</th>
            <th colspan="2" class="_bgColor" data-bgcolor="#bfbfbf">총합</th>
        </tr>
        <tr>
            <th class="_bgColor _fontColor" data-bgcolor="#dae3f3" data-fontcolor="blue">회원</th>
            <th class="_bgColor _fontColor" data-bgcolor="#dae3f3" data-fontcolor="blue">건 / 달</th>
            <th class="_bgColor _fontColor" data-bgcolor="#dae3f3" data-fontcolor="red">회원</th>
            <th class="_bgColor _fontColor" data-bgcolor="#dae3f3" data-fontcolor="red">건 / 달</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">회원</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">건 / 달</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">회원</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">건 / 달</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#f2f2f2">선물</th>
            <td class="_fontColor" data-fontcolor="blue">{{addComma gift_mCnt}}</td>
            <td class="_fontColor" data-fontcolor="blue">{{addComma male_giftCnt}} / {{addComma male_byeolCnt}}</td>
            <td class="_fontColor" data-fontcolor="red">{{addComma gift_fCnt}}</td>
            <td class="_fontColor" data-fontcolor="red">{{addComma female_giftCnt}} / {{addComma female_byeolCnt}}</td>
            <td>{{addComma gift_nCnt}}</td>
            <td>{{addComma none_giftCnt}} / {{addComma none_byeolCnt}}</td>
            <td>{{addComma gift_totalCnt}}</td>
            <td>{{addComma total_giftCnt}} / {{addComma total_byeolCnt}}</td>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#f2f2f2">대화</th>
            <td class="_fontColor" data-fontcolor="blue">{{addComma msg_mCnt}}</td>
            <td class="_fontColor" data-fontcolor="blue">{{addComma male_msgCnt}}</td>
            <td class="_fontColor" data-fontcolor="red">{{addComma msg_fCnt}}</td>
            <td class="_fontColor" data-fontcolor="red">{{addComma female_msgCnt}}</td>
            <td>{{addComma msg_nCnt}}</td>
            <td>{{addComma none_msgCnt}}</td>
            <td>{{addComma msg_totalCnt}}</td>
            <td>{{addComma total_msgCnt}}</td>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#f2f2f2">이미지</th>
            <td class="_fontColor" data-fontcolor="blue">{{addComma img_mCnt}}</td>
            <td class="_fontColor" data-fontcolor="blue">{{addComma male_imgCnt}}</td>
            <td class="_fontColor" data-fontcolor="red">{{addComma img_fCnt}}</td>
            <td class="_fontColor" data-fontcolor="red">{{addComma female_imgCnt}}</td>
            <td>{{addComma img_nCnt}}</td>
            <td>{{addComma none_imgCnt}}</td>
            <td>{{addComma img_totalCnt}}</td>
            <td>{{addComma total_imgCnt}}</td>
        </tr>
    </table>
</script>