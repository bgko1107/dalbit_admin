<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="principal" property="principal" />
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>


<form id="declarationForm"></form>

<!-- 채팅 내역 -->
<div class="col-md-12 no-padding" id="chatLeft" style="display:none;">
    <table class="table table-bordered" style="margin-bottom: -7px">
        <th>신고 시 캡쳐내용(5분)</th>
    </table>
    <table id="list_chat_detail" class="table table-sorting table-hover table-bordered datatable">
        <thead></thead>
        <tbody></tbody>
    </table>
</div>
<div class="col-md-6 no-padding" id="chatRight" style="display:none;">
    <table class="table table-bordered" style="margin-bottom: -7px">
        <th id="chatRight_title"></th>
    </table>
    <table id="list_target_chat" class="table table-sorting table-hover table-bordered datatable">
        <thead></thead>
        <tbody></tbody>
    </table>
</div>

<script type="text/javascript" src="/js/message/customer/declarationMessage.js?${dummyData}"></script>

<script type="text/javascript">
    var dtList_info_detail;
    var dtList_info_detail_data = function (data) {
        // data.mem_no = detailData.mem_no;
        data.room_no = "91585286445106";
    }
    dtList_info_detail = new DalbitDataTable($("#list_chat_detail"), dtList_info_detail_data, BroadcastDataTableSource.chatDetail);
    dtList_info_detail.useCheckBox(false);
    dtList_info_detail.useIndex(false);
    dtList_info_detail.useInitReload(true);
    dtList_info_detail.createDataTable();
    $("#chatLeft").removeClass("col-md-6");
    $("#chatLeft").addClass("col-md-12");
    $("#chatRight").addClass("hide");

    //상세 버튼 처리
    $(document).on('click', '._detailBtn', function(){
        $(this).parent().parent().find('._getDeclarationDetail').click();
    })


    var detailData;
    function fn_detail_success(dst_id, response, params) {
        dalbitLog(response);

        response.data["rowNum"] = params.rowNum;

        var template = $('#tmp_declarationFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html=templateScript(context);
        $("#declarationForm").html(html);
        $('#report_title').html("ㆍ신고시 캡쳐내용은 라이브 방송방 신고 시점을 기준으로 5분 이내의 채팅 내역 정보입니다. 신중히 확인 한 후 조치바랍니다.");
        util.editorInit("declaration");
        detailData = response.data;

        if(response.data.status == "1"){
            $('#bt_declaration').addClass("hide");
        }else{
            $('#bt_declaration').removeClass("hide");
        }
        declarationCheck(response.data.status);

        // scroll 처리
        var scrollPosition = $("#report_tab").offset();
        util.scrollPostion(scrollPosition.top);
    }

    function declarationFormData() {
        var data = {};
        var formArray = $("#declarationForm").serializeArray();
        for(var i=0; i<formArray.length; i++) {
            data[formArray[i]['name']] = formArray[i]['value'];
        }

        data["notiMemo"] = $("#notiMemo").val();  // 알림 제목
        data["notiContents"] = $("#notiContents").summernote('code');   // 알림 내용
        data["sendNoti"] = $("input:radio[name='declaration_sendNoti']:checked").val();

        data["blockScope"] = $("#block_scope1").prop('checked')+','+$("#block_scope2").prop('checked')+','+$("#block_scope3").prop('checked');
        dalbitLog(data);

        return data;
    }

    $(document).on('click', '#bt_declaration', function(){
        if (($('input:radio[name="opCode"]:checked').val() == 1)) {  //정상일 경우
            //????
        } else if ($('input:radio[name="opCode"]:checked').val() == 0) {    //미처리일 경우
            alert('미처리 조치입니다. 신고조치 처리해주십시오.');
            return false;

        } else {
            if (common.isEmpty($('input:checkbox[name="declaration_Message"]:checked').val())) {    //조치 선택
                alert('제재 조치의 사유를 선택해주십시오.');
                return false;
            }
        }
        if(confirm('처리하시겠습니까?')) {
            // 정상일 경우 & 제재, 조치사유 선택완료
            util.getAjaxData("declaration", "/rest/customer/declaration/operate", declarationFormData(), function (dst_id, response) {

                alert(response.message);

                dtList_info.reload(null, false);

                // 상단이동
                $('html').animate({scrollTop: 0}, 100);
                $("#declarationForm").empty();
            });
        }
    });

    $(document).on('click', 'input:radio[name="opCode"]', function(title, content){
        messageCheck();
    });

    $(document).on('click', 'input:checkbox[name="declaration_Message"]',function(title, content) {
        messageCheck();
    });

    var msgValue = '';
    var msgTitle = '';
    function messageCheck() {

        var radioValue = $('input:radio[name="opCode"]:checked').val();
        var blockDay = 0;
        declarationCheck();

        if(radioValue == 6 || radioValue == 7){
            msgValue = declarationMessage.out;
            msgTitle = declarationMessage.outTitle;
        } else if(radioValue == 8) {
            msgValue = declarationMessage.pause;
            msgTitle = declarationMessage.pauseTitle;

        }else if(radioValue == 3 || radioValue == 4 || radioValue ==5){
            if(radioValue == 3){blockDay = 1;}
            if(radioValue == 4){blockDay = 3;}
            if(radioValue == 5){blockDay = 7;}
            msgValue = declarationMessage.stop;
            msgTitle = declarationMessage.stopTitle;
        } else if(radioValue == 2) {
            msgValue = declarationMessage.warning;
            msgTitle = declarationMessage.warningTitle;
        } else {
            msgValue = "";
            msgTitle = "";
        }

        var strName = ADMIN_NICKNAME;
        var date = new Date();
        var timestamp = date.getFullYear() + "-" +
            common.lpad(date.getMonth() + 1,2,"0") + "-" +
            common.lpad(date.getDate(),2,"0");
            // + " " +
            // common.lpad(date.getHours(),2,"0") + "." +
            // common.lpad(date.getMinutes(),2,"0") + "." +
            // common.lpad(date.getSeconds(),2,"0");


        // 조치선택 체크박스 클릭할 때 마다 {{message}} 여기에다가 <br />붙여서 replace..
        var msg = '';
        $('input:checkbox[name="declaration_Message"]:checked').each(function() {
            if($(this).val() != '기타 운영자 직접작성'){
                msg += "<br>- " + $(this).val();
            }
        });

        msgValue = msgValue.replace(/{{name}}/gi, strName)
            .replace(/{{nickName}}/gi, detailData.reported_mem_nick)
            .replace(/{{message}}/gi, msg)
            .replace(/{{timestamp}}/gi, timestamp)
            .replace(/{{blockDay}}/gi, blockDay)

        msgTitle = msgTitle.replace(/{{name}}/gi, strName)
            .replace(/{{nickName}}/gi, detailData.reported_mem_nick)
            // .replace(/{{message}}/gi, msg.replace(/\-/gi, "<br>-"))
            .replace(/{{message}}/gi, msg)
            .replace(/{{timestamp}}/gi, timestamp)
            .replace(/{{blockDay}}/gi, blockDay)

        $("#notiMemo").val(msgTitle);
        $("#notiContents").summernote('code', msgValue);

    }

    /*$(document).on('click', 'input:radio[name="declaration_sendNoti"]',function(title, content) {
        if($(this).val() == 1) {
            $("#notiMemo").summernote('code', msgValue);
            $("#notiContents").val(msgTitle);
            //$("#declaration_editor").show();
        } else {
            //$('#declaration_editor').hide();
        }
    });*/

    // declarationCheck();
    function declarationCheck(){
        var opCode = $('input:radio[name="opCode"]');
        var declarationValue = $('input:checkbox[name="declaration_Message"], input:radio[name="declaration_sendNoti"]');
        var radioValue = $('input:radio[name="opCode"]:checked').val();

        dalbitLog("length : " + $("#bt_declaration").length);
        dalbitLog("radioValue : " + radioValue);

        if(0 < $("#bt_declaration").length){
            opCode.removeAttr("disabled");
        }else{
            opCode.attr("disabled", "disabled");
        }

        if($('input:radio[name="opCode"]').prop('disabled')) {
            declarationValue.attr("disabled", "disabled");
        } else {
            declarationValue.removeAttr("disabled");
            if(radioValue == 0 || radioValue == 1) {
                // 체크박스 해지
                $('input:checkbox[name="declaration_Message"]').removeAttr("checked");
                // sendNoti값 0
                $('input:radio[name="declaration_sendNoti"]:radio[value="0"]').prop("checked", true);

                //$('#declaration_editor').hide();
                declarationValue.attr("disabled", "disabled");
            }
            $('input:radio[name="opCode"]').on('change', function() {
                if(radioValue >= 2 || radioValue <= 7) {
                    $('input:checkbox[name="declaration_Message"]').removeAttr("checked");
                    $('input:radio[name="declaration_sendNoti"]:radio[value="0"]').prop("checked", true);
                }
            });
        }
    }

    function targetChat(index){
        $("#chatRight").removeClass("hide");
        var metaData = dtList_info_detail.getDataRow(index);
        $("#chatLeft").removeClass("col-md-12");
        $("#chatLeft").addClass("col-md-6");
        $('#chatRight_title').html(util.memNoLink(metaData.nickname, metaData.mem_no)  + "님의 채팅글");
        var dtList_info_detail_data = function (data) {
            data.room_no = "91585286445106";
            data.mem_no = "11584402943774";
        }
        var dblist_chat_detail;
        dblist_chat_detail = new DalbitDataTable($("#list_target_chat"), dtList_info_detail_data, BroadcastDataTableSource.targetchat);
        dblist_chat_detail.useCheckBox(false);
        dblist_chat_detail.useIndex(false);
        dblist_chat_detail.useInitReload(true);
        dblist_chat_detail.createDataTable();
    }
</script>

<script id="tmp_declarationFrm" type="text/x-handlebars-template">
    <div id="wrapper">
        <div id="page-wrapper">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                <li class="active"><a href="#reportDetail" role="tab" data-toggle="tab">신고처리</a></li>
                {{#equal status 0}}<button type="button" class="btn btn-default btn-sm print-btn pull-right" id="bt_declaration">처리완료</button>{{/equal}}
            </ul>
            <div class="col-lg-12 no-padding">
                <label id="report_title"></label>
            </div>

            <input type="hidden" name="reportIdx" value="{{reportIdx}}" />
            <table class="table table-bordered table-dalbit">
                <colgroup>
                    <col width="5%" />
                    <col width="5%" />
                    <col width="5%" />
                    <col width="6%" />
                    <col width="5%" />
                    <col width="5%" />
                    <col width="5%" />
                    <col width="5%" />
                    <col width="5%" />
                    <col width="5%" />
                    <col width="5%" />
                    <col width="5%" />
                </colgroup>
                <tbody>
                <tr class="align-middle">
                    <th rowspan="2">No</th>
                    <td rowspan="2">{{rowNum}}</td>

                    <th>신고사유</th>
                    <td>{{{getCommonCodeLabel report_reason 'declaration_reason'}}}</td>

                    <th>Browser</th>
                    <td>{{browser}}</td>

                    <th rowspan="2">접수일시</th>
                    <td rowspan="2">{{reg_date}}</td>

                    <th rowspan="2">처리일시</th>
                    <td rowspan="2">
                        {{op_date}}
                        {{#equal op_date ''}}-{{/equal}}
                    </td>

                    <th>처리상태</th>
                    <%--<td>{{{getCommonCodeSelect status 'declaration_status'}}}</td>--%>
                    {{^equal status '0'}}<td>처리완료</td>{{/equal}}
                    {{#equal status '0'}}<td>미처리</td>{{/equal}}
                </tr>
                <tr>

                    <th>플랫폼</th>
                    <td>{{platform}}</td>

                    <th>IP Address</th>
                    <td>{{ipAddress}}</td>

                    <th>처리자명</th>
                    <td>
                        {{op_name}}
                        {{#equal op_name ''}}-{{/equal}}
                    </td>
                </tr>
            </tbody>
        </table>

        <table class="table table-bordered table-dalbit">
            <colgroup>
                <col width="4%" />
                <col width="5%" />
                <col width="5%" />
                <col width="6%" />
                <col width="4%" />
                <col width="5%" />
                <col width="5%" />
                <col width="6%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
            </colgroup>
            <tbody>
            <tr class="align-middle">
                <th rowspan="1" colspan="4">신고자</th>
                <th rowspan="1" colspan="4">대상자</th>

                <th>알림</th>
                <td colspan="3">{{{getCommonCodeRadio 0 'declaration_send'}}}</td>

            </tr>

            <tr>
                <td>{{mem_id}}</td>
                <td>레벨 : {{level}}<br />등급 : {{grade}}</td>
                <td>{{mem_nick}}</td>
                <td>{{{sexIcon memSex mem_birth_year}}}</td>

                <td>
                    {{reported_mem_id}}
                    <input type="hidden" name="reported_mem_no" id="reported_mem_no" value="{{reported_mem_no}}" />
                </td>
                <td>레벨 : {{reported_level}}<br />등급 : {{reported_grade}}</td>
                <td>{{reported_mem_nick}}</td>
                <td>{{{sexIcon reported_memSex reported_mem_birth_year}}}</td>

                <th>조치범위</th>
                <td colspan="3">
                    {{{getCommonCodeCheck 3 'block_scope' 'Y' 'block_scope'}}}
                </td>
            </tr>

            <tr>
                <th colspan="2">제재 조치</th>
                <td colspan="10">
                    {{{getCommonCodeRadio op_code 'declaration_opCode' 'Y' 'opCode'}}}
                </td>
            </tr>

            <tr>
                <th colspan="2">누적 결제 수<br />/금액</th>
                <td colspan="2">{{addComma payCount}}개 <br />{{addComma payAmount}}원</td>

                <th colspan="2">누적 결제 수<br />/금액</th>
                <td colspan="2">{{addComma reported_payCount}}개 <br />{{addComma reported_payAmount}}원</td>


                <th {{#if room_no}}rowspan="5"{{else}}rowspan="4"{{/if}}>조치 선택</th>
                <td {{#if room_no}}rowspan="5"{{else}}rowspan="4"{{/if}} colspan="3" id="message">
                    {{{getCommonCodeCheck message 'declaration_Message'}}}
                </td>
            </tr>
            <tr>
                <th colspan="2">누적 선물 수<br />/금액</th>
                <td colspan="2">{{addComma giftCount}}개 <br />{{addComma giftAmount}}원</td>

                <th colspan="2">누적 선물 수<br />/금액</th>
                <td colspan="2">{{addComma reported_giftCount}}개 <br />{{addComma reported_giftAmount}}원</td>
            </tr>
            <tr>
                <th colspan="2">총 신고</th>
                <td colspan="2">{{addComma report_cnt}}건</td>

                <th colspan="2">총 신고/조치</th>
                <td colspan="2">{{addComma reported_cnt}}건<br />/{{addComma reported_ok_cnt}}건</td>
            </tr>

            {{#if room_no}}
            <tr>
                <th colspan="2">방송방</th>
                <td colspan="6">{{{roomNoLink room_no room_no}}}</td>
            </tr>
            {{/if}}

            <tr>
                <th colspan="2">신고 메시지</th>
                {{#if etc}}
                    <td colspan="6">{{{replaceNewLineToBr etc}}}</td>
                {{else}}
                    <td colspan="6">-</td>
                {{/if}}
            </tr>

            </tbody>
        </table>

            <%-- 에디터 --%>
            <div class="widget" id="declaration_editor">
                <input type="hidden" id ="notiMemo" name="notiMemo">
                <div class="widget-header">
                    <h3><i class="fa fa-user"></i> 신고 시 조치내용 </h3>
                </div>
                <div class="widget-content no-padding">
                    {{#equal status '0'}}
                        <div class="_editor" id="notiContents" name="notiContents">{{replaceHtml declaration_Message}}</div>
                    {{/equal}}
                    {{^equal status '0'}}
                        <div class="_editor" id="notiContents" name="notiContents" style="white-space: pre-line;">{{{replaceHtml ../op_msg}}}</div>
                    {{/equal}}
                </div>
            </div>
        </div>
    </div>
</script>