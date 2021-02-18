<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <!-- DATA TABLE -->
        <div class="top-left pull-left dataTable-div col-md-12 no-padding">
            <div class="comments pt10 pb15 col-md-7 no-padding">ㆍ회원이 요청한 결제 취소 건을 처리하고, 취소 처리상태를 확인 할 수 있습니다.</div>
            <div class="col-md-5 no-padding pull-right mb5">
                <span id="pay_summaryArea"></span>
            </div>
            <div class="col-md-7 no-padding">
                <label id="payStateArea" onchange="sel_change_payStateArea();"></label>
                <label id="payPlatformArea" onchange="sel_change_payPlatformArea();"></label>
                <label id="payWayArea" onchange="sel_change_payWayArea();"></label>
                <label id="payInnerArea" onchange="sel_change_payInnerArea();" style="border: 1px solid #632beb"></label>
                <span name="slctDateType" id="slctDateType" onchange="seldateType_change();" style="display: none"></span>
                <div class="input-group date" id="rangeMemberDatepicker" style="display: none">
                    <label for="displayMemberDate" class="input-group-addon">
                        <span><i class="fa fa-calendar"></i></span>
                    </label>
                    <input type="text" name="displayDate" id="displayMemberDate" class="form-control" />
                </div>
                <input type="hidden" name="startMemberDate" id="startMemberDate">
                <input type="hidden" name="endMemberDate" id="endMemberDate" />
                <button type="button" class="btn btn-success" id="bt_searchMember" style="display: none">검색</button>
            </div>
        </div>
        <div class="col-md-12 no-padding">
            <c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}" />
            <c:if test="${fn:contains(url, 'memberPopup')}">
                <div class="col-md-6 no-padding">
                    <span id="payInsertDisplay" style="cursor: hand; font-size: 13px" onclick="fnDisplay()" >IOS 내역추가 ▽</span>
                    <span id="exampleDate" style="margin-left: 17%">일시 ex) 2020-01-01 11:11:11</span>
                    <div class="payInsertInfo hide" id="payInsert">
                        <input class="form-control" name="memberNumber" id="memNo" placeholder="회원번호" style="width: 17%">
                        <select class="form-control" id="payWayInfo" onchange="fnPayway(this.value)">
                            <option selected value="">결제수단 ▽</option>
                            <option value="InApp">InApp</option>
                            <%--<option value="kakaopay">카카오페이</option>
                            <option value="payco">페이코</option>
                            <option value="tmoney">티머니</option>--%>
                        </select>
                        <input class="form-control" name="comDate" id="comDate" placeholder="시도일시" style="width: 20%">
                        <input class="form-control" name="okDate" id="okDate" placeholder="완료일시" style="width: 20%">
                        <span id="payItemArea">
                        </span>
                        <select class="form-control" id="itemCnt">
                            <option selected value="">수량 ▽</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select>
                        <button type="button" class="btn btn-success" id="btnPayInsert">추가</button>
                    </div>
                </div>
            </c:if>
        </div>
        <div class="col-md-12 no-padding">
            <button class="btn btn-default btn-sm print-btn pull-right excelDownBtn" type="button" ><i class="fa fa-print"></i>Excel Down</button>
        </div>
        <table id="list_info" class="table table-sorting table-hover table-bordered">
            <thead></thead>
            <tbody></tbody>
        </table>
        <button class="btn btn-default btn-sm print-btn pull-right excelDownBtn" type="button" ><i class="fa fa-print"></i>Excel Down</button>
        <!-- // DATA TABLE -->
    </div>
</div> <!-- //wrapper -->

