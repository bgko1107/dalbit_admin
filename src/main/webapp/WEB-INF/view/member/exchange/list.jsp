<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div class="col-lg-12 no-padding">
    <div class="widget widget-table" id="main_table">
        <div class="widget-content">
            <div class="col-md-6 no-padding mt5">
                <span name="slctExchangeStatus" id="slctExchangeStatus" onchange="exchangeTable_reload();"></span>
                <span name="slctExchangeMemberType" id="slctExchangeMemberType" onchange="exchangeTable_reload();"></span>
                <span name="slctExchangeDateType" id="slctExchangeDateType" onchange="exchangeTable_reload();"></span>
                <input type="hidden" name="startExchangeDate" id="startExchangeDate">
                <input type="hidden" name="endExchangeDate" id="endExchangeDate" />
                <div class="input-group date mr5" id="rangeExchangeDatepicker" style="display: none">
                    <label for="displayExchangeDate" class="input-group-addon">
                        <span><i class="fa fa-calendar"></i></span>
                    </label>
                    <input type="text" name="displayDate" id="displayExchangeDate" class="form-control" />
                </div>
                <button type="button" class="btn btn-success mr5" id="bt_searchExchange" onclick="exchangeTable_reload();">검색</button>
            </div>
            <div class="col-md-6 no-padding pull-right">
                <span id="exchangeSummary"></span>
            </div>

            <table id="list_info_detail" class="table table-sorting table-hover table-bordered datatable">
                <thead id="tableTop_detail">
                </thead>
                <tbody id="tableBody_detail">
                </tbody>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/code/money/exchangeCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/moneyHelper.js?${dummyData}"></script>

<script>
    $(document).ready(function() {

        $("#slctExchangeStatus").html(util.getCommonCodeSelect(-1, slctExchangeStatus));
        $("#slctExchangeMemberType").html(util.getCommonCodeSelect(-1, slctExchangeMemberType));
        $("#slctExchangeDateType").html(util.getCommonCodeSelect(-1, slctExchangeDateType));
        $("#displayExchangeDate").statsDaterangepicker(
            function(start, end, t1) {
                $("#startExchangeDate").val(start.format('YYYY.MM.DD'));
                $("#endExchangeDate").val(end.format('YYYY.MM.DD'));
            }
        );

        var dateTime = new Date();
        dateTime = moment(dateTime).format("YYYY.MM.DD");
        $("#startExchangeDate").val(dateTime);
        $("#endExchangeDate").val(dateTime);

    });

    function getHistory_exchangeDetail(tmp) {     // 상세보기
        sDate = "1900.01.01";
        eDate = "2999.12.31";

        if(tmp.indexOf("_") > 0){ tmp = tmp.split("_"); tmp = tmp[1]; }
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
            data.startDate = sDate;
            data.endDate = eDate;
            data.slctType = $("#exchangeStatus").val();
            data.djType = $("#exchangeMemberType").val();
        };
        dtList_info_detail = new DalbitDataTable($("#"+tmp).find("#list_info_detail"), dtList_info_detail_data, MemberDataTableSource.exchangeList);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable(exchangeSummary_table);
    }

    $(document).on('click', '._layerOpen', function(title, content){
        var data = {};
        data.idx = $(this).data('exchangeidx');
        data.mem_no = memNo;
        util.getAjaxData("select", "/rest/member/exchange/detail", data, fn_succ_detail);
    });

    function fn_succ_detail(dist_id, response){
        var template = $('#tmp_exchange_detail').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#detailView").html(html);

        ui.paintColor();
        showModal();
    }

    function exchangeTable_reload(){
        if($("#slctExchangeDateType").find("select").val() == 0){
            sDate = "1900.01.01";
            eDate = "2999.12.31";
            $("#rangeExchangeDatepicker").hide();
        }else{
            sDate = $("#startExchangeDate").val();
            eDate = $("#endExchangeDate").val();
            $("#rangeExchangeDatepicker").show();
        }
        dtList_info_detail.reload();
    }

    function exchangeSummary_table(response){
        var template = $('#tmp_exchangeSummary').html();
        var templateScript = Handlebars.compile(template);
        var context = response.summary;
        var html = templateScript(context);
        $("#exchangeSummary").html(html);
        ui.paintColor();
    }

</script>

