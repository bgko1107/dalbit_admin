<%
/****************************************************************************************
* ���ϸ� : cn_cancel_req.jsp
* �ۼ��� : ���񽺿
* �ۼ��� : 2019.07
* ��  �� : �ſ�ī�� Socket ��� ��� ���� ������
* ��	�� : 0003
* ---------------------------------------------------------------------------------------
* �ҽ� ���Ǻ��濡 ���� �ս��� ������𽺿��� å������ �ʽ��ϴ�.
* ��û �Ķ���� �� ������� ���� ������ �ݵ�� ���� �Ŵ����� �����Ͻʽÿ�.
* �ſ�ī��(CN)�� �����׽�Ʈ ȯ���� �������� �ʽ��ϴ�.
* �׽�Ʈ �������� ������ ������ �Ǵ� ��� ����� �̿��Ͽ� ���� ��� ó���� �ؾ� �մϴ�.
****************************************************************************************/
%>

<%@page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!--  �������� ������û ������ -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ksc5601">
</head>

<body>
<h3>�ſ�ī�� ���� ��� SAMPLE PAGE</h3>
<hr>
<form name='cplogn' method='post' action='/payment/pay/cancel/card/result'>
<table>
	<tr>
		<td> �ŷ���� : </td>
		<td> <input type="text" maxlength="20" name="mode" value="CN07"> </td>
	</tr>
	<tr>
		<td> ����ƮURL : </td>
		<td> <input type="text" maxlength="20" name="recordKey" value="www.dalbitlive.com"> </td>
	</tr>
	<tr>
		<td> ���񽺾��̵� : </td>
		<td> <input type="text" maxlength="12" name="svcId" value="200414085473"> </td>
	</tr>
	<tr>
		<td> �ŷ���ȣ(������) : </td>
		<td> <input type="text" maxlength="50" name="tradeId" value="200414085473_202005151522020830"> </td>
	</tr>
	<tr>
		<td> �ŷ���ȣ(�������) : </td>
		<td> <input type="text" maxlength="20" name="mobilId" value="200515088425956"> </td>
	</tr>
	<tr>
		<td> ��ұݾ� : </td>
		<td> <input type="text" maxlength="30" name="prdtPrice" value="3000"> </td>
	</tr>
	<tr>
		<td> �κ���ҿ��� : </td>
		<td> <input type="text" maxlength="40" name="partCancelYn" value=""> </td>
	</tr>
</table>
<p> <input type="button" value="��û�ϱ�" onClick='document.cplogn.submit();'> </p>
</form>
</body>
</html>