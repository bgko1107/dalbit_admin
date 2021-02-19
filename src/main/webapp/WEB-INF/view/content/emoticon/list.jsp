<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%
    String in_tabType = request.getParameter("tabtype");
%>

<div id="wrapper">
    <div id="page-wrapper">
        <!-- serachBox -->
        <div class="row col-lg-12 form-inline">
            <div class="widget widget-table searchBoxArea">
                <table>
                    <tr>
                        <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                            <i class="fa fa-search"></i><br/>검색
                        </th>
                    </tr>
                    <tr>
                        <td style="text-align: left">
                            <span class="select_category" id="select_category" onchange="btSearchClick();"></span>
                            <span id="searchIsUse"  onchange="btSearchClick();"></span>
                            <%--<span id="searchType"></span>--%>
                            <label><input type="text" class="form-control" id="txt_search"></label>
                            <button type="submit" class="btn btn-success" id="bt_search">검색</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <!-- //serachBox -->
        <!-- DATA TABLE -->
        <div class="row col-lg-12 form-inline">
            <ul class="nav nav-tabs nav-tabs-custom-colored mt5">
                <li><a href="#inssaticonList" role="tab" data-toggle="tab" id="tab_inssaticonList" onclick="inssaticonList(1);">이모티콘관리</a></li>
            </ul>
        </div>
        <div class="row col-lg-12 form-inline">
            <div class="widget widget-table" id="div_inssaticonList">
                <div class="tab-content no-padding">
                    <div class="tab-pane fade in active " id="inssaticonList">       <!-- 이모티콘 -->
                        <div class="col-md-12 pt10 pb10">
                            <div class="pull-left">
                                ㆍ 이모티콘은 최대 20byte까지 가능합니다. 등록 전, 채팅에서 테스트 꼭 부탁드립니다!<br>
                                ㆍ '순위조정'은 검색조건에서 카테고리만 선택하여 조회하는 경우에만 수정이 가능합니다.
                            </div>
                            <br/>
                            <br/>
                            <br/>
                            <div class="pull-left">
                                <span class="select_category" id="add_select_category"></span>
                                <label><input type="text" class="form-control" id="txt_inssaticon_add"></label>
                                <button type="button" class="btn btn-default btn-sm mr-10" id="btn_add" onclick="addInssaticon()"><i class="fa fa-plus-square"></i>등록</button>
                            </div>
                            <div class="pull-right">
                                <button type="button" class="btn btn-default btn-sm mr-10 _openCategoryListPop" id="btn_edit_category"><i class="fa fa-edit"></i>카테고리 관리</button>
                                <button type="button" class="btn btn-primary btn-sm" name="btn_order_save" onclick="orderEdit()"><i class="fa fa-floppy-o"></i>저장</button>
                            </div>
                        </div>
                        <div class="widget-content">
                            <table id="tb_inssaticonList" class="table table-sorting table-hover table-bordered no-margin">
                                <colgroup>
                                    <col width="40px"/>
                                    <col width="50px" /> <!-- No -->
                                    <col width="80px" /> <!-- 카테고리 -->
                                    <col width="200px" /> <!-- 이모티콘 내용 -->
                                    <col width="120px" /> <!-- 등록일 -->
                                    <col width="60px" /> <!-- 클릭 수 -->
                                    <col width="60px" /> <!-- 일간 클릭 수 -->
                                    <col width="60px" /> <!-- 노출여부 -->
                                    <col width="70px" /> <!-- 순위조정 -->
                                </colgroup>
                                <thead>
                                <th></th>
                                <th>No</th>
                                <th>카테고리</th>
                                <th>이모티콘 내용</th>
                                <th>등록일</th>
                                <th>클릭 수</th>
                                <th>일간 클릭 수</th>
                                <th>노출여부</th>
                                <th>순위조정</th>
                                </thead>
                                <tbody id="tableBody"></tbody>
                            </table>
                            <div class="col-md-12 pt10 pb10 pr0 pl0">
                                <div class="pull-left">
                                    <button type="button" class="btn btn-danger btn-sm mr-10" id="btn_delete" onclick="removeInssaticon()"><i class="fa fa-trash-o"></i>선택 삭제</button>
                                    <button type="button" class="btn btn-primary btn-sm" id="btn_update" onclick="editInssaticon()"><i class="fa fa-pencil"></i>선택수정</button>
                                </div>
                                <div class="pull-right">
                                    <button type="button" class="btn btn-primary btn-sm" name="btn_order_save" onclick="orderEdit()"><i class="fa fa-floppy-o"></i>저장</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script>
    var tabType = common.isEmpty(<%=in_tabType%>) ? 1 : <%=in_tabType%>;
    var allList = "";

    $(document).ready(function() {

        $('input[id="txt_search"]').keydown(function() {
            if (event.keyCode === 13) {
                getInssaticonInfo();
            };
        });
        <!-- 버튼 -->
        $('#bt_search').click( function() {       //검색
            getInssaticonInfo();
        });

        <!-- 버튼 끝 -->

        $("#searchIsUse").html(util.getCommonCodeSelect(-1, inssaticon_isUse));
        $(".select_category").html(util.getCommonCodeSelect(-1, inssaticon_category));

        setCategorySelectBox();

    });

    // list tab 선택 타입
    function inssaticonList(type){
        tabType = type;
    }

    function setCategorySelectBox(){
        util.getAjaxData("list", "/rest/content/emoticon/inssaticon/category/list", "", fn_success_set_category, fn_fail);
    }

    function fn_success_set_category(dst_id, response){

        var beforeSlct = $("select[name='category']").val();

        var template = $('#tmp_category_selectOption_Frm').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html=templateScript(context);
        $("select[name='category']").html(html);

        $("select[name='category']").val(beforeSlct);

        getInssaticonInfo();
    }

    function getInssaticonInfo() {                 // 검색
        if(tabType == "1"){       // 인싸티콘
            $("#tab_inssaticonList").click();

            var data = {
                'categoryNo' : $("#select_category").find("#category").val()
                ,'viewOn' : $("#isUse").val()
                ,'searchText' : $("#txt_search").val()
            }

            console.log(data);
            util.getAjaxData("editor", "/rest/content/emoticon/inssaticon/list", data, inssaticon_list_select_success, fn_fail);
        }
    }

    function inssaticon_list_select_success(dst_id, response){

        var template = $('#tmp_inssaticonList_view_Frm').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html=templateScript(context);
        $("#tableBody").html(html);

        btnSet();

        allList = response.summary;
        console.log(allList);
        $("#div_inssaticonList").find("#add_select_category").find("#category").val($("#select_category").find("#category").val());
        $("#txt_inssaticon_add").val("");
    }


    function ajax_success_reload(dst_id, response) {
        if(!common.isEmpty(response.message)){
            alert(response.message);
        }

        getInssaticonInfo();
        btnSet();
    }

    function fn_fail(data, textStatus, jqXHR){
        console.log(data, textStatus, jqXHR);
    }

    // 저장 버튼
    function orderEdit(memNo) {
        if(confirm("현재 상태로 저장 하시겠습니까?")) {
            var isDescNull = false;
            var sendData = new Array;

            var categorySlct = $("#select_category").find("#category").val();
            var viewOn = $("#searchIsUse").find("#isUse").val();

            if(categorySlct == -1 && viewOn == -1){       // 전체 조회
                $("#div_inssaticonList").find("._noTr").each(function(){
                    if(common.isEmpty($(this).find("._cdNm").val())){
                        isDescNull = true;
                        return false;
                    }

                    var data = {
                        'idx': $(this).find("._check").data("idx")
                        ,'emoticon_orderNo': $(this).find("._noTd").text()
                        ,'emoticon_desc': $(this).find("._cdNm").val()
                        ,'viewOn': $(this).find("input[name='isUse']").prop('checked') ? 1 : 0
                    }
                    sendData.push(JSON.stringify(data));
                });
            }else{      // 검색 조건 조회
                var orderIdx = 1;

                // 전체 리스트에서 해당 이모티콘 목록 제거
                allList = allList.filter(function(value, idx, arr){
                    return !(categorySlct == -1 || value.categoryNo == categorySlct) || !(viewOn == -1 || value.viewOn == viewOn)
                });


                $("#div_inssaticonList").find("._noTr").each(function(){
                    var target = $(this);

                    // 이모티콘 내용이 비어있는 경우 체크
                    if(common.isEmpty($(this).find("._cdNm").val())){
                        isDescNull = true;
                        return false;
                    }

                    var data = {
                        'idx': $(this).find("._check").data("idx")
                        ,'emoticon_orderNo': orderIdx
                        ,'emoticon_desc': $(this).find("._cdNm").val()
                        ,'viewOn': $(this).find("input[name='isUse']").prop('checked') ? 1 : 0
                    }

                    orderIdx++;
                    sendData.push(JSON.stringify(data));
                });

                for(var i=0;  i < allList.length; i++){
                    var target = allList[i];

                    var data = {
                        'idx': target.idx
                        ,'emoticon_orderNo': orderIdx
                        ,'emoticon_desc': common.replaceHtml_json(target.emoticon_desc)
                        ,'viewOn': target.viewOn
                    }

                    orderIdx++;
                    sendData.push(JSON.stringify(data));
                }
            }

            if(isDescNull){
                alert("이모티콘 내용을 확인해주세요.");
                return false;
            }

            var editData = {
                'editData' : sendData.join("|")
            }
            console.log(editData)
            util.getAjaxData("editor", "/rest/content/emoticon/inssaticon/update", editData, ajax_success_reload, fn_fail);
        }return false;
    }

    //등록 버튼
    function addInssaticon(){
        var categorySlct = $("#div_inssaticonList").find("#add_select_category").find("#category").val();
        if(categorySlct == -1){
            alert("카테고리를 선택해주세요.");
            return false;
        }

        if(common.isEmpty($("#txt_inssaticon_add").val())){
            alert("이모티콘을 입력해주세요.");
            return false;
        }

        if (confirm('등록하시겠습니까?')) {
            var data = {
                'categoryNm': $("#div_inssaticonList").find("#add_select_category").find("#category option:selected").text()
                ,'emoticon_desc': $("#txt_inssaticon_add").val()
            }

            console.log(data);
            util.getAjaxData("add", "/rest/content/emoticon/inssaticon/insert", data, ajax_success_reload, fn_fail);
        }
    }

    // 삭제 버튼
    function removeInssaticon() {
        var checked = $("#div_inssaticonList").find('#tableBody').find('._check:checked');

        if (0 == checked.length) {
            alert("삭제할 이모티콘을 선택해주세요.");
            return;
        }
        if (confirm('삭제하시겠습니까?')) {
            var checked = $("#div_inssaticonList").find('#tableBody').find('._check:checked');
            checked.closest('tr').remove();
            resetNo();
            btnSet();
        }
    }

    // 수정 버튼
    function editInssaticon() {
        var checked = $("#div_inssaticonList").find('#tableBody').find('._check:checked');
        if (0 == checked.length) {
            alert("수정할 이모티콘을 선택해주세요.");
            return;
        }

        checked.each(function () {
            $(this).closest('tr').find('._cdNm').prop('readonly', false);
        });

        $("#div_inssaticonList").find('#tableBody').find('._check:checked:eq(0)').closest('tr').find('._cdNm').focus();
    }


    function resetNo() {
        $("#tb_inssaticonList").find('._noTd').each(function (index) {
            var html = '<input type="hidden" name="sortNo" value="'+(index+1)+'">';
            html += (index+1);
            $(this).html(html);
        });
    };

    function btnSet() {
        if($("#select_category").find("#category").val() == -1 || $("#searchIsUse").find("#isUse").val() != -1){
            $("#tb_inssaticonList").find('.btn._down').prop('disabled', true);
            $("#tb_inssaticonList").find('.btn._up').prop('disabled', true);
        }else{
            $("#tb_inssaticonList").find('.btn._down').prop('disabled', false);
            $("#tb_inssaticonList").find('.btn._down:last').prop('disabled', true);

            $("#tb_inssaticonList").find('.btn._up').prop('disabled', false);
            $("#tb_inssaticonList").find('.btn._up:first').prop('disabled', true);
        }
    };

    function moveUp(el){
        var $tr = $(el).parent().parent(); // 클릭한 버튼이 속한 tr 요소
        $tr.prev().before($tr); // 현재 tr 의 이전 tr 앞에 선택한 tr 넣기
        resetNo();
        btnSet();
    }

    function moveDown(el){
        var $tr = $(el).parent().parent(); // 클릭한 버튼이 속한 tr 요소
        $tr.next().after($tr); // 현재 tr 의 다음 tr 뒤에 선택한 tr 넣기
        resetNo();
        btnSet();
    }

    function btSearchClick(){
        $("#bt_search").click();
    }

