<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%--<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>--%>
<script src="/js/webrtc_adaptor.js"></script>
<%
    Object in_cmid = request.getParameter("cmid");
    Object in_rowNum = request.getParameter("rownum");
    Object in_logtable = request.getParameter("logtable");
%>


<div class="pt10" id="contentTab">
    <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
        <li class="active"><a href="#smsPopupDetail" role="tab" data-toggle="tab" id="tab_smsPopupDetail">운영자 문자발송</a></li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane fade active in inline" id="smsPopupDetail">
            <div class="smsSendPopup"></div>
        </div>
    </div>
</div>

<div class="modal fade" id="smsPreViewModal" tabindex="-1" role="dialog" aria-labelledby="smsPreViewModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 250px;">
        <div class="modal-content">
            <div class="modal-header pb10">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="_smsPreViewModalTitle"></h4>
            </div>
            <div class="modal-body">
                <p id="_smsPreViewModalBody"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> 닫기</button>
            </div>
        </div>
    </div>
</div>


</div>

<jsp:include page="/WEB-INF/view/common/util/select_memeberList.jsp"></jsp:include>

<script type="text/javascript" src="/js/code/customer/customerCodeList.js?${dummyData}"></script>

<script>
    var cmid = "<%=in_cmid%>";
    var rowNum = "<%=in_rowNum%>";
    var logDateTableName = "<%=in_logtable%>";

    $(document).ready(function(){
        if(common.isEmpty(cmid)){
            init();
        }else{
            loadDetail_smsSend();
        }
    });

    function init(){
        var data = {
            "msg_type" : "0"
            ,"is_direct" : "0"
            ,"subject": "[달빛라이브]"
            ,"msg_body": "[달빛라이브]"
        };

        var template = $('#tmp_SmsSend_view').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html=templateScript(context);

        $(".smsSendPopup").append(html);
        initData_smsSend();
        smsSend_eventInit();
    }

    function initData_smsSend(){
        // 캘린더
        $(".smsSendPopup").find('.input-group.date').datetimepicker({
            format: 'L'
            , date: new Date()
        });

        // 시간 Select CSS 적용
        $(".smsSendPopup").find("#timeHour").attr("class", "select-time");
        $(".smsSendPopup").find("#timeMinute").attr("class", "select-time");
    }

    function smsSend_eventInit(){

        // 번호 추가 엔터 이벤트
        $(".smsSendPopup").find('input[id="add_phone"]').keydown(function(e) {
            if(e.keyCode == 13) {
                $(".smsSendPopup").find('input[id="btn_addMember"]').click();
            }
        });

        // 미리보기
        $(".smsSendPopup").find('#preViewBtn').on('click', function(){
            var title = $(".smsSendPopup").find("input[name=subject]").val();
            var cont = $(".smsSendPopup").find("textarea[name=msg_body]").val();

            //SMS일경우 제목 보여지지 않음.
            if($(".smsSendPopup").find("input:radio[name=msg_type]:checked").val() == 0){
                $("#_smsPreViewModalTitle").hide();
            }else{
                $("#_smsPreViewModalTitle").show();
            }

            $("#_smsPreViewModalTitle").html(title);
            $("#_smsPreViewModalBody").html(util.replaceNewLineToBr(cont));
        });

        //수신대상 선택
        $(".smsSendPopup").find("input[name='is_all']").change(function () {

            $(".smsSendPopup").find("#btn_selectMember").prop("disabled", true);
            $(".smsSendPopup").find("#btn_addMember").prop("disabled", true);
            $(".smsSendPopup").find("#add_phone").val("");
            $(".smsSendPopup").find("#add_phone").prop("disabled", true);
            $(".smsSendPopup").find("#div_selectTarget").hide();
            $(".smsSendPopup").find("#div_selectTarget").empty();

            if ($(this).val() == "7") { //지정
                $(".smsSendPopup").find("#btn_selectMember").prop("disabled", false);
                $(".smsSendPopup").find("#div_selectTarget").show();
                $(".smsSendPopup").find("#btn_addMember").prop("disabled", false);
                $(".smsSendPopup").find("#add_phone").prop("disabled", false);
                $(".smsSendPopup").find("#div_selectTarget").show();
            }
        });

        // 수신대상 - 지정회원
        $(".smsSendPopup").find("#btn_selectMember").on("click", function () {
            showPopMemberList(choiceMember_smsSend, choiceMemberIsValid_smsSend);
        });

        // 수신대상 - 직접입력
        $(".smsSendPopup").find("#btn_addMember").on("click", function () {
            var data = {
                "mem_phone" : $(".smsSendPopup").find("#add_phone").val()
                ,"mem_no" : "0"
                ,"mem_nick": "직접입력"
            };


            if(choiceMemberIsValid_smsSend(data)){
                choiceMember_smsSend(data);
                $(".smsSendPopup").find("#add_phone").val("");
            }
        });

        // 발송여부
        $(".smsSendPopup").find("input[name='is_direct']:radio").change(function () {
            var type = this.value;

            var sendDate = moment();

            // 캘린더 초기값
            $(".smsSendPopup").find("#smsSend-div-sendDate").find("#smsSend-sendDate").val(sendDate.format('YYYY.MM.DD'));

            // 시간 Select CSS 적용
            $(".smsSendPopup").find("#smsSend-div-sendDate").find("#timeHour").val(sendDate.hour().toString().length == 1?("0"+sendDate.hour()):sendDate.hour());
            $(".smsSendPopup").find("#smsSend-div-sendDate").find("#timeMinute").val(sendDate.minute().toString().length == 1?("0"+sendDate.minute()):sendDate.minute());

            //예약 발송 일 경우 날짜 추가
            if (type == "1") {
                $(".smsSendPopup").find("#smsSend-div-sendDate").show();

            } else {
                $(".smsSendPopup").find("#smsSend-div-sendDate").hide();

            }
        });


        // 발송 버튼
        $(".smsSendPopup").find("#insertBtn").on("click", function () {
            insert_smsSend();
        })
    }
    
    /**
     *  sms 상세 데이터 호출
    * */
    function loadDetail_smsSend(){
        console.log("[loadChat]");
        var data = {
            "cmid" : cmid
            ,"logDateTableName" : logDateTableName
        };

        util.getAjaxData("select", "/rest/customer/sms/detail", data, fn_load_sms_detail_success);
    }

    function fn_load_sms_detail_success(dst_id, response, dst_params){
        if(response.result != "fail" && !common.isEmpty(response.data)){
            response.data["rowNum"] = rowNum;

            var template = $('#tmp_SmsSend_view').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html=templateScript(context);

            console.log()

            $(".smsSendPopup").append(html);

            initData_smsSend();
            smsSend_eventInit();

            initUpdateData_smsSend(response.data);
        }else{

        }
    }

    function initUpdateData_smsSend(target){
        var data = {
            "mem_phone" : target.dest_phone
            ,"mem_no" : common.isEmpty(target.mem_no) ? "0" : target.mem_no
            ,"mem_nick": common.isEmpty(target.mem_nick) ? "직접입력" : target.mem_nick
        };
        choiceMember_smsSend(data);

        checkContText_smsSend();
    }


    function insert_smsSend(){
        var data = getDetailData_smsSend();

        if(!isValid(data)){
            return false;
        }

        if(!confirm("문자를 발송 하시겠습니까?")){
            return false;
        }

        util.getAjaxData("insert", "/rest/customer/sms/send", data, fn_insert_success_smsSend, fn_fail);
    }

    function fn_insert_success_smsSend(dst_id, data, dst_params){
        if(data.result == "fail"){
            alert(data.message);
            return false;
        }

        alert(
            data.message +
            '\n- 성공 : ' + data.data.sucCnt + '건' +
            (data.data.failCnt != "0" ? '\n- 실패 : ' + data.data.failCnt + '건' : '')
        );


        opener.smsList();
        window.close();
    };


    // Ajax 실패
    function fn_fail(data, textStatus, jqXHR){
        alert(data.message);

        console.log(data, textStatus, jqXHR);
    };


    function getDetailData_smsSend(){
        var resultJson ={};

        var formArray = $(".smsSendPopup").find("#form_smsSend").serializeArray();
        for (var i = 0; i < formArray.length; i++){
            resultJson[formArray[i]['name']] = formArray[i]['value'];
        }

        //Date 처리이이이~~~
        resultJson['send_time'] = ""
        if($(".smsSendPopup").find("input[name=is_direct]:checked").val() != 0) {    //즉시 발송 시 시간 초기화
            var sendDateDiv = $(".smsSendPopup").find("#smsSend-div-sendDate");
            resultJson['send_time'] = sendDateDiv.find("#smsSend-sendDate").val().replace(/[^0-9]/gi, '') + sendDateDiv.find("#timeHour").val() + sendDateDiv.find("#timeMinute").val() + "00";
        }

        //지정회원 parsing
        var selectTargets = [];
        var send_cnt = -1;
        var valIs_All = $(".smsSendPopup").find("input[name=is_all]:checked").val();
        if (valIs_All == "7") {
            send_cnt = $(".smsSendPopup").find("#div_selectTarget").find("p").length;
            $(".smsSendPopup").find("#div_selectTarget").find("p").each(function () {
                var target = {};
                var phone = $(this).prop("id");
                var memno = $(this).data("memno");

                target["mem_no"] = memno;
                target["phone"] = phone;
                selectTargets.push(target);
            })

            resultJson['mem_nos'] = selectTargets;
        }
        resultJson['send_cnt'] = send_cnt;

        resultJson['vxml_file'] = "7";

        dalbitLog(resultJson)
        return resultJson;
    };

    function isValid(data){

        if(data.is_all == '7'){ // 지정회원
            if(common.isEmpty(data.mem_nos)){
                alert("발송할 대상을 선택하여 주시기 바랍니다.")
                return false;
            }
        }

        if(common.isEmpty(data.subject)){
            alert("제목을 입력하여 주시기 바랍니다.")
            return false;
        }

        if(common.isEmpty(data.msg_body)){
            alert("내용을 입력하여 주시기 바랍니다.")
            return false;
        }

        return true;
    }


    // [수신대상 선택 - 지정회원] 회원 추가
    function choiceMember_smsSend(data) {
        console.log(data);
        if(!common.isEmpty(data.mem_phone)){
            var html = '<p id="' + data.mem_phone + '" data-memno="'+ data.mem_no +'">' + data.mem_phone + '(' +data.mem_nick+ ') <a style="cursor: pointer;" onclick="delMember($(this))">[X]</a></p>'

            // if($(".smsSendPopup").find("#div_selectTarget").find("p").length >= 20){
            //     alert("수신대상자는 최대 20명까지 지정 가능합니다.");
            //     return false;
            // }

            $(".smsSendPopup").find("#div_selectTarget").append(html);
        }

        $("#memberLength").text('총 : ' + $("#div_selectTarget").find('p').length + ' 명');
    };

    // [수신대상 선택 - 지정회원] 회원 삭제
    function delMember(dom) {
        dom.parent("p").remove();
    }

    function choiceMemberIsValid_smsSend(data) {
        console.log(data);
        if(common.isEmpty(data.mem_phone) || data.mem_phone.length < 10 || !data.mem_phone.match("(01[016789])(\\d{3,4})(\\d{4})")){
            alert("선택한 회원은 휴대폰번호가 비정상 이거나 존재하지 않습니다.");
            return false;
        }else{
            return true;
        }
    }


    // 내용 byte 체크
    function checkContText_smsSend(){
        var text = $(".smsSendPopup").find("#smsSend-msg_body").val();
        var byteSize = common.getStringByteLength(text);

        if(byteSize > 80){
            $(".smsSendPopup").find("input:radio[name=msg_type][value='5']").prop("checked", true);
        }

        util.textareaResize(document.getElementById("smsSend-msg_body"));

        window.resizeTo(window.outerWidth, $(".container").height()+100);
    }

    function jsonDataExcel() {

        let input = event.target;
        let reader = new FileReader();
        reader.onload = function () {
            let data = reader.result;
            let workBook = XLSX.read(data, { type: 'binary' });
            workBook.SheetNames.forEach(function (sheetName) {
                console.log('SheetName: ' + sheetName);
                let rows = XLSX.utils.sheet_to_json(workBook.Sheets[sheetName]);
                console.log(rows)
                excelMemberListInfo(rows);
            })
        };
        reader.readAsBinaryString(input.files[0]);
    }

    function excelMemberListInfo(list){
        if(!common.isEmpty(list[0].mem_no)){
            for(var i=0;i<list.length;i++){
                util.getAjaxData("insert", "/rest/customer/member/info", list[i], fn_excelMemberListInfo_success, fn_fail);
            }
        }else if(!common.isEmpty(list[0].mem_phone)){
            for(var i=0;i<list.length;i++) {
                var data = {
                    "mem_phone": list[i].mem_phone
                    , "mem_no": "0"
                    , "mem_nick": "직접입력"
                };

                if(common.isEmpty(data.mem_phone) || data.mem_phone.length < 10 || !data.mem_phone.match("(01[016789])(\\d{3,4})(\\d{4})")) {
                    alert("선택한 회원은 휴대폰번호가 비정상 이거나 존재하지 않습니다.\n" +
                          "번호 : " + list[i].mem_phone);
                    break;
                }else{
                    choiceMember_smsSend(data);
                    $(".smsSendPopup").find("#add_phone").val("");
                }
            }
        }else{
            alert('회원번호 : mem_no \n' +
                  '휴대폰번호 : mem_phone \n' +
                  'ex) mem_phone \n' +
                  '    01012340000 \n' +
                  '    01056780000 \n' +
                  '형식으로 목록을 작성 해주십시오.');
        }
    }
    function fn_excelMemberListInfo_success(dst_id, response){
        choiceMember_smsSend(response.data);
    }
