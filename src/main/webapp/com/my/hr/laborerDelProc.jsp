<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ page import='com.my.hr.service.LaborerService, com.my.hr.service.LaborerServiceImpl' %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%	LaborerService laborerService = new LaborerServiceImpl();

	if( request.getParameter("laborerId") != null ) {
		int laborerId = Integer.parseInt(request.getParameter("laborerId"));
		laborerService.delLaborer(laborerId);
%>
		<jsp:forward page='laborer.jsp'/>
<%	
	} else {
%>
		<c:redirect url='laborer.jsp'>
			<c:param name='error' value='delError'/>
		</c:redirect>
<%
	}
%>