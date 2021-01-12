
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="main-header">
    <div id="page-wrapper">
        <div id="headerTab">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                <li class="active _tab" data-slcttype="0"><a href="javascript://">사이트 금지어 관리</a></li>
                <li class="_tab" data-slcttype="1"><a href="javascript://">방송방 금지어 관리</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active in" id="sitebanList">
                    <div>
                        <div class="row col-md-12" style="padding-bottom: 15px">
                            <div class="pull-left">
                                - 사이트 내 닉네임 , 채팅글 , 팬보드 , 방송 제목 또는 방송 환영글 등에서 사용을 금지하는 사이트 금지어 관리 페이지입니다.
                                <br/>
                                - 금지어 등록 시 2글자 이상 등록이 가능합니다.
                                <br/>
                                - 사이트 금지어 검색은 키보드 Ctrl+F를 통해 결과 확인이 가능합니다.
                            </div>
                            <div class="pull-right">
                                <%--<button type="button" class="btn btn-default mr-10" id="addBtn"><i class="fa fa-plus-square"></i>등록</button>--%>
                                <%--<button type="button" class="btn btn-primary "><i class="fa fa-floppy-o"></i>적용</button>--%>
                            </div>
                        </div>

                        <div class="widget-content">
                            <form id="form">
                                <div class="form-group row">
                                    <div class="col-md-12">
                                        <div class="col-xs-4 no-padding">
                                            <input class="form-control" id="banword" type="text" placeholder="등록할 금지어를 입력해주세요." />
                                        </div>
                                        <button type="button" id="regBtn" class="btn-success btn pull-left">등록</button>

                                        <button type="button" class="btn btn-default pull-right" id="deleteBtn2"><i class="fa fa-trash-o"></i>선택삭제</button>
                                    </div>
                                </div>
                                <input type="text" name="dummy" style="display:none;" />
                            </form>
                            <table id="list" class="table table-sorting table-hover-ban table-bordered datatable ui-pg-table">
                                <%--<colgroup>
                                    <col width="70px" />
                                    <col width="120px"/>
                                    <col/>
                                </colgroup>--%>
                                <thead>
                                <tr>
                                    <th colspan="7">금지어</th>
                                </tr>
                                </thead>
                                <tbody id="tableBody"></tbody>
                            </table>

                            <div class="btn-toolbar">
                                <div class="btn-group" role="group">
                                    <button type="button" class="btn btn-default" id="deleteBtn"><i class="fa fa-trash-o"></i>선택삭제</button>
                                </div>

                                <%--<div class="btn-group pull-right" role="group">
                                    <button type="button" class="btn btn-default mr-10" id="addBtn"><i class="fa fa-plus-square"></i>등록</button>
                                    <button type="button" class="btn btn-primary" id="insertBtn"><i class="fa fa-floppy-o"></i>적용</button>
                                </div>--%>
                                <span>
                                    <button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>     <!-- 사이트 금지어 관리 -->
            </div>
        </div>
    </div>
</div>

<input type="hidden" name="idx" id="idx" />

