<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 클립관리 > 클립내역관리 > 클립청취 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate" style="display: none;"></span>
        <span class="pull-left">
            <div class="pull-left" style="width:30px; height:30px; background-color: #dae3f3; border:1px solid #cccccc;"></div>
            <div class="pull-left pl10 pt5" style="width:105px; height:30px; border:1px solid #cccccc; border-left-width: 0px;">테스트 아이디</div>
            <span id="select_clipOrderByType" name="select_clipOrderByType" class="pull-left ml5"></span>
        </span>
        <span class="pull-right">
            <p name="headerInfo" style="padding:5px; border:1px solid #cccccc; background-color: #ffe699; height: 30px; margin-bottom: 2px; display: table;"></p>
        </span>
        <table id="clip_history_listen_list_info" class="table table-sorting table-hover table-bordered">
            <thead>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>


<script type="text/javascript">
    $(function(){

    });

    function getClipDetailListen(){
        $("#select_clipOrderByType").html(util.getCommonCodeSelect(common.isEmpty(orderByType) ? 0 : orderByType, clip_orderByType_listen_clipDetail));

        initDataTable_clipHistoryListen();
    }

    $(document).on('change', "#clipOrderByType", function(){
        dtList_info.reload(selectCallback_clipHistotyListen, false);
    });

    var dtList_info;
    function initDataTable_clipHistoryListen() {
        //=---------- Main DataTable ----------
        var dtList_info_data = function (data) {
            data.targetClipNo = clipNo;
            data.orderByType = Number($("#clipOrderByType").val());
        };

        dtList_info = new DalbitDataTable($("#clip_history_listen_list_info"), dtList_info_data, ClipDetailDataTableSource.listenList, $("#searchForm"));
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(50);
        dtList_info.createDataTable(selectCallback_clipHistotyListen);

        //---------- Main DataTable ----------=
    };

    function selectCallback_clipHistotyListen(data){
        // 탭 우측 총 건수 추가
        var text = "<span style='color: black;'>클립 청취 수 :</span>" +
            "<span style='color: darkblue; font-weight: bold; '> " +  common.addComma(data.pagingVo.totalCnt) + " 건</span>" +
            "<span>&nbsp;&nbsp;|&nbsp;&nbsp;</span>" +
            "<span style='color: blue; font-weight: bold; '>남성 : " +  common.addComma(data.summary.manTotalCnt) + " 건, </span>" +
            "<span style='color: red; font-weight: bold; '>여성 : " +  common.addComma(data.summary.femaleTotalCnt) + " 건, </span>" +
            "<span style='color: black; font-weight: bold; '>알수없음 : " +  common.addComma(data.summary.unknownTotalCnt) + " 건</span>";

        $("p[name=headerInfo]").html(text);
        $("p[name=headerInfo]").show();
    }

</script>


<script id="tmp_codeDefine" type="text/x-handlebars-template">
    <select name="slctType" id="slctType" class="form-control">
        {{#each this as |sub|}}
        <option value="{{sub.value}}">{{sub.code}}</option>
        {{/each}}
    </select>
</script>