<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/payment/payCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/statusHelper.js?${dummyData}"></script>
<script type="text/javascript">

    var dtList_info_pay;

    var tmp_searchPayStatus = 1; //결제완료 디폴트 호출
    var tmp_ostype = -1;
    var txt_search = "";
    var tmp_innerType = "0";
    var tmp_payWay = "all";
    var sDate;
    var eDate;
    var memberDataType;

    $(document).ready(function() {
        $("#slctDateType").html(util.getCommonCodeSelect(-1, slctPayMemberDateType));
        $("#displayMemberDate").statsDaterangepicker(
            function(start, end, t1) {
                $("#startMemberDate").val(start.format('YYYY.MM.DD'));
                $("#endMemberDate").val(end.format('YYYY.MM.DD'));
            }
        );
        $('#exampleDate').hide();
    });


    function getPayList(tmp) {
        var slctType = 0;
        if(tmp == "payment"){
            memberDataType = 99;
            $("#slctDateType").hide();
            $("#rangeMemberDatepicker").hide();
            $('#bt_searchMember').hide();
            slctType = 0;
        }else{
            memberDataType = 0;
            $("#slctDateType").show();
            $('#bt_searchMember').show();
            var dateTime = new Date();
            dateTime = moment(dateTime).format("YYYY.MM.DD");
            $("#startMemberDate").val(dateTime);
            $("#endMemberDate").val(dateTime);
            slctType = 1;
        }
        var dtList_info_pay_data = function(data) {
            data.searchText = txt_search;                        // 검색명
            data.sDate = sDate;
            data.eDate = eDate;
            data.ostype = tmp_ostype;
            data.searchPayStatus = tmp_searchPayStatus;
            data.innerType = tmp_innerType;
            data.payWay = tmp_payWay;
            data.memberDataType = memberDataType;
            data.slctType = slctType;
            data.newSearchType = $("#searchMember").val();

        };
        if(tmp == "payment"){
            dtList_info_pay = new DalbitDataTable($("#list_info"), dtList_info_pay_data, payDataTableSource.payList);
        }else{
            dtList_info_pay = new DalbitDataTable($("#list_info"), dtList_info_pay_data, payDataTableSource.memPayHistory);
        }
        dtList_info_pay.useCheckBox(false);
        dtList_info_pay.useIndex(true);
        dtList_info_pay.setPageLength(50);
        dtList_info_pay.useInitReload(true);
        dtList_info_pay.createDataTable(pay_listSummary);

        $("#payStateArea").html(util.getCommonCodeSelect('1', payStatus));
        $("#payPlatformArea").html(util.getCommonCodeSelect('-1', payPlatform));
        $("#payWayArea").html(util.getCommonCodeSelect('all', payWay));
        $("#payInnerArea").html(util.getCommonCodeSelect('0', innerType));

    }

    function pay_listSummary(json){
        console.log(json);
        var template = $("#pay_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
            , length : json.recordsTotal
        };
        var html = templateScript(data);
        $("#pay_summaryArea").html(html);


        ui.tableHeightSet();
        ui.paintColor();

        // var template = $("#pay_tableSummary2").html();
        // var templateScript = Handlebars.compile(template);
        // var data = {
        //     content : json.summary
        //     , length : json.recordsTotal
        // };
        // var html = templateScript(data);
        // $("#pay_summaryArea2").html(html);
    }

    /* 취소버튼 클릭 */
    function cancelClick(cancelData){

        var result = confirm(cancelData.memnick+"님의 "+ common.addComma(cancelData.prdtprice) +"원에 대한 결제를 취소하시겠습니까?");

        if(result){
            var restUrl='';
            if(cancelData.paycd == 'CN'){
                restUrl='card'
            }else if(cancelData.paycd == 'RA'){
                restUrl='bank'
            }else if(cancelData.paycd == 'MC'){
                restUrl='phone'
            }else if(cancelData.paycd == 'GM'){
                restUrl='gm'
            }else if(cancelData.paycd == 'GG'){
                restUrl='gg'
            }else if(cancelData.paycd == 'GC'){
                restUrl='gc'
            }else if(cancelData.paycd == 'HM'){
                restUrl='hm'
            }else if(cancelData.paycd == 'toss' || cancelData.paycd == 'payco' || cancelData.paycd == 'cashbee' || cancelData.paycd == 'tmoney' || cancelData.paycd == 'kakaopay' ){
                restUrl='payletter'
            }else if(cancelData.paycd == 'kakaoMoney'){
                restUrl='kakaoMoney'
            }else {
                alert("결제수단 오류 확인필요");
            }

            var data = {
                prdtprice : cancelData.prdtprice
                , mobilid : cancelData.mobilid
                , tradeid : cancelData.tradeid
                , mrchid : cancelData.storeid
                , memno : cancelData.memno
                , dalcnt : cancelData.dalcnt
                , paycd : cancelData.paycd
            };

            util.getAjaxData("cancel", "/rest/payment/pay/cancel/"+restUrl, data, payCancelSuccess);
        }
    }

    /* 취소버튼 클릭 */
    function payCancelSuccess(dist_id, response){
        alert(response.message);
        dtList_info_pay.reload(pay_listSummary);
    }

    function sel_change_payStateArea(){
        tmp_searchPayStatus = $("select[name='searchPayStatus']").val();
        dtList_info_pay.reload(pay_listSummary);
    }
    function sel_change_payPlatformArea(){
        tmp_ostype = $("select[name='ostype']").val();
        dtList_info_pay.reload(pay_listSummary);
    }

    function sel_change_payInnerArea(){
        tmp_innerType = $("select[name='innerType']").val();
        dtList_info_pay.reload(pay_listSummary);
    }

    function sel_change_payWayArea(){
        tmp_payWay = $("select[name='payWay']").val();
        dtList_info_pay.reload(pay_listSummary);
    }
    /*=============엑셀==================*/
    $('.excelDownBtn').on('click', function(){
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);
        formData.append("searchText", txt_search);
        // formData.append("period", tmp_period);
        formData.append("sDate", sDate);
        formData.append("eDate", eDate);
        formData.append("ostype", tmp_ostype);
        formData.append("searchPayStatus", tmp_searchPayStatus);
        formData.append("innerType", tmp_innerType);
        formData.append("payWay", tmp_payWay);
        formData.append("memberDataType", memberDataType);

        util.excelDownload($(this), "/rest/payment/pay/listExcel", formData, fn_excelSuccess, fn_excelFail);

    });
    function fn_excelSuccess(){
        alert("다운로드 완료");
    }
    function fn_excelFail(){
        alert("다운로드 실패");
    }

    function seldateType_change(){
        if($("#slctDateType").find("select").val() == 0){
            sDate = "";
            eDate = "";
            $("#rangeMemberDatepicker").hide();
        }else{
            $("#rangeMemberDatepicker").show();
        }
    }

    $('#bt_searchMember').click( function() {       //검색
        sDate = $("#startMemberDate").val();
        eDate = $("#endMemberDate").val();
        memberDataType = $("#slctDateType").find("select").val();
        dtList_info_pay.reload(pay_listSummary);
    });

    function fnDisplay(){
        if($('#payInsert').hasClass('show')){
            $('#payInsert').removeClass('show');
            $('#payInsert').addClass('hide');
            $('#payInsertDisplay').text("IOS 내역추가 ▽");
            $('#exampleDate').hide();
            $('#payInsert').hide();
        }else{
            $('#payInsert').removeClass('hide');
            $('#payInsert').addClass('show');
            $('#payInsertDisplay').text("IOS 내역추가 △");
            $('#exampleDate').show();
            $('#payInsert').show();
        }
    }

    function fnPayway(id){
        if(id == 'InApp'){
            $("#payItemArea").html(util.getCommonCodeSelect(-1, inAppItem));
        }else{
            $("#payItemArea").html(util.getCommonCodeSelect(-1, elseItem));
        }
    }

    $('#btnPayInsert').click( function() {
        var memNo = $('#memNo').val();
        var payWayInfo = $('#payWayInfo').val();
        var comDate = $('#comDate').val();
        var okDate = $('#okDate').val();
        var payItem = $('#payItem').val();
        var itemCnt = $('#itemCnt').val();

        //벨리데이션 체크
        if(common.isEmpty(memNo)) {
            alert("회원번호를 입력해주세요.");
            $('#memNo').focus();
            return false;
        }else if(common.isEmpty(payWayInfo)){
            alert("결제수단을 선택해주세요.");
            $('#payWayInfo').focus();
            return false;
        }else if(common.isEmpty(comDate)){
            alert("시도일시를 입력해주세요.");
            $('#comDate').focus();
            return false;
        }else if(common.isEmpty(okDate)){
            alert("완료일시 입력해주세요.");
            $('#okDate').focus();
            return false;
        }else if(payItem == -1){
            alert("결제아이템을 선택해주세요.");
            $('#payItem').focus();
            return false;
        }else if(common.isEmpty(itemCnt)){
            alert("결제수량을 선택해주세요.");
            $('#itemCnt').focus();
            return false;
        }

        var data = {
            mem_no : memNo
            , pay_way : payWayInfo
            , pay_dt_comein : comDate
            , okDate : okDate
            , item_code : payItem
            , item_amt : itemCnt
        };

        util.getAjaxData("payAdd", "/rest/payment/pay/add/", data, payAddSuccess);

    });

    function payAddSuccess(dst_id, response){
        alert(response.message);
        dtList_info_pay.reload(pay_listSummary);
    }



