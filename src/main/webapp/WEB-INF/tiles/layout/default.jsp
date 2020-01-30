<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <tiles:insertAttribute name="header"/>
</head>
<body>
    <tiles:insertAttribute name="script"/>

    <div id="wrapper">
        <tiles:insertAttribute name="navi"/>
        <tiles:insertAttribute name="body"/>
    </div>
</body>
</html>
