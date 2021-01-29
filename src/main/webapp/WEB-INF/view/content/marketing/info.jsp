<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div id="container-fluid" class="col-lg-12 no-padding">
            <!-- serachBox -->
            <form id="searchForm">
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
                                    <span id="search_searchType_aria"></span>

                                    <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색할 정보를 입력하세요"></label>
                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <!-- //serachBox -->
        </div> <!-- // container-fluid -->
        <!-- tab -->
        <div class="no-padding col-lg-12" id="infoTab">
            <jsp:include page="infoTab.jsp"/>
        </div>
        <!-- //tab -->
    </div> <!-- // page-wrapper -->
</div> <!-- // wrapper -->

<script type="text/javascript" src="/js/code/enter/joinCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/dataTablesSource/content/marketingDataTableSource.js?${dummyData}"></script>
<script type="text/javascript" src="/js/util/statUtil.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script type="text/javascript">

    $(function() {

        $("#search_searchType_aria").html(util.getCommonCodeSelect(-1, marketing_search_type));

        $('input[id="searchText"]').on('keydown', function(e) {    // textBox 처리
            if(e.keyCode == 13) {
                $("#bt_search").click();
            }
        });

    });

    function dataSet(){

        var data = {
            searchText : $("#searchText").val()
            , slctType : $('#tablist_con li').index($('#tablist_con li.active')) + 1
        };

        return data;
    }

</script>