<script id="tmp_exchangeSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right" style="margin-right: 0px;width: 100%">
        <tr>
            <th rowspan="2" class="_bgColor" data-bgcolor="#d9d9d9">구분</th>
            <th colspan="3" class="_bgColor" data-bgcolor="#b4c7e7">승인 완료</th>
            <th colspan="3" class="_bgColor" data-bgcolor="#d9d9d9">승인 취소</th>
            <th colspan="3" class="_bgColor" data-bgcolor="#d9d9d9">미처리</th>
            <th colspan="2" class="_bgColor" data-bgcolor="#b4c7e7">현재 보유 별</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#dae3f3">건</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">별</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">금액</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">건</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">별</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">금액</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">건</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">별</th>
            <th class="_bgColor" data-bgcolor="#f2f2f2">금액</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">별</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">환전가치금액</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#f2f2f2">총합</th>
            <td>{{addComma confirm_cnt}} 건</td>
            <td>{{addComma confirm_byeol}} 별</td>
            <td>{{addComma confirm_amt}} 원</td>
            <td>{{addComma cancel_cnt}} 건</td>
            <td>{{addComma cancel_byeol}} 별</td>
            <td>{{addComma cancel_amt}} 원</td>
            <td>{{addComma ready_cnt}} 건</td>
            <td>{{addComma ready_byeol}} 별</td>
            <td>{{addComma ready_amt}} 원</td>
            <td>{{addComma now_byeol}} 별</td>
            <td>{{addComma now_amt}} 원</td>
        </tr>
    </table>
</script>


