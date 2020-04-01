<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper">
    <div id="page-wrapper">
        <div id="container-fluid">
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table mb10">
                    <div class="widget-header">
                        <h3><i class="fa fa-table"></i> 현재 접속자 통계 현황 </h3>
                        <div class="btn-group widget-header-toolbar">
                            <a href="#" title="Expand/Collapse" class="btn-borderless btn-toggle-expand"><i class="fa fa-chevron-up"></i></a>
                        </div>
                    </div>
                    <div class="widget-content mt10">
                        <table class="table table-condensed table-dark-header table-bordered">
                            <thead>
                            <tr>
                                <th></th>
                                <th>실시간</th>
                                <th>전일</th>
                                <th>증감</th>
                                <th>주간</th>
                                <th>전주</th>
                                <th>증감</th>
                                <th>월간</th>
                                <th>전월</th>
                                <th>증감</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>남성</th>
                                <td> 40 </td>
                                <td> 30 </td>
                                <td class="_up"><i class="fa fa-caret-up"></i> 10 </td>
                                <td> 40 </td>
                                <td> 30 </td>
                                <td class="_up"><i class="fa fa-caret-up"></i> 10 </td>
                                <td> 40 </td>
                                <td> 30 </td>
                                <td class="_up"><i class="fa fa-caret-up"></i> 10 </td>
                            </tr>
                            <tr>
                                <th>여성</th>
                                <td> 40 </td>
                                <td> 30 </td>
                                <td class="_up"><i class="fa fa-caret-up"></i> 10 </td>
                                <td> 10 </td>
                                <td> 10 </td>
                                <td class="_up"><i class="fa fa-caret-up"></i> 10 </td>
                                <td> 10 </td>
                                <td> 10 </td>
                                <td class="_up"><i class="fa fa-caret-up"></i> 10 </td>
                            </tr>
                            <tr class="success">
                                <th>합계</th>
                                <td> 40 </td>
                                <td> 30 </td>
                                <td class="_up"><i class="fa fa-caret-up"></i> 10 </td>
                                <td> 40 </td>
                                <td> 30 </td>
                                <td class="_up"><i class="fa fa-caret-up"></i> 10 </td>
                                <td> 10 </td>
                                <td> 10 </td>
                                <td class="_up"><i class="fa fa-caret-up"></i> 10 </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- tab -->
            <div class="no-padding" id="infoTab">
                <jsp:include page="infoTab.jsp"/>
            </div>
            <!-- //tab -->
        </div> <!-- // container-fluid -->
    </div> <!-- // page-wrapper -->
</div> <!-- // wrapper -->