<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
</style>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="widget-content">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                <li class="active"><a href="#dalForm" role="tab" data-toggle="tab" id="tab_dalForm">달 양식</a></li>
                <li><a href="#dalCount" role="tab" data-toggle="tab" id="tab_dalCount">달 수</a></li>
                <li><a href="#dalAmt" role="tab" data-toggle="tab" id="tab_dalAmt">달 수 - 회원내역</a></li>
                <li><a href="#byeolCount" role="tab" data-toggle="tab" id="tab_byeolCount">별 수</a></li>
                <li><a href="#byeolAmt" role="tab" data-toggle="tab" id="tab_byeolAmt">별 수 - 회원내역</a></li>
                <li><a href="#dalbitSales" role="tab" data-toggle="tab" id="tab_dalbitSales">달 매출</a></li>
                <li><a href="#withdrawalDal" role="tab" data-toggle="tab" id="tab_withdrawalDal">탈퇴 달</a></li>
                <li><a href="#withdrawalByeol" role="tab" data-toggle="tab" id="tab_withdrawalByeol">탈퇴 별</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="dalForm"><jsp:include page="dalForm.jsp"/></div>
                <div class="tab-pane fade" id="dalCount" style="width: 3000px;"><jsp:include page="dalCount.jsp"/></div>
                <div class="tab-pane fade" id="dalAmt" style="width: 2500px;"><jsp:include page="dalAmt.jsp"/></div>
                <div class="tab-pane fade" id="byeolCount"><jsp:include page="byeolCount.jsp"/></div>
                <div class="tab-pane fade" id="byeolAmt"><jsp:include page="byeolAmt.jsp"/></div>
                <div class="tab-pane fade" id="dalbitSales"><jsp:include page="dalbitSales.jsp"/></div>
                <div class="tab-pane fade" id="withdrawalDal" style="width: 800px;"><jsp:include page="withdrawalDal.jsp"/></div>
                <div class="tab-pane fade" id="withdrawalByeol" style="width: 600px;"><jsp:include page="withdrawalByeol.jsp"/></div>
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<script type="text/javascript" src="/js/code/enter/joinCodeList.js?${dummyData}"></script>

<script type="text/javascript">
    var tabId = "tab_dalForm";

    $("#slctTypeArea").append(util.getCommonCodeRadio(1, revenueProcess_slctType2));

    $("#tablist_con li a").on('click', function(){
        slctType = 1;
        tabId = $(this).prop('id');

        $("#slctTypeArea").empty();
        if(tabId == 'tab_dalbitSales' || tabId == 'tab_dalAmt' || tabId == 'tab_byeolAmt'
            || tabId == 'tab_withdrawalDal' || tabId == 'tab_withdrawalByeol'){
            slctType = 0;
            if(tabId == 'tab_dalbitSales'){
                $("#slctTypeArea").append(util.getCommonCodeRadio(0, revenueProcess_slctType));
            }
        }else{
            slctType = 1;
            $("#slctTypeArea").append(util.getCommonCodeRadio(1, revenueProcess_slctType2));
        }

        dateType(slctType);
    });

    $("#bt_search").on('click', function(){
        if(tabId == 'tab_dalForm'){
            getDalFormList();
        }else if(tabId =='tab_dalCount'){
            getDalCountList();
        }else if(tabId =='tab_byeolCount'){
            getByeolCountList();
        }else if(tabId =='tab_dalbitSales'){
            getDalbitSalesList();
        }else if(tabId =='tab_dalAmt'){
            getDalAmtList();
        }else if(tabId =='tab_byeolAmt'){
            getByeolAmtList();
        }else if(tabId =='tab_withdrawalDal'){
            getWithdrawalDalList();
        }else if(tabId =='tab_withdrawalByeol'){
            getWithdrawalByeolList();
        }
    });
</script>