<script type="text/javascript" src="/js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/contentHelper.js?${dummyData}"></script>
<script type="text/javascript">
    var slctType = 0;
    $(document).ready(function() {
        init();
    });

    //=------------------------------ Init / Event--------------------------------------------

    $("._tab").on('click', function(){
       $('._tab').removeClass('active');
       $(this).addClass('active');

       slctType = $(this).data('slcttype');
       init();
    });

    function init() {
        var data = {
            slctType : slctType
        }
        util.getAjaxData('siteban', '/rest/content/siteban/list', data, fn_succ_list);
    }

    function fn_succ_list(dst_id, response){
        if(dst_id == 'insert'){
            ui.topScroll();
            alert('등록되었습니다.');
        }else if(dst_id == 'delete'){
            ui.topScroll();
            alert('삭제되었습니다.');
        }

        $("#idx").val(response.data.idx);
        var banword = response.data.ban_word.split('|');

        var wordList = new Array();
        banword.forEach(function(data){
            wordList.push({"word":data, "len":data.length})
        });


        var sortBanwords = getSortBanword(wordList);
        var banwordArr = sortBanwords.split('|')

        var template = $('#tmp_banword').html();
        var templateScript = Handlebars.compile(template);
        var context = banwordArr;
        var html = templateScript(context);
        $("#tableBody").html(html);


    }

    $("#banword").on('keydown', function(event){
        if (event.keyCode === 13) {
            $("#regBtn").click();
        };
    });


    $(document).on('click', '._banword', function(){
        var checkbox = $(this).parent().find('input[type="checkbox"]');

        if(checkbox.prop('checked')){
            checkbox.removeAttr('checked');
        }else{
            checkbox.prop('checked', 'checked');
        }
    });

    $("#deleteBtn").on('click', function(){         // 하단 삭제버튼
        deleteBanword();
    });
    $("#deleteBtn2").on('click', function(){        //상단 삭제버튼
        deleteBanword();
    });

    $('#regBtn').on('click', function(){

        var banword = $('#banword');
        if(banword.val().length < 2){
            alert('2글자 이상으로 등록해주세요.');
            return false;
        }

        var isDuplBanword = false;
        $('.text-danger').each(function(){
           if(banword.val() == $(this).text()){
               isDuplBanword = true;
               alert('이미 등록된 금지어 입니다.');
               return false;
           }
        });

        if(!isDuplBanword){
            if(confirm("등록하시겠습니까?")){
                $('td.last').append('<a href="javascript://" class="_banword" style="display:none">등록.[<span class="text-danger">'+banword.val()+'</span>]</a>');
                insertBanword('insert');
            }

        }
    });

    function insertBanword(type){

        var wordList = new Array();
        $('._banword span.text-danger').each(function(){
            wordList.push({"word":$(this).text(), "len":$(this).text().length})
        });

        var banwords = getSortBanword(wordList);

        var data = {
            idx : $("#idx").val()
            , ban_word : banwords
            , count : $('._banword span.text-danger').length
        };
        util.getAjaxData(type, '/rest/content/siteban/update', data, fn_succ_updt);
    }

    //금칙어 길이순으로 정렬
    function getSortBanword(paramWordList){
        var banwords = '';
        var wordList = paramWordList;
        wordList.sort(function(a, b){
            return a.len > b.len ? -1 : a.len < b.len ? 1 : 0;
        });
        wordList.forEach(function(word, i){
            banwords += word.word + '|';
        });
        banwords = banwords.substr(0, banwords.length-1);
        return banwords;
    }

    function fn_succ_updt(){
        $("#banword").val('');
        init();
    }

    $('#excelDownBtn').on('click', function() {
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);
        formData.append("banword", $("#banword").val());
        formData.append("slctType", slctType);
        util.excelDownload($(this), "/rest/content/siteban/listExcel", formData, fn_success_excel, fn_fail_excel);
    });

    function fn_success_excel(dst_id, response) {
        dalbitLog("########성공");
    }

    function fn_fail_excel() {
        dalbitLog("########실패");
    }

    function deleteBanword(){
        var checkboxs = $('input._banwordChk:checked');
        if(0 == checkboxs.length){
            alert('삭제할 금지어를 선택해주세요.');
            return;
        }
        if(confirm(checkboxs.length + '개의 금칙어를 삭제하시겠습니까?')){
            $('input._banwordChk:checked').each(function(){
                $(this).parent().remove();
            });
            insertBanword('delete');
        }
    }
</script>

<script type="text/x-handlebars-template" id="tmp_banword">
    {{#each this}}
        {{#openTr @index 7}}
            <tr>
        {{/openTr}}
            <td class='{{#equal @last true}}last{{/equal}}' style="width: 400px">
                <input type="checkbox" class="_banwordChk" />
                <a href="javascript://" class="_banword">{{index @index no}}.[<span class='text-danger'>{{this}}</span>]</a>
            </td>

        {{#closeTr @index 7 @last}}
            </tr>
        {{/closeTr}}
    {{else}}
        <tr>
            <td colspan="10">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>