</script>


<script type="text/x-handlebars-template" id="tmp_SmsSend_view">
    <form id="form_smsSend">
        <input type="hidden" name="sms_idx" value="{{cmid}}" />
        <div class="row col-md-12">
            <table class="table table-bordered table-dalbit">
                <colgroup>
                    <col width="8%" />
                    <col width="8%" />
                    <col width="8%" />
                    <col width="8%" />
                    <col width="8%" />
                    <col width="8%" />
                    <col width="8%" />
                    <col width="8%" />
                    <col width="8%" />
                    <col width="8%" />
                    <col width="8%" />
                    <col width="8%" />
                </colgroup>
                <tbody>
                <tr class="align-middle">
                    <th>No</th>
                    <td colspan="5">{{rowNum}}</td>

                    <th>발송일시</th>
                    <td colspan="5">{{report_time}}</td>
                </tr>
                <tr>
                    <th>발송형태</th>
                    <td colspan="11">
                        {{{getCommonCodeRadio msg_type 'sms_msgType'}}}
                    </td>
                </tr>
                <tr>
                    <th>수신대상</th>
                    <td colspan="11" style="width:50%;">
                        <div>
                            <label class="control-inline fancy-radio custom-color-green"><input type="radio" value="11" id="is_all11" name="is_all" class="form-control"><span><i></i>전체</span> </label>
                            <label class="control-inline fancy-radio custom-color-green"><input type="radio" id="is_all99" name="is_all" value="99" class="form-control"><span><i></i>테스트 계정</span></label>
                            <div>
                                <label class="control-inline fancy-radio custom-color-green"><input type="radio" value="7" id="is_all7" name="is_all" class="form-control" checked="checked"><span><i></i>지정 회원 </span></label>
                                <input type="button" value="회원검색" class="btn btn-success btn-xs" id="btn_selectMember"/>
                                <span class="pr5 pl5"> | </span>
                                <input type="text" class="form-control control-inline" name="add_phone" id="add_phone" placeholder="수신번호 입력" maxlength="11" style="width:130px; height:25px;">
                                <input type="button" value="번호추가" class="btn btn-success btn-xs pl5" id="btn_addMember"/>
                                <span class="ml15" id="memberLength"></span>
                            </div>
                            <input type="file" id="file" onchange="jsonDataExcel()">
                            <%--
                            <div>
                                <label class="control-inline fancy-radio custom-color-green"><input type="radio" value="8" id="is_all8" name="is_all" class="form-control" checked="checked"><span><i></i>직접입력</span></label>
                                <input type="text" class="form-control control-inline" name="add_phone" id="add_phone" placeholder="수신번호 입력" maxlength="11" style="width:130px; height:25px;">
                                <input type="button" value="번호추가" class="btn btn-success btn-xs" id="btn_addMember"/>
                                </div>
                            --%>

                        </div>
                        <div id="div_selectTarget" style="padding-left: 30px;">
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>발송여부</th>
                    <td colspan="11">
                        <div>
                            {{{getCommonCodeRadio is_direct 'sms_isDirect' 'N' 'is_direct'}}}
                        </div>
                        <div class="input-group date" id="smsSend-div-sendDate" style="display:none;">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            <input type="text" class="form-control" id="smsSend-sendDate" style="width:100px; height:35px;">
                            {{{getCommonCodeSelect 00 'timeHour'}}}
                            <span> : </span>
                            {{{getCommonCodeSelect 00 'timeMinute'}}}
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td colspan="11" style="width:50%;">
                        <input type="text" class="form-control" name="subject" id="smsSend-subject" placeholder="LMS 발송 제목을 입력해주세요." value="{{subject}}" maxlength="30">
                        <span style="color: red; font-size:0.9em">* LMS 제목은 한글 최대 30자까지 입력 가능합니다.</span>
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="11">
                        <div>
                            <textarea class="form-control" name="msg_body" id="smsSend-msg_body" rows="8" cols="30" placeholder="SMS/LMS 발송 문자 내용을 입력해 주세요." style="resize: none" maxlength="1000" oninput="checkContText_smsSend()">{{{msg_body}}}</textarea>
                            <span style="color: red; font-size:0.9em">* SMS 최대 40자(한글) / LMS 최대 1000자(한글)까지 입력 가능합니다.</span><br>
                        </div>
                    </td>
                </tr>
                {{#if cmid}}
                <tr>
                    <th>발신자</th>
                    <td colspan="11">{{send_name}}</td>
                </tr>
                {{/if}}
            </tbody>
        </table>
        <div class="col-md-6 pull-left pl0">
            <button class="btn btn-default" type="button" id="closeBtn" onclick="javascript:window.close();">닫기</button>
        </div>
        <div class="col-md-6 pull-right pr0">
            <button class="btn btn-info _layerOpen" data-toggle="modal" data-target="#smsPreViewModal" type="button" id="preViewBtn">미리보기</button>
            {{#if cmid}}
                <button class="btn btn-primary" type="button" id="insertBtn">재발송</button>
            {{else}}
                <button class="btn btn-primary" type="button" id="insertBtn">발송</button>
            {{/if}}
        </div>
        </div>
    </form>
</script>
