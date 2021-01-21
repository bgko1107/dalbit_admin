<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- table -->
<div class="col-lg-12 no-padding">
    <div class="widget-content">
        <div class="dataTables_paginate paging_full_numbers" id="mailboxGift_paginate_top"></div>
        <table id="mailboxGiftTable" class="table table-sorting table-hover table-bordered mt10">
            <colgroup>
                <col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/>
                <col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/><col width="9%"/>
                <col width="9%"/>
            </colgroup>
            <thead>
            <tr>
                <th>No</th>
                <th>우체통번호</th>
                <th>보낸회원</th>
                <th>성별(나이)</th>
                <th>선물일시</th>
                <th>받은회원</th>
                <th>성별(나이)</th>
                <th>이미지</th>
                <th>선물명</th>
                <th>선물 건</th>
                <th>선물 달</th>
            </tr>
            </thead>
            <tbody id="tb_mailboxGiftList">
            </tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="mailboxGift_paginate"></div>
    </div>
</div>
<!-- //table -->

<script type="text/javascript">
    var mailboxGiftPagingInfo = new PAGING_INFO(0,1,40);

    $(document).ready(function() {
    });

    var memNo;
    function mailboxGiftList(pagingNo) {
        if(!common.isEmpty(pagingNo)){
            mailboxGiftPagingInfo.pageNo = pagingNo;
        }else{
            mailboxGiftPagingInfo.pageNo = 1;
        }

        var data = {
            'pageNo': mailboxGiftPagingInfo.pageNo
            , 'pageCnt' : mailboxGiftPagingInfo.pageCnt
            , 'searchText' : txt_search
            , 'startDate' : $("#startDate").val()
            , 'endDate' : $("#endDate").val()
        };

        util.getAjaxData("mailboxGift", "/rest/content/boardAdm/mailbox/gift", data, fn_success_mailboxGift);
    }

    function fn_success_mailboxGift(dst_id, response, param) {

        for(var i=0 ; i<response.data.length;i++){
            response.data[i].msg = response.data[i].msg.replace(/\\n/gi,"<br/>");
        }

        var template = $('#tmp_mailboxGiftTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);
        $('#tb_mailboxGiftList').html(html);


        if(response.data.length == 0) {
            $("mailboxGiftList").find("#mailboxGift_paginate_top").hide();
            $("mailboxGiftList").find('#mailboxGift_paginate').hide();
        } else {
            mailboxGiftPagingInfo.totalCnt = response.pagingVo.totalCnt;
            util.renderPagingNavigation('mailboxGift_paginate_top', mailboxGiftPagingInfo);
            util.renderPagingNavigation('mailboxGift_paginate', mailboxGiftPagingInfo);

            $("mailboxGiftList").find("#mailboxGift_paginate_top").show();
            $("mailboxGiftList").find('#mailboxGift_paginate').show();

            response.summary.total_giftCnt = response.summary.male_giftCnt + response.summary.female_giftCnt + response.summary.none_giftCnt;
            response.summary.total_giftDal = response.summary.male_giftDal + response.summary.female_giftDal + response.summary.none_giftDal;
            $("#summaryArea").empty();
            var template = $('#tmp_mailboxGiftSummary').html();
            var templateScript = Handlebars.compile(template);
            var context = response.summary;
            var html = templateScript(context);
            $('#summaryArea').html(html);

            ui.paintColor();
        }
    }

</script>

<script id="tmp_mailboxGiftTable" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        <tr {{#dalbit_if inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
            <td>{{indexDesc ../pagingVo/totalCnt rowNum}}</td>
            <td>
                <a href="javascript://"  onclick="mailboxPopUp($(this))" data-chatno="{{chat_no}}">{{chat_no}}</a>
            </td>
            <td class="{{#equal data.memInner 1}}bg-testMember{{/equal}}">
                {{{memNoLink mem_no mem_no}}}<br/>
                {{memNick}}
            </td>
            <td>{{{sexIcon memSex}}}({{memAge}})</td>
            <td>{{substr giftDate 0 19}}</td>
            <td class="{{#equal data.target_mem_inner 1}}bg-testMember{{/equal}}">
                {{{memNoLink target_mem_no target_mem_no}}}<br/>
                {{target_memNick}}
            </td>
            <td>{{{sexIcon target_memSex}}}({{target_memAge}})</td>
            <td><img class="_webpImage" src="{{item_thumbnail}}" width="50" height="50" data-webpImage="{{webp_image}}"/></td>
            <td>{{item_name}}</td>
            <td>{{addComma giftCnt}}</td>
            <td>{{addComma giftDal}}</td>
        </tr>
    {{else}}
        <tr>
            <td colspan="11">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>

<script id="tmp_mailboxGiftSummary" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered">
        <tr>
            <th rowspan="2" class="_bgColor" data-bgcolor="#bfbfbf">구분</th>
            <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">{{{sexIcon 'm'}}}</th>
            <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">{{{sexIcon 'f'}}}</th>
            <th colspan="2" class="_bgColor" data-bgcolor="#fff2cc">{{{sexIcon 'n'}}}</th>
            <th colspan="2" class="_bgColor" data-bgcolor="#bfbfbf">총합</th>
        </tr>
        <tr>
            <th class="_bgColor _fontColor" data-bgcolor="#f2f2f2" data-fontcolor="blue">건</th>
            <th class="_bgColor _fontColor" data-bgcolor="#f2f2f2" data-fontcolor="blue">달</th>
            <th class="_bgColor _fontColor" data-bgcolor="#f2f2f2" data-fontcolor="red">건</th>
            <th class="_bgColor _fontColor" data-bgcolor="#f2f2f2" data-fontcolor="red">달</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">건</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">달</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">건</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">건</th>
        </tr>

        <tr>
            <th class="_bgColor" data-bgcolor="#f2f2f2">총 합</th>
            <td class="_fontColor" data-fontcolor="blue">{{addComma male_giftCnt}} 건</td>
            <td class="_fontColor" data-fontcolor="blue">{{addComma male_giftDal}} 달</td>
            <td class="_fontColor" data-fontcolor="red">{{addComma female_giftCnt}} 건</td>
            <td class="_fontColor" data-fontcolor="red">{{addComma female_giftDal}} 달</td>
            <td>{{addComma none_giftCnt}} 건</td>
            <td>{{addComma none_giftDal}} 달</td>
            <td class="_bgColor" data-bgcolor="#bfbfbf">{{addComma total_giftCnt}} 건</td>
            <td class="_bgColor" data-bgcolor="#bfbfbf">{{addComma total_giftDal}} 달</td>
        </tr>

    </table>
</script>