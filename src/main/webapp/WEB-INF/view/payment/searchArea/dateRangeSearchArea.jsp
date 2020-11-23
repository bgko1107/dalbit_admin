<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="input-group date" id="rangeDatepicker" style="display: none">
    <label for="displayDate" class="input-group-addon">
        <span><i class="fa fa-calendar"></i></span>
    </label>
    <input type="text" name="displayDate" id="displayDate" class="form-control" />
</div>

<script type="text/javascript">
    $("#displayDate").statsDaterangepicker(
        function(start, end, t1) {
            $("#startDate").val(start.format('YYYY.MM.DD'));
            $("#endDate").val(end.format('YYYY.MM.DD'));
        }
    );
</script>
