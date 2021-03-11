<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<ul class="nav nav-tabs nav-tabs-custom-colored mt5">

    <li class="active" id="li_newDal"><a href="#wallet_main_table" role="tab" data-toggle="tab" onclick="newWalletList('dal');">new달</a></li>
    <li id="li_newByeol"><a href="#newWallet" role="tab" data-toggle="tab" onclick="newWalletList('byeol');">new별</a></li>

    <li id="li_dal"><a href="#wallet_main_table" role="tab" data-toggle="tab" onclick="memberWalletList('dal');">달</a></li>
    <li id="li_byeol"><a href="#wallet_main_table" role="tab" data-toggle="tab" onclick="memberWalletList('byeol');">별</a></li>

</ul>
<div class="tab-content no-padding">
    <div class="widget widget-table" id="wallet_main_table">
        <div class="widget-content">
            <label id="walletTitle"></label>
            <span id="table_wallet_summaryArea"></span>

            <input type="hidden" name="startWalletDate" id="startWalletDate">
            <input type="hidden" name="endWalletDate" id="endWalletDate" />

            <table id="wallet_info_detail" class="table table-sorting table-hover table-bordered datatable">
                <thead id="tableTop_detail">
                </thead>
                <tbody id="tableBody_detail">
                </tbody>
            </table>
            <button class="btn btn-default btn-sm print-btn pull-right mb10" type="button" id="walletExcelDownBtn" style="display: none;"><i class="fa fa-print"></i>Excel Down</button>
            <button class="btn btn-default btn-sm print-btn pull-right mb10" type="button" id="newWalletExcelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
        </div>
    </div>


    <%--<div class="widget widget-table" id="newWallet">--%>
        <%--<div class="widget-content">--%>
            <%--<span id="table_newWallet_summaryArea"></span>--%>

            <%--<input type="hidden" name="startNewWalletDate" id="startNewWalletDate">--%>
            <%--<input type="hidden" name="endNewWalletDate" id="endNewWalletDate" />--%>

            <%--<span id="newWalletList"></span>--%>
            <%--<button class="btn btn-default btn-sm print-btn pull-right mb10" type="button" id="newWalletExcelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        <%--</div>--%>
    <%--</div>--%>
