<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String in_memNo = request.getParameter("memNo");
%>

<div class="col-md-12 no-padding">
    <div class="widget-content">
        <div class="tab-pane fade in active" id="memberDetail"><jsp:include page="../memberTab.jsp"/></div>     <!-- 상세 -->
    </div>
</div>
<script>
    $(document).ready(function() {
        $('#tabList_top').addClass("show");
        getMemNo_info_reload(<%=in_memNo%>);
    });

</script>