<script type="text/x-handlebars-template" id="tmp_exchange_detail">
    <form id="exchangeForm">
        <input type="hidden" name="idx" value="{{detail.idx}}" />
        <div class="modal-dialog" style="max-width: 900px; width: auto; display: table;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="layerCloseBtn">&times;</button>
                    <h4 class="modal-title" id="_layerTitle">상세보기</h4>
                </div>
                <div class="modal-body">
                    <div class="col-lg-12 form-inline block _modalLayer">
                        <div class="{{#if parentInfo.parents_name}}col-lg-8{{/if}}{{^if parentInfo.parents_name}}col-lg-12{{/if}}">
                        <%--<div class="col-lg-12">--%>
                            <table id="list_info" class="table table-sorting table-hover table-bordered">
                                <tbody id="tableBody">
                                    <tr>
                                        <th>신청금액</th>
                                        <td colspan="3" style="font-weight:bold; color: #ff5600">
                                            {{addComma detail.cash_basic}}원
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>은행명</th>
                                        <td>
                                            {{{getCommonCodeSelect detail.bank_code 'inforex_bank_code' 'Y' ''}}}
                                        </td>

                                        <th>계좌번호</th>
                                        <td>
                                            <input type="text" class="form-control" id="account_no" name="account_no" maxlength="25" value="{{detail.account_no}}" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>예금주</th>
                                        <td>
                                            <input type="text" class="form-control" id="account_name" name="account_name" maxlength="25" value="{{detail.account_name}}" />
                                        </td>
                                        <th>주민번호</th>
                                        <td>
                                            <input type="text" class="form-control" id="social_no" name="social_no" maxlength="13" value="{{detail.social_no}}" />
                                            <br />
                                            [{{convertJumin detail.social_no}}]
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>세금신고<br />대상자</th>
                                        <td>
                                            {{#equal detail.prevAccountName ''}}
                                                <span class="_fontColor" data-fontcolor="red">이전 환전승인내역이 없습니다.</span>
                                            {{/equal}}
                                            {{detail.prevAccountName}}
                                        </td>
                                        <th>세금신고<br />주민번호</th>
                                        <td>
                                            {{convertJumin detail.prevSocialNo}}
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>가입시<br />생년월일</th>
                                        <td>
                                            {{detail.birth}}
                                        </td>
                                        <th>미성년자<br />여부</th>
                                        <td>
                                            {{{calcAge detail.birth}}}
                                            {{#isChild detail.birth}}
                                                {{^if parentInfo.parents_name}}
                                                    <br />
                                                    <span style="font-weight:bold;">법정대리인 보호자 동의 정보가 없습니다.</span>
                                                {{/if}}
                                            {{/isChild}}
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>주소</th>
                                        <td colspan="3">
                                            <input type="text" class="form-control _fullWidth" id="address_1" name="address_1" value="{{detail.address_1}}" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>상세주소</th>
                                        <td colspan="3">
                                            <input type="text" class="form-control _fullWidth" id="address_2" name="address_2" value="{{detail.address_2}}" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>전화번호</th>
                                        <td colspan="3">
                                            <input type="hidden" name="phone_no" value="{{phoneNumHyphen detail.phone_no}}" />
                                            {{phoneNumHyphen detail.phone_no}}
                                            / {{phoneNumHyphen detail.mem_phone}}
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>접수서류</th>
                                        <td colspan="3">
                                            <div class="col-lg-6" style="border:solid 1px black">
                                                <a href="javascript://">
                                                    <img src="{{renderImage detail.add_file1}}" style="max-width:100px;max-height:150px;" class="_fullWidth _openImagePop thumbnail" />
                                                </a>
                                                {{#equal detail.state '0'}}<input id="files1" type="file" onchange="photoSubmit($(this))">{{/equal}}
                                                <input type="hidden" class="_hidden_filename" name="add_file1" id="add_file1" value="{{detail.add_file1}}" />
                                            </div>
                                            <div class="col-lg-6" style="border:solid 1px black">
                                                <a href="javascript://">
                                                    <img src="{{renderImage detail.add_file2}}" style="max-width:100px;max-height:150px;" class="_fullWidth _openImagePop thumbnail" />
                                                </a>
                                                {{#equal detail.state '0'}}<input id="files2" type="file" onchange="photoSubmit($(this))"/>{{/equal}}
                                                <input type="hidden" class="_hidden_filename" name="add_file2" id="add_file2" value="{{detail.add_file2}}" />
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>신청일자</th>
                                        <td>
                                            {{convertToDate detail.reg_date 'YYYY-MM-DD HH:mm:ss'}}
                                        </td>

                                        <th>완료일자</th>
                                        <td>
                                            {{#equal detail.op_date ''}}
                                            -
                                            {{else}}
                                            {{convertToDate ../detail.op_date 'YYYY-MM-DD HH:mm:ss'}}
                                            {{/equal}}
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>
                                            미처리 사유
                                        </th>
                                        <td colspan="3">
                                            <input type="hidden" id="send_title" name="send_title">
                                            {{{getCommonCodeSelect detail.send_type 'exchange_cancel_type'}}} <label id="label_send_title">{{detail.send_title}}</label>
                                            <p class="no-margin no-padding" style="font-size:0.9em; color:red;">* 사유 선택 후 불가 처리 시 회원에게 푸시 메시지, SMS로 발송됩니다</p>
                                        </td>
                                    </tr>

                                    {{#dalbit_if detail.send_type "==" "0"}}
                                    <tr id="tr_send_cont" style="display:none;">
                                        {{else}}
                                    <tr id="tr_send_cont">
                                        {{/dalbit_if}}
                                        <th>
                                            미처리 사유<br>내용
                                        </th>
                                        <td colspan="3">
                                            <textarea class="form-control" name="send_cont" id="send_cont" oninput="util.textareaResize(this)" placeholder="" style="width:100%; height:90px; resize: none">{{replaceHtml detail.send_cont}}</textarea>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th>메모</th>
                                        <td colspan="3">
                                            <input type="text" class="form-control _fullWidth" id="op_msg" name="op_msg" maxlength="1000" value="{{detail.op_msg}}" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        {{#if parentInfo.parents_name}}
                        <div class="col-lg-4">
                            <div class="mb10">법정대리인 (보호자) 동의 정보</div>
                            <table id="parentTable" class="table table-sorting table-hover table-bordered">
                                <tbody>
                                    <tr>
                                        <th>
                                           보호자 이름
                                        </th>
                                        <td>
                                            {{parentInfo.parents_name}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                           성별
                                        </th>
                                        <td>
                                            {{{sexIcon parentInfo.parents_sex parentInfo.mem_birth_year}}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                           생년월일
                                        </th>
                                        <td>
                                            {{parentInfo.parents_birth_year}}{{parentInfo.parents_birth_month}}{{parentInfo.parents_birth_day}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                           통신사
                                        </th>
                                        <td>
                                            {{parentInfo.parents_comm_company}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                           휴대폰번호
                                        </th>
                                        <td>
                                            {{parentInfo.parents_phone}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                           내/외국인
                                        </th>
                                        <td>
                                            {{parentInfo.parents_foreign_yn}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>철회 여부</th>
                                        <td>
                                            {{#equal parentInfo.recant_yn 'n'}}
                                                <label style="font-weight: bold">No</label>
                                            {{else}}
                                                <label style="color: red; font-weight: bold">Yes</label>
                                            {{/equal}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                           가족관계<br />증명서류
                                        </th>
                                        <td>
                                            {{#if parentInfo.add_file}}
                                                <img src="{{renderImage parentInfo.add_file}}" style="max-width:100px;max-height:150px;" class="_fullWidth _openImagePop thumbnail" />
                                            {{else}}
                                                가족관계 증명서류가 없습니다.
                                            {{/if}}
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        {{/if}}
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary pull-left" data-dismiss="modal"><i class="fa fa-times-circle"></i> 닫기</button>

                    {{#equal detail.state '0'}}
                        {{#adultStatusCheck ../detail.birth ../parentInfo.recant_yn}}
                            <button type="button" class="btn btn-custom-primary _updateBtn"><i class="fa fa-times-circle"></i> 수정</button>
                            <button type="button" class="btn btn-danger _rejectBtn"><i class="fa fa-times-circle"></i> 불가</button>
                            <button type="button" class="btn btn-success _completeBtn"><i class="fa fa-check-circle"></i> 완료</button>
                        {{else}}
                            <span class="exchange_complete_txt">법정대리인 보호자 정보동의 철회로 처리 할 수 없습니다.</span>
                        {{/adultStatusCheck}}
                    {{/equal}}

                    {{#equal detail.state '1'}}
                        <span class="exchange_complete_txt">완료되었습니다.</span>
                    {{/equal}}

                    {{#equal detail.state '2'}}
                        <span class="exchange_reject_txt">불가처리 되었습니다.</span>
                    {{/equal}}

                </div>
            </div>
        </div>
    </form>
</script>


