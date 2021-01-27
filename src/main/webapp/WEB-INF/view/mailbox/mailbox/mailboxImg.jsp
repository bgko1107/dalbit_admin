
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="main-header">
    <div id="page-wrapper">
        <!-- DATA TABLE -->
        <div class="col-lg-12 form-inline no-padding">
            <div class="widget-content">
                <select id="slctType" name="slctType" class="form-control searchType mt5" style="width: 130px; display: inline" onchange="mailboxImgList();">
                    <option value="0">상태(전체)</option>
                    <option value="1">정상</option>
                    <option value="2">삭제</option>
                </select>
                <div class="dataTables_paginate paging_full_numbers" id="mailboxImgList_info_paginate_top"></div>
                <div class="col-md-12 no-padding">
                    <div class="list-group">
                        <form id="mailboxForm"></form>
                    </div>
                </div>
                <div class="dataTables_paginate paging_full_numbers" id="mailboxImgList_info_paginate"></div>
            </div>
        </div>
        <!-- DATA TABLE END -->
    </div>
</div>

<script src="../../../js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script>
    $(document).ready(function() {
    });


//=------------------------------ Init / Event--------------------------------------------
    var mailboxImgPagingInfo= new PAGING_INFO(0, 1, 54);

    function mailboxImgList(pagingNo) {
        if(!common.isEmpty(pagingNo)){
            mailboxImgPagingInfo.pageNo = pagingNo;
        }else{
            mailboxImgPagingInfo.pageNo = 1;
        }

        var data = {
             pageNo : mailboxImgPagingInfo.pageNo
            , pageCnt : mailboxImgPagingInfo.pageCnt
            , searchText : common.isEmpty($('#txt_search').val()) ? '' : $('#txt_search').val()
            , startDate : $("#startDate").val()
            , endDate : $("#endDate").val()
            , slctType : $("#slctType").val()
        };

        console.log(data);
        util.getAjaxData("mailbox", "/rest/customer/image/mailbox/list", data, fn_mailboxImg_success, fn_fail);
    };

    function fn_mailboxImg_success(dst_id, response, dst_params){
        // form 띄우기
        var template = $('#tmp_mailboxSelectFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);
        $("#mailboxForm").html(html);

        mailboxImgPagingInfo.totalCnt = response.pagingVo.totalCnt;

        console.log(mailboxImgPagingInfo);
        util.renderPagingNavigation("mailboxImgList_info_paginate_top", mailboxImgPagingInfo);
        util.renderPagingNavigation("mailboxImgList_info_paginate", mailboxImgPagingInfo);

        $("#summaryArea").empty();

        var template = $('#tmp_mailboxImgSummary').html();
        var templateScript = Handlebars.compile(template);
        var context = response.summary;
        var html = templateScript(context);
        $('#summaryArea').html(html);

        ui.paintColor();
    };


    function fn_fail(data, textStatus, jqXHR){
        alert(data.message);

        console.log(data, textStatus, jqXHR);
    };

</script>



<!-- =------------------ Handlebars ---------------------------------- -->
<script id="tmp_mailboxSelectFrm" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        {{^equal data.image_path ''}}
            {{#dalbit_if data.inner '==' 1}}
            <div class="item col-md-2 col-sm-6 mb15 bg-testMember" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
            {{else}}
            <div class="item col-md-2 col-sm-6 mb15" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
            {{/dalbit_if}}
                <div>
                    <label>NO.{{indexDesc ../../pagingVo.totalCnt data.rowNum}}</label>
                    {{#dalbit_if data.data2 '==' 'y'}}
                        <label class="pull-right" style="background-color: #fff7e5">상태 : <span style="color:red;">삭제</span></label>
                    {{else}}
                        <label class="pull-right" style="background-color: #fff7e5">상태 : 정상</label>
                    {{/dalbit_if}}
                </div>
                <div style="border: 1px solid #ddd; border-radius: 4px; padding: 4px;height: 430px;">
                <div class="thumbnail" src="{{renderImage data.imageUrl}}?360x360">
                    <img class="list-group-image thumbnailImg fullSize_background" style="width:360px; height:225px;" src="{{renderImage data.imageUrl}}" alt="" data-toggle="modal" data-target="#imgModal" />
                </div>
                <div>
                    <h4 class="inner list-group-item-heading broadcast_title">
                        <a href="javascript://" onclick="mailboxPopUp($(this))" data-chatno="{{data.chat_no}}">{{data.chat_no}}</a>
                    </h4>
                    <ul class="list-unstyled">
                        <li><strong>작성일시:</strong> <br />{{substr data.last_upd_date 0 19}}</li>
                        <li><strong>Nick:</strong> {{replaceHtml data.mem_nick}}</li>
                        <li><strong>No:</strong>
                            <a href="javascript://" class="_openMemberPop" data-memno="{{data.mem_no}}" >
                            {{data.mem_no}}
                            </a>
                        </li>
                        <li class="sexType"><strong>Sex:</strong> {{{sexIcon data.mem_sex data.mem_birth_year}}}</li>
                    </ul>
                </div>
                </div>
            </div>
        {{/equal}}
        {{else}}
            <div class="col-md-12" style="text-align:center">
                <label>{{isEmptyData}}</label>
            </div>
    {{/each}}
</script>


<script id="tmp_mailboxImgSummary" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered">
        <tr>
            <th rowspan="2" class="_bgColor" data-bgcolor="#bfbfbf">구분</th>
            <th colspan="2" class="_bgColor" data-bgcolor="#dae3f3">{{{sexIcon 'm'}}}</th>
            <th colspan="2" class="_bgColor" data-bgcolor="#fbe5d6">{{{sexIcon 'f'}}}</th>
            <th colspan="2" class="_bgColor" data-bgcolor="#fff2cc">{{{sexIcon 'n'}}}</th>
            <th colspan="2" class="_bgColor" data-bgcolor="#bfbfbf">총합</th>
        </tr>
        <tr>
            <th class="_bgColor _fontColor" data-bgcolor="#f2f2f2" data-fontcolor="blue">회원</th>
            <th class="_bgColor _fontColor" data-bgcolor="#f2f2f2" data-fontcolor="blue">건</th>
            <th class="_bgColor _fontColor" data-bgcolor="#f2f2f2" data-fontcolor="red">회원</th>
            <th class="_bgColor _fontColor" data-bgcolor="#f2f2f2" data-fontcolor="red">건</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">회원</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">건</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">회원</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">건</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#f2f2f2">총 합</th>
            <td class="_fontColor" data-fontcolor="blue">{{addComma mCnt}} 명</td>
            <td class="_fontColor" data-fontcolor="blue">{{addComma mCntMsg}} 건</td>
            <td class="_fontColor" data-fontcolor="red">{{addComma fCnt}} 명</td>
            <td class="_fontColor" data-fontcolor="red">{{addComma fCntMsg}} 건</td>
            <td>{{addComma nCnt}} 명</td>
            <td>{{addComma nCntMsg}} 건</td>
            <td class="_bgColor" data-bgcolor="#bfbfbf">{{addComma tCnt}} 명</td>
            <td class="_bgColor" data-bgcolor="#bfbfbf">{{addComma totalCntMsg}} 건</td>
        </tr>
    </table>
</script>