</script>


<script id="tmp_inssaticonList_view_Frm" type="text/x-handlebars-template">
    {{#each this as |data|}}
    <tr class="_noTr" id="row_{{emoticon_orderNo}}" >
        <td><input type="checkbox" class="_check" data-idx="{{idx}}"/></td>
        <td>{{index @index}}</td>
        <td class="_noTd" style="display:none;">{{emoticon_orderNo}}</td>
        <td>{{categoryNm}}</td>
        <td>
            <input type="input" class="form-control _cdNm" style="width: 100%;" value="{{replaceHtml_json emoticon_desc}}" readonly=true>
        </td>
        <td>{{regDate}}</td>
        <td>{{total_clickCnt}}</td>
        <td>{{daily_clickCnt}}</td>
        <td>
            <div class="control-inline onoffswitch">
                <input type="checkbox" name="isUse" class="onoffswitch-checkbox" id="inssaticonList_isUse{{emoticon_orderNo}}" {{#dalbit_if viewOn "==" "1"}}checked{{/dalbit_if}}>
                <label class="onoffswitch-label" for="inssaticonList_isUse{{emoticon_orderNo}}">
                    <span class="onoffswitch-inner"></span>
                    <span class="onoffswitch-switch"></span>
                </label>
            </div>
        </td>
        <td>
            <button type="button" class="btn btn-info btn-sm _down" onclick="moveDown(this)"><i class="toggle-icon fa fa-angle-down"></i></button>
            <button type="button" class="btn btn-danger btn-sm _up" onclick="moveUp(this)"><i class="toggle-icon fa fa-angle-up"></i></button>
        </td>
    </tr>
    {{else}}
    <tr>
        <td colspan="9">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>


<script id="tmp_category_selectOption_Frm" type="text/x-handlebars-template">
    <option value="-1">카테고리(전체)</option>
    {{#each this as |summary|}}
        <option value="{{idx}}">{{categoryNm}}</option>
    {{/each}}
</script>