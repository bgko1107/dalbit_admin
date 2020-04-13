
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="main-header">
    <div id="page-wrapper">
        <div id="headerTab">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                <li class="active"><a href="#sitebanList" role="tab" data-toggle="tab">사이트 금지어 관리</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active in" id="sitebanList">
                    <div>
                        <div class="row col-md-12" style="padding-bottom: 15px">
                            <div class="pull-left">
                                • 사이트 내 닉네임 , 채팅글 , 팬보드 , 방송 제목 또는 방송 환영글 등에서 사용을 금지하는 금지어 관리 공간입니다.
                                <br>
                                • 4글자 이상으로 등록해주세요.
                            </div>
                            <div class="pull-right">
                                <%--<button type="button" class="btn btn-default mr-10" id="addBtn"><i class="fa fa-plus-square"></i>등록</button>--%>
                                <%--<button type="button" class="btn btn-primary "><i class="fa fa-floppy-o"></i>적용</button>--%>
                            </div>
                        </div>

                        <div class="widget-content">
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

                                <div class="btn-group pull-right" role="group">
                                    <button type="button" class="btn btn-default mr-10" id="addBtn"><i class="fa fa-plus-square"></i>등록</button>
                                    <button type="button" class="btn btn-primary" id="insertBtn"><i class="fa fa-floppy-o"></i>적용</button>
                                </div>
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
<script type="text/javascript" src="/js/code/content/contentCodeList.js"></script>
<script type="text/javascript" src="/js/handlebars/contentHelper.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        init();
    });

    //=------------------------------ Init / Event--------------------------------------------

    function init() {
        util.getAjaxData('siteban', '/rest/content/siteban/list', null, fn_succ_list);
    }

    function fn_succ_list(dst_id, response){
        $("#idx").val(response.data.idx);
        var banwords = response.data.ban_word.split('|');

        var template = $('#tmp_banword').html();
        var templateScript = Handlebars.compile(template);
        var context = banwords;
        var html = templateScript(context);
        $("#tableBody").html(html);
    }

    $(document).on('click', '._banword', function(){
        var checkbox = $(this).parent().find('input[type="checkbox"]');

        if(checkbox.prop('checked')){
            checkbox.removeAttr('checked');
        }else{
            checkbox.prop('checked', 'checked');
        }
    });

    $("#deleteBtn").on('click', function(){
        var checkboxs = $('input._banwordChk:checked');
        if(0 == checkboxs.length){
            alert('삭제할 금지어를 선택해주세요.');
            return;
        }

        if(confirm(checkboxs.length + '개의 금칙어를 삭제하시겠습니까?')){
            var banwords = '';
            $('._banword span.text-danger').each(function(){
                banwords += $(this).text() + '|';
            });

            var data = {
                idx : $("#idx").val()
                , ban_word : banwords
                , count : $('._banword span.text-danger').length
            }
            util.getAjaxData('siteban', '/rest/content/siteban/update', data, fn_succ_list);
        }
    });
</script>

<script type="text/x-handlebars-template" id="tmp_banword">
    {{#each this}}
        {{#openTr @index 7}}
            <tr>
        {{/openTr}}
            <td class='{{#equal @last true}}last{{/equal}}'>
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