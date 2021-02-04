<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper">
    <div id="page-wrapper">
        <!-- serachBox -->
        <div class="col-md-12 no-padding">
            <table class="table table-bordered">
                <colgroup>
                    <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/>
                    <col width="10%"/><col width="10%"/><col width="10%"/>
                </colgroup>
                <thead>
                <tr>
                    <th>No</th>
                    <th>상품코드</th>
                    <th>아이템 타입</th>
                    <th>사용기간</th>
                    <th>AOS 가격(달)</th>
                    <th>IOS 가격(달)</th>
                    <%--<th>PC 가격(달)</th>--%>
                    <th>일간 클릭수(평균)</th>
                </tr>
                </thead>
                <tbody id="quick_body"></tbody>
            </table>
        </div>
    </div> <!-- //page-wrapper -->
</div> <!-- //wrapper -->

<script type="text/javascript">

    $(document).ready(function() {
        // quickList();
    });

    function fnc_quick() {
        util.getAjaxData("select", "/rest/content/item/quick", null, fn_succ_list);
    }

    function fn_succ_list(data,response,param){
        $("#quick_body").empty();

        var template = $('#tmp_quickBody').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html=templateScript(context);
        $("#quick_body").append(html);

    }

</script>

<script type="text/x-handlebars-template" id="tmp_quickBody">
    <tr>
        <td>1</td>
        <td>-</td>
        <td>퀵 메시지(기본)</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <%--<td>-</td>--%>
        <td></td>
    </tr>
    <tr>
        <td>2</td>
        <td>-</td>
        <td>퀵 메시지(기본)</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <%--<td>-</td>--%>
        <td></td>
    </tr>
    <tr>
        <td>3</td>
        <td>-</td>
        <td>퀵 메시지(기본)</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <%--<td>-</td>--%>
        <td></td>
    </tr>
    {{#each this as |data|}}
    <tr>
        <td>{{rowNum}}</td>
        <td>{{item_code}}</td>
        <td>{{item_name}}</td>
        <td>{{use_day}}일</td>
        <td>{{item_price}}</td>
        <td>{{item_price}}</td>
        <%--<td>{{pcPrice}}</td>--%>
        <td>0</td>
    </tr>
    {{/each}}
</script>