<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%
    String in_memNo = request.getParameter("memNo");
    String in_memId = request.getParameter("memId");
    String in_memNick = request.getParameter("memNick");
    String in_memSex = request.getParameter("memSex");
    String in_targetId = request.getParameter("targetId");
    String in_room_no = request.getParameter("room_no");
    String in_cast_no = request.getParameter("cast_no");
%>

<div class="col-md-12 no-padding" id="report_detail">
    <div class="widget-content">
        <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
            <li class="active"><a href="#reportDetail" role="tab" data-toggle="tab">경고/정지</a></li>
        </ul>
        <div class="tab-content no-padding">
            <div class="col-lg-12" style="padding: 5px 0px 5px 0px;">
                ㆍ운영자에 의한 변경 사유를 선택하여 주세요.
            </div>

            <table class="table table-bordered table-dalbit" style="margin-bottom: 0px;">
                <colgroup>
                    <col width="15%"/>
                    <col width="22%"/>
                    <col width="15%"/>
                    <col width="22%"/>
                    <col width="15%"/>
                    <col width="21%"/>
                </colgroup>
                <tbody>
                    <tr style="display: none">
                        <th colspan="6">대상자</th>
                    <tr style="display: none">
                        <th>아이디</th>
                        <td style="text-align: left" id="td_memId"></td>
                        <th>닉네임</th>
                        <td style="text-align: left" id="td_memNick"></td>
                        <th>성별</th>
                        <td style="text-align: left" id="td_memSex"></td>
                    </tr>
                    <tr>
                        <th>조치사항<br>선택</th>
                        <td colspan="5" style="text-align: left;height: 142px;">
                            <span id="declaration_Message"></span>
                            <input type="text" id="txt_declaration_message" class="form-control"/>
                        </td>
                    </tr>
                    <tr>
                        <th>제재조치</th>
                        <td colspan="5" style="text-align: left"><span id="member_declaration_slctType"></span></td>
                    </tr>
                </tbody>
            </table>

            <div class="col-md-12 no-padding mt10" style="text-align: center">
                <b>이미지 초기화</b> 변경사항을 적용하시겠습니까?<br><br>
                <button type="button" id="bt_complet" class="btn btn-default btn-sm">[확인 + 알림]</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/code/customer/customerCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/message/customer/declarationMessage.js?${dummyData}"></script>

<script>
    $(document).ready(function() {
        $('#bt_complet').click(function() {
            bt_complet_click(this.id);
        });
    });
    var memNo =  <%=in_memNo%>;
    var memId =  <%=in_memId%>;
    var memNick =  <%=in_memNick%>;
    var memSex =  <%=in_memSex%>;
    var targetId =  <%=in_targetId%>;
    var room_no =  <%=in_room_no%>;
    var cast_no = <%= in_cast_no%>;

    $("#declaration_reason").html(util.getCommonCodeSelect(-1, declaration_reason,"Y"));
    $("#member_declaration_slctType").html(util.getCommonCodeRadio(2, member_declaration_slctType));
    $("#declaration_Message").html(util.getCommonCodeCheck(-1, declaration_image_Message,"Y"));
    $('#td_memId').html(memId);
    $('#td_memNick').html(memNick);
    if(memSex == "m")
        $('#td_memSex').html("<label style=\"color: blue\">남</label>");
    else if(memSex == "f")
        $('#td_memSex').html("<label style=\"color: red\">여</label>");
    else
        $('#td_memSex').html("알수없음");

    function bt_complet_click(){
        var reportMessage ="";
        $('input:checkbox[name="declaration_Message"]').each(function() {
            if(this.checked){           //checked 처리된 항목의 값
                if(this.id == "declaration_Message99" ){
                    reportMessage = reportMessage + " - " + this.value + " : " + $("#txt_declaration_message").val() + "\n";
                }else {
                    reportMessage = reportMessage + " - " + this.value + "\n";
                }
            }
        });
        if($("#declaration_Message99").prop('checked')){
            if($("#txt_declaration_message").val().length < 1){
                alert("기타 사유를 입력해 주십시오.");
                return;
            }
        }
        if(reportMessage == ""){
            alert("조치사항을 선택해 주십시오.");
            return;
        }

        var strName = ADMIN_NICKNAME;
        var date = new Date();
        var timestamp = date.getFullYear() + "-" +
            common.lpad(date.getMonth() + 1,2,"0") + "-" +
            common.lpad(date.getDate(),2,"0");
            + " " +
            common.lpad(date.getHours(),2,"0") + "." +
            common.lpad(date.getMinutes(),2,"0") + "." +
            common.lpad(date.getSeconds(),2,"0");


        var msgValue;
        var msgTitle;
        var slctType = $('input:radio[name="slctType"]:checked').parent().find("span").text();
        var radioValue = $('input:radio[name="slctType"]:checked').val();
        var blockDay = 0;
        if(radioValue == 6 || radioValue == 7){
            msgValue = declarationMessage.out;
            msgTitle = declarationMessage.outTitle;
        } else if(radioValue == 3 || radioValue == 4 || radioValue ==5){
            if(radioValue == 3){blockDay = 1;}
            if(radioValue == 4){blockDay = 3;}
            if(radioValue == 5){blockDay = 7;}
            msgValue = declarationMessage.stop;
            msgTitle = declarationMessage.stopTitle;
        } else if(radioValue == 2) {
            msgValue = declarationMessage.warning;
            msgTitle = declarationMessage.warningTitle;
        }

        msgValue = msgValue.replace(/{{name}}/gi, strName)
            .replace(/{{nickName}}/gi, memNick)
            .replace(/{{message}}/gi, reportMessage)
            .replace(/{{timestamp}}/gi, timestamp)
            .replace(/{{blockDay}}/gi, blockDay)
            .replace(/{{slctType}}/gi, slctType);

        msgTitle = msgTitle.replace(/{{name}}/gi, strName)
            .replace(/{{nickName}}/gi, memNick)
            .replace(/{{message}}/gi, reportMessage.replace(/\-/gi, "<br>-"))
            .replace(/{{timestamp}}/gi, timestamp)
            .replace(/{{blockDay}}/gi, blockDay)
            .replace(/{{slctType}}/gi, slctType);

        console.log(slctType);
        console.log(msgValue);

        if(confirm("신고 하시겠습니까?")) {
            var obj = new Object();
            obj.mem_no = memNo;             // 신고자 대상 ID검색용
            if(!common.isEmpty(room_no)){
                obj.room_no = room_no;
                obj.slctReason = 1;
            } else if(!common.isEmpty(cast_no)) {
                obj.cast_no = cast_no;
                // obj.slctReason // -todo
            } else {
                obj.slctReason = 2;
            }
            obj.slctType = $('input:radio[name="slctType"]:checked').val();
            obj.notiContents = msgTitle;
            obj.notimemo = msgValue;
            obj.mem_sex = memSex;
            util.getAjaxData("imageReset", "/rest/customer/image/reset", obj, update_success, fn_fail);
        }return false;

    }

    function update_success(dst_id, response) {
        alert(response.message);

        eval("window.opener.fnc_"+targetId +".selectMainList()");

        window.close();
    }
    function fn_fail(data, textStatus, jqXHR){
        console.log(data, textStatus, jqXHR);
    }
</script>