</div>
<script>
    $(document).ready(function() {
    });

    function memberWalletInit(tmp){
        $("#li_newDal").addClass("active");
        $("#li_newByeol").removeClass("active");

        $("#li_dal").removeClass("active");
        $("#li_byeol").removeClass("active");
        newWalletList('dal');
    }
    var walletList_gubun="dal";
    var walletType = 0;
    var slct_type = 0;
    var slct_typeTxt = '';
    var sDate;
    var eDate;
    function memberWalletList(tmp){
        walletType = 0;
        slct_type = 0;
        slct_typeTxt = '';
        walletList_gubun = tmp;
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
            data.walletType = walletType;
            data.slct_type = slct_type;
            data.slct_typeTxt = slct_typeTxt;
            data.sDate = sDate;
            data.eDate = eDate;
            data.walletDataType = $("#slctWalletDateType").find("select").val();

        };
        var tmp_summary;
        // try {        // 없어도 될듯?
        //     dtList_info_detail.destroy();
        // }catch (e) {}
        if(walletList_gubun == "dal" ){
            dtList_info_detail = new DalbitDataTable($("#wallet_info_detail"), dtList_info_detail_data, MemberDataTableSource.walletDalDetail);
            tmp_summary = dal_summary_table;
        }else if(walletList_gubun == "byeol"){
            dtList_info_detail = new DalbitDataTable($("#wallet_info_detail"), dtList_info_detail_data, MemberDataTableSource.walletByeolDetail);
            tmp_summary = byeol_summary_table;
        }
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable(tmp_summary);

        $("#walletExcelDownBtn").show();
        $("#newWalletExcelDownBtn").hide();

        initDataTableTop_select_wallet();
    }

    function byeol_summary_table(json){
        dalbitLog(json);
        var template = $("#byeol_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
        };
        var html = templateScript(data);
        $("#table_wallet_summaryArea").html(html);
    }

    function dal_summary_table(json){
        dalbitLog(json);
        var template = $("#dal_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
        };
        var html = templateScript(data);
        $("#table_wallet_summaryArea").html(html);
    }

    function initDataTableTop_select_wallet(){
        var topTable = "";
        var code;

        if(walletList_gubun == "dal" ){
            topTable = '<span class="mr5" name="search_wallet_top" id="search_wallet_top" onchange="wallet_sel_change()"></span>';
            topTable = topTable + '<span class="mr5" name="search_wallet_dalbyeol_top" id="search_wallet_dalbyeol_top" onchange="wallet_sel_change()"></span>';
            code = mem_wallet_dal_code;
        }else if(walletList_gubun == "byeol"){
            topTable = '<span class="mr5" name="search_wallet_top" id="search_wallet_top" onchange="wallet_sel_change()"></span>';
            topTable = topTable + '<span class="mr5" name="search_wallet_dalbyeol_top" id="search_wallet_dalbyeol_top" onchange="wallet_sel_change()"></span>';
            code = mem_wallet_byeol_code;
        }
        topTable = topTable + '<span class="mr5" name="slctWalletDateType" id="slctWalletDateType" onchange="slctWalletDateType_change();"></span>';
        topTable = topTable + '<div class="input-group date mr5" id="rangeWalletDatepicker" style="display: none">';
        topTable = topTable +   '<label for="displayWalletDate" class="input-group-addon">';
        topTable = topTable +       '<span><i class="fa fa-calendar"></i></span>';
        topTable = topTable +   '</label>';
        topTable = topTable +   '<input type="text" name="displayDate" id="displayWalletDate" class="form-control" />';
        topTable = topTable + '</div>';
        topTable = topTable + '<button type="button" class="btn btn-success mr5" id="bt_searchWallet" onclick="searchWallet_click();">검색</button>';

        $("#wallet_main_table").find(".top-left").addClass("no-padding").append(topTable);

        $("#search_wallet_top").html(util.getCommonCodeSelect(0, mem_wallet_code));
        $("#search_wallet_dalbyeol_top").html(util.getCommonCodeSelect(0, code));
        $("#slctWalletDateType").html(util.getCommonCodeSelect(-1, slctWalletDateType));
        $("#displayWalletDate").statsDaterangepicker(
            function(start, end, t1) {
                $("#startWalletDate").val(start.format('YYYY.MM.DD'));
                $("#endWalletDate").val(end.format('YYYY.MM.DD'));
            }
        );

        var dateTime = new Date();
        dateTime = moment(dateTime).format("YYYY.MM.DD");
        $("#startWalletDate").val(dateTime);
        $("#endWalletDate").val(dateTime);
    }

    function wallet_sel_change(){
        walletType = $("#search_wallet_top").find("#walletType option:selected").val();
        slct_type = $("#search_wallet_dalbyeol_top").find("#slct_type option:selected").val();
        slct_typeTxt = $("#search_wallet_dalbyeol_top").find("#slct_type option:selected").text();

        console.log(walletType);
        console.log(slct_type);

        if(walletList_gubun == "dal" ){
            dtList_info_detail.reload(dal_summary_table,true);
        }else if(walletList_gubun == "byeol"){
            dtList_info_detail.reload(byeol_summary_table,true);
        }
    }


    /*=============엑셀==================*/
    $('#walletExcelDownBtn').on('click', function(){
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);
        formData.append("mem_no", memNo);
        formData.append("walletType", walletType);
        formData.append("slct_type", slct_type);
        formData.append("slct_typeTxt", slct_typeTxt);
        formData.append("walletDataType", $("#slctWalletDateType").find("select").val());
        formData.append("sDate", sDate);
        formData.append("eDate", eDate);
        formData.append("searchStartNo", '0');
        formData.append("searchStartLimitNo", '0');

        if(walletList_gubun == "dal" ){
            util.excelDownload($(this), "/rest/member/wallet/dal/excel", formData, fn_success_excel, fn_fail_excel)
        }else if(walletList_gubun == "byeol"){
            util.excelDownload($(this), "/rest/member/wallet/byeol/excel", formData, fn_success_excel, fn_fail_excel)
        }
    });

    $('#newWalletExcelDownBtn').on('click', function(){
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);
        formData.append("mem_no", memNo);
        formData.append("walletType", walletType);
        formData.append("slct_type", slct_type);
        formData.append("slct_typeTxt", slct_typeTxt);
        formData.append("walletDataType", $("#slctWalletDateType").find("select").val());
        formData.append("sDate", sDate);
        formData.append("eDate", eDate);

        if(walletList_gubun == "dal" ){
            formData.append("slctType", 0);
            util.excelDownload($(this), "/rest/member/wallet/dal/new/excel", formData, fn_success_excel, fn_fail_excel)
        }else if(walletList_gubun == "byeol"){
            formData.append("slctType", 1);
            util.excelDownload($(this), "/rest/member/wallet/byeol/new/excel", formData, fn_success_excel, fn_fail_excel)
        }
    });

    function fn_success_excel(){
        console.log("fn_success_excel");
    }

    function fn_fail_excel(){
        console.log("fn_fail_excel");
    }
    /*==================================*/

    function slctWalletDateType_change(){
        if($("#slctWalletDateType").find("select").val() == 0){
            sDate = "";
            eDate = "";
            $("#rangeWalletDatepicker").hide();
        }else{
            $("#rangeWalletDatepicker").show();
        }
    }
    function searchWallet_click(){
        sDate = $("#startWalletDate").val();
        eDate = $("#endWalletDate").val();

        if(walletList_gubun == "dal" ){
            dtList_info_detail.reload(dal_summary_table,true);
        }else if(walletList_gubun == "byeol"){
            dtList_info_detail.reload(byeol_summary_table,true);
        }
    }



    function newWalletList(tmp){
        slct_typeTxt = '';
        walletList_gubun = tmp;
        console.log("--------------------------------------------   /   " + tmp);
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
            data.walletType = walletType;
            data.slct_type = slct_type;
            data.slct_typeTxt = slct_typeTxt;
            data.startDate = sDate;
            data.endDate = eDate;
            data.walletDataType = $("#slctWalletDateType").find("select").val();
            if(tmp == "dal" ) {
                data.slctType = 0;
            }else if(tmp == "byeol"){
                data.slctType = 1;
            }
        };
        var tmp_summary;
        // dtList_info_detail.destroy();  // 없어도 될듯?
        if(tmp == "dal" ){
            dtList_info_detail = new DalbitDataTable($("#wallet_info_detail"), dtList_info_detail_data, MemberDataTableSource.newWalletDalDetail);
            tmp_summary = dal_summary_table;
        }else if(tmp == "byeol"){
            dtList_info_detail = new DalbitDataTable($("#wallet_info_detail"), dtList_info_detail_data, MemberDataTableSource.newWalletByeolDetail);
            tmp_summary = byeol_summary_table;
        }
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable(tmp_summary);

        $("#newWalletExcelDownBtn").show();
        $("#walletExcelDownBtn").hide();
        initDataTableTop_select_wallet()
    }

