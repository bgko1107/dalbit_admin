<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12 no-padding">
    <div class="widget widget-table" id="main_table">
        <div class="widget-content">
            <div class="col-md-2 no-padding mt10" >
                <span id="searchQuestNo" onchange="questMember();"></span>
            </div>
            <div class="col-md-2 no-padding mt10 pull-right" >
                <span id="questMemberSummary"></span>
            </div>
            <table id="quest_member_list" class="table table-sorting table-hover table-bordered datatable">
                <thead>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        $("#searchQuestNo").html(util.getCommonCodeSelect(0, questName));
    });

    var dtList_questMember;
    function questMember () {     // 상세보기

        var dtList_questMember_detail_data = function (data) {
            data.questDate = $("#startDate").val().substr(0,7).replace(".","-");
            data.questNo = $("#searchQuestNo").find("#questName").val();
            data.searchText = $("#searchText").val();
            data.newSearchType = $("#searchMember").val();
        };
        dtList_questMember = new DalbitDataTable($("#quest_member_list"), dtList_questMember_detail_data, questDataTableSource.questMember);
        dtList_questMember.useCheckBox(false);
        dtList_questMember.useIndex(true);
        dtList_questMember.setPageLength(50);
        dtList_questMember.createDataTable(questMemberSummary);
    }

    function questMemberSummary(response){

        var template = $('#tmp_questMemberSummary').html();
        var templateScript = Handlebars.compile(template);
        var data = response.summary;
        var html = templateScript(data);
        $("#questMemberSummary").html(html);

    }
</script>

<script id="tmp_questMemberSummary" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered no-margin">
        <colgroup>
            <col width="50%"/><col width="50%"/>
        </colgroup>
        <tr>
            <th>달</th>
            <th>경험치</th>
        </tr>
        <tr>
            <td>{{addComma totalDal}}</td>
            <td>{{addComma totalExp}}</td>
        </tr>
    </table>
</script>