</script>

<script id="pay_tableSummary" type="text/x-handlebars-template">
    <table class="table table-condensed table-dark-header table-bordered no-margin" style="margin-right:0px">
        <colgroup>
            <%--<col width="35%"/><col width="65%"/>--%>
        </colgroup>

        <tr>
            <th class="_bgColor" data-bgcolor="#bfbfbf">구분</th>
            <th colspan="5" class="_bgColor" data-bgcolor="#8faadc">총 결제</th>
            <th colspan="2" class="_bgColor" data-bgcolor="#f8cbad">결제 취소</th>
            <th colspan="2" class="_bgColor _fontColor" data-bgcolor="#000000" data-fontcolor="#ffff00">(취소 제외) 순 결제 금액</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#d9d9d9">부가세</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">성공</th>
            <th class="_bgColor" data-bgcolor="#d9d9d9">시도</th>
            <th class="_bgColor" data-bgcolor="#d9d9d9">실패</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">금액</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">성공율</th>
            <th class="_bgColor" data-bgcolor="#fbe5d6">건</th>
            <th class="_bgColor" data-bgcolor="#fbe5d6">금액</th>
            <th class="_bgColor _fontColor" data-bgcolor="#595959" data-fontcolor="white">건</th>
            <th class="_bgColor _fontColor" data-bgcolor="#595959" data-fontcolor="white">금액</th>
        </tr>
        <tr>
            <td>포함</td>
            <td>{{addComma content.totalPayCnt}}건</td>
            <td>{{addComma content.totalTryCnt}}건</td>
            <td>{{addComma content.totalFailCnt}}건</td>
            <td>{{addComma content.totalPayAmt}}원</td>
            <td>{{average content.totalPayCnt content.totalTryCnt}}%</td>
            <td>{{addComma content.totalPayCancelCnt}}건</td>
            <td>{{addComma content.totalPayCancelAmt}}원</td>
            <td>{{addComma content.totalRealPayCnt}}건</td>
            <td>{{addComma content.totalRealPayAmt}}원</td>
        </tr>
        <tr>
            <td class="_fontColor font-bold" data-fontcolor="red">제외</td>
            <td>{{addComma content.totalPayCnt}}건</td>
            <td>{{addComma content.totalTryCnt}}건</td>
            <td>{{addComma content.totalFailCnt}}건</td>
            <td>{{vatMinus content.totalPayAmt}}원</td>
            <td>{{average content.totalPayCnt content.totalTryCnt}}%</td>
            <td>{{addComma content.totalPayCancelCnt}}건</td>
            <td>{{vatMinus content.totalPayCancelAmt}}원</td>
            <td class="_fontColor font-bold" data-fontcolor="red">{{addComma content.totalRealPayCnt}}건</td>
            <td class="_fontColor font-bold" data-fontcolor="red">{{vatMinus content.totalRealPayAmt}}원</td>
        </tr>
    </table>
</script>