</script>


<script id="dal_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right" style="margin-right: 0px;">
        <tr>
            <th colspan="7">달</th>
        </tr>
        <tr>
            <th>충전</th>
            <th>받은 선물</th>
            <th>이벤트/리워드 지급</th>
            <th>보낸 선물</th>
            <th>달 교환</th>
            <th>가입 보상</th>
            <th>보유 달</th>
        </tr>
        <td style="padding:8px; color:blue;">{{addComma content.sum_charge_cnt}} 달</td>
        <td style="padding:8px; color:blue;">{{addComma content.sum_input_cnt}} 달</td>
        <td style="padding:8px; color:blue;">{{addComma content.sum_event_cnt}} 달</td>
        <td style="padding:8px; color:red;">{{addComma content.sum_output_cnt}} 달</td>
        <td style="padding:8px; color:blue;">{{addComma content.sum_change_cnt}} 달</td>
        <td style="padding:8px; color:blue;">{{addComma content.start_cnt}} 달</td>
        <td style="padding:8px;">{{addComma content.sum_own_cnt}} 달</td>
    </table>
</script>

<script id="byeol_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right" style="margin-right: 0px;">
        <tr>
            <th colspan="6">별</th>
        </tr>
        <tr>
            <th>받은 선물</th>
            <th>이벤트/리워드 지급</th>
            <th>환전</th>
            <th>달 교환</th>
            <th>가입 보상</th>
            <th>보유 별</th>
        </tr>
        <td style="padding:8px; color:blue;">{{addComma content.sum_input_cnt}} 별</td>
        <td style="padding:8px; color:blue;">{{addComma content.sum_event_cnt}} 별</td>
        <td style="padding:8px; color:red;">{{addComma content.sum_exchange_cnt}} 별</td>
        <td style="padding:8px; color:blue;">{{addComma content.sum_change_cnt}} 별</td>
        <td style="padding:8px; color:blue;">{{addComma content.start_cnt}} 별</td>
        <td style="padding:8px;">{{addComma content.sum_own_cnt}} 별</td>
    </table>
</script>
