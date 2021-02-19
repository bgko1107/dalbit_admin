<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
            <div class="col-md-12">
                <div class="row  form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <span id="terms_platform" onchange="getList();"></span>
                                    <span id="terms_type" onchange="getList();"></span>
                                    <label><input type="text" class="form-control" id="txt_search" name="searchText" placeholder="검색할 정보를 입력하세요"></label>
                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <!-- //serachBox -->
                <!-- DATA TABLE -->
                <div class="row  form-inline">
                    <div class="widget widget-table" id="termsTable">
                        <div class="widget-header">
                            <h3><i class="fa fa-desktop"></i> 약관 관리 </h3>
                        </div>
                        <span id="question_summaryArea"></span>
                        <div class="widget-content">
                            <table id="list_info" class="table table-sorting table-hover table-bordered">
                                <thead>
                                </thead>
                                <tbody id="tableBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- DATA TABLE END -->
            <!-- TAB -->
            <div class="no-padding mb15">
                <jsp:include page="termsTab.jsp"></jsp:include>
            </div>
            <!-- TAB END -->
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/code/customer/customerCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/administrate/adminCodeList.js?${dummyData}"></script>

<script>
    $(document).ready(function() {

        $('input[id="txt_search"]').keydown(function(e) {
            if (e.keyCode === 13) {
                getList();
            };
        });
        <!-- 버튼 -->
        $('#bt_search').click( function() {       //검색
            getList();
        });
        <!-- 버튼 끝 -->
    });
    $("#terms_platform").html(util.getCommonCodeSelect(-1, terms_platform));
    $("#terms_type").html(util.getCommonCodeSelect(-1, terms_type));

    $('#one_title').html("ㆍ회원의 1:1문의 내용을 확인하고, 답변 및 처리할 수 있습니다. 신중히 확인 한 후 답변바랍니다.");

    var dtList_info;
    var dtList_info_data = function ( data ) {
        data.searchText = $('#txt_search').val();
        data.platform = $("select[name='platform']").val();
        data.terms_type = $("select[name='terms_type']").val();
    };
    dtList_info = new DalbitDataTable($("#list_info"), dtList_info_data, termsDataTableSource.termList);
    dtList_info.useCheckBox(true);
    dtList_info.useIndex(true);
    dtList_info.createDataTable();

    var deleteBtn = '<input type="button" value="선택삭제" class="btn btn-danger btn-sm" id="btn_delete" style="margin-right: 3px;"/>';
    var insertBtn = '<input type="button" value="등록" class="btn btn-default btn-sm" id="btn_insert" style="margin-right: 3px;"/>';
    $("#termsTable").find(".footer-left").append(deleteBtn);
    $("#termsTable").find(".footer-right").append(insertBtn);

    $('#btn_insert').click(function() {                   // 수정
        new_insert();
        ui.unCheck('list_info');
    });
    $('#btn_delete').click(function() {                   // 수정
        terms_delete();
    });

    function getList(){                 // 검색
        dtList_info.reload();
    }

    function new_insert(){
        $("#tab_termsTab").removeClass('hide');
        var template = $('#tmp_terms_detailFrm').html();
        var templateScript = Handlebars.compile(template);
        $("#terms_detailFrm").html(templateScript);

        $('#bt_termsInsert').click(function() {                   // 등록
            termsGenerate("insert");
        });

        util.editorInit("content-notice");
    }
    function terms_delete(){
        if(dtList_info.getCheckedData().length <= 0){
            alert("삭제할 약관을 선택해 주세요.");
            return;
        }
        if(confirm("삭제하시겠습니까?")){
            var checkDatas = dtList_info.getCheckedData();
            for(var i=0;i<checkDatas.length;i++){
                var data = {};
                data.idx = checkDatas[i].idx;
                // console.log(data);
                util.getAjaxData("delete", "/rest/administrate/terms/delete",data, fn_delete_success);
            }
        }else false;
    }
    function fn_delete_success(data, response, params){
        dtList_info.reload();
        $("#tab_termsTab").addClass('hide');
    }

    function getTermsDetail(index){
        var data = dtList_info.getDataRow(index);
        terms_detail(data);
    }


    $(document).on('click', '#list_info .dt-body-center input[type="checkbox"]', function(){
        if($(this).prop('checked')){
            $(this).parent().parent().find('.getTermsDetail').click();
        }
    });

</script>