<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//    Object in_memNo = request.getParameter("memNo");
%>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="widget-content mt15">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="tablist_con">
                <li class="active"><a href="#gift" role="tab" data-toggle="tab" id="tab_gift" onclick="giftList(1);">일반</a></li>
                <li><a href="#emotion" role="tab" data-toggle="tab" id="tab_emotion" onclick="giftList(3);">콤보</a></li>
                <li><a href="#combo" role="tab" data-toggle="tab" id="tab_combo" onclick="giftList(2);">감정</a></li>
                <li><a href="#text" role="tab" data-toggle="tab" id="tab_text" onclick="giftList(4);">문자</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="gift">
                    <table class="table table-bordered _tableHeight" data-height="23px">
                        <colgroup>
                            <col width="10%"/><col width="30%"/><col width="30%"/><col width="30%"/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>NO</th>
                            <th>이미지</th>
                            <th>아이템명</th>
                            <th>순서</th>
                        </tr>
                        </thead>
                        <tbody id="giftBody">
                        </tbody>
                    </table>
                    <div class="" style="text-align: center" >
                        <button class="btn btn-primary" type="button" onclick="setGiftOrder();">적용하기</button>
                        <button class="btn btn-default" type="button" onclick="javascript:window.close();">창닫기</button>
                    </div>
                </div>
                <%--<div class="tab-pane fade" id="combo">--%>
                <%--</div>--%>
                <%--<div class="tab-pane fade" id="emotion">--%>
                <%--</div>--%>
            </div>
        </div>
    </div>
    <%--<button class="btn btn-default" type="button" onclick="javascript:window.close();">창닫기</button>--%>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<script>
    <%--var memNo = "<%=in_memNo%>";--%>

    $(document).ready(function(){
        init();
    });

    var listType = 1;
    function init(){
        var data = {
          itemType :   listType
        };
        util.getAjaxData("itemList", "/rest/content/item/gift/order/list", data, fn_giftList_success);
    }
    function fn_giftList_success(dst_id,response){
        $("#giftBody").empty();
        var template = $('#tmp_giftList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data;
        var html=templateScript(detailContext);
        $("#giftBody").append(html);
    }

    function setGiftOrder(){
        if (!confirm('적용하시겠습니까?')) {
            return false;
        }

        var sendData = new Array();
        var i=0;
        var data;
        $("#gift").find("._noTr").each(function(){
            data = {
                'item_code': $(this).find("._noTd").data("itemcode")
                ,'itemOrder' : ++i
            };
            sendData.push(data);
        });

        var editData = {
            'editData' : sendData,
            'itemType' :  listType
        }

        console.log(editData);
        util.getAjaxData("setGiftOrder", "/rest/content/item/set/giftList", editData, fn_set_giftList_success);
    }

    function fn_set_giftList_success(dst_id,response){
        alert("수정되었습니다.");
        init();
    }

    function giftList(type){
        listType = type;
        init();
    }

    $(document).on('click', '._down', function () {
        var targetTr = $(this).closest('tr');
        var nextTr = targetTr.next();
        targetTr.insertAfter(nextTr);
        resetNo();
        btnSet();
    });

    $(document).on('click', '._up', function () {
        var targetTr = $(this).closest('tr');
        var prevTr = targetTr.prev();
        targetTr.insertBefore(prevTr);
        resetNo();
        btnSet();
    });

    function btnSet() {
        $("#gift").find('.btn._down').prop('disabled', false);
        $("#gift").find('.btn._down:last').prop('disabled', true);

        $("#gift").find('.btn._up').prop('disabled', false);
        $("#gift").find('.btn._up:first').prop('disabled', true);
    };

    function resetNo() {
        $("#gift").find('._noTd').each(function (index) {
            var html = '<input type="hidden" name="sortNo" value="'+(index+1)+'">';
            html += (index+1);
            $(this).html(html);
        });

        $("#gift").find('._noTr').each(function (index) {
            $(this).attr("id", "row_" + (index + 1));
        });
    };

</script>

<script type="text/x-handlebars-template" id="tmp_giftList">
    {{#each this as |data|}}
    <tr class="_noTr">
        <td class="_noTd" data-itemcode="{{item_code}}">{{rowNum}}</td>
        <td><img class="_webpImage" src="{{data.item_thumbnail}}" width="50" height="50" data-webpImage="{{data.webp_image}}"/></td>
        <td>{{item_name}}</td>
        <td>
            <button type="button" class="btn btn-info _down"><i class="toggle-icon fa fa-angle-down"></i></button>
            <button type="button" class="btn btn-danger _up"><i class="toggle-icon fa fa-angle-up"></i></button>
        </td>
    </tr>
    {{/each}}
</script>

