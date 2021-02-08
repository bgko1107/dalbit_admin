<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 클립관리 > 클립내역관리 > 클립삭제 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate" style="display: none;"></span>
        <span class="pull-right">
            <div class="pull-left" style="width:30px; height:30px; background-color: #dae3f3; border:1px solid #cccccc;"></div>
            <div class="pull-left pl10 pt5" style="width:105px; height:30px; border:1px solid #cccccc; border-left-width: 0px;">테스트 아이디</div>
        </span>
        <table id="clip_history_remove_list_info" class="table table-sorting table-hover table-bordered">
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

    function getHistoryRemove(){
        getClipSubjectTypeCodeDefine();

        initDataTable_clipHistoryRemove();
    }

    var dtList_info;
    function initDataTable_clipHistoryRemove() {
        //=---------- Main DataTable ----------
        var dtList_info_data = function (data) {
            data.newSearchType = $("#searchClip").val();
        };

        dtList_info = new DalbitDataTable($("#clip_history_remove_list_info"), dtList_info_data, ClipHistoryDataTableSource.removeList, $("#searchForm"));
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(50);
        dtList_info.createDataTable(selectCallback_clipHistotyRemove);

        //---------- Main DataTable ----------=
    };

    function selectCallback_clipHistotyRemove(data){
        // 탭 우측 총 건수 추가
        var template = $("#tmp_headerInfo_clipHistoryRemove").html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html = templateScript(context);

        $("#headerInfo").html(html);
        $("#headerInfo").show();
        ui.paintColor();
    }

</script>


<script id="tmp_codeDefine" type="text/x-handlebars-template">
    <select name="slctType" id="slctType" class="form-control">
        {{#each this as |sub|}}
        <option value="{{sub.value}}">{{sub.code}}</option>
        {{/each}}
    </select>
</script>

<script type="text/x-handlebars-template" id="tmp_headerInfo_clipHistoryRemove">
    <table class="table table-bordered _tableHeight" data-height="23px">
        <colgroup>
            <col width="33%"/><col width="33%"/><col width="33%"/>
        </colgroup>
        <thead>
        <tr>
            <th colspan="3" class="_bgColor _fontColor" data-bgcolor="black" data-fontcolor="white">총 삭제 수 : {{addComma pagingVo.totalCnt 'N'}} 건</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#dae3f3">남성</th>
            <th class="_bgColor" data-bgcolor="#fbe5d6">여성</th>
            <th class="_bgColor" data-bgcolor="#FFF2CC">알수없음</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td >{{addComma summary.manTotalCnt 'N'}} 건</td>
            <td >{{addComma summary.femaleTotalCnt 'N'}} 건</td>
            <td >{{addComma summary.unknownTotalCnt 'N'}} 건</td>
        </tr>
        </tbody>
    </table>
</script>