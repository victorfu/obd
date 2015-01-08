<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	function _go() {
		var pc = $("#pageCode").val();//获取文本框中的当前页码
		if (!/^[1-9]\d*$/.test(pc)) {//对当前页码进行整数校验
			alert('请输入正确的页码！');
			return;
		}
		if (pc > ${page.totalPage }) {//判断当前页码是否大于最大页
			alert('请输入正确的页码！');
			return;
		}
		location = "${page.url }&curPage="+pc;
	}
</script>
<div class="divBody">
	<div class="divContent">
		<%-- 首页 --%>
		<c:choose>
     		<c:when test="${page.currentPage eq 1}">
     			<span class="spanBtnDisabled">首页</span>	
     		</c:when>
     		<c:otherwise>
     			<a href="${page.url }&curPage=1" class="aBtn bold">首页</a>
     		</c:otherwise>
     	</c:choose>
	
		<%-- 上一页 --%>
		<c:choose>
     		<c:when test="${page.currentPage eq 1}">
     			<span class="spanBtnDisabled">上一页</span>	
     		</c:when>
     		<c:otherwise>
     			<a href="${page.url }&curPage=${page.currentPage-1 }" class="aBtn bold">上一页</a>
     		</c:otherwise>
     	</c:choose>

		<%-- 
			通过当前页码，计算页码列表的开始和结束位置，即两个变量begin, end
			1.总页数不足6页， -->begin=1, end=最大页
			2.通过公式设置begin和end, begin=当前页-1, end=当前页+3
			3.如果begin<1， 那么让begin=1, end=6
			4.如果begin>总页数，让begin=总页数-5，end=总页数
		 --%>
	     <c:choose>
	     	<c:when test="${page.totalPage le 6 }">
	     		<c:set var="begin" value="1"/>
	     		<c:set var="end" value="${page.totalPage }"/>
	     	</c:when>
	     	<c:otherwise>
	     		<c:set var="begin" value="${page.currentPage-2 }"/>
	     		<c:set var="end" value="${page.currentPage+3}"/>
	     		<c:if test="${begin lt 1 }">
	     			<c:set var="begin" value="1"/>
	     			<c:set var="end" value="6"/>
	     		</c:if>
	     		<c:if test="${end gt page.totalPage }">
	     			<c:set var="begin" value="${page.totalPage-5 }"/>
	     			<c:set var="end" value="${page.totalPage }"/>
	     		</c:if>
	     	</c:otherwise>
	     </c:choose>
     
     <c:forEach begin="${begin }" end="${end }" var="i">
     	<c:choose>
     		<c:when test="${i eq page.currentPage }">
     			<span class="spanBtnSelect">${i }</span>
     		</c:when>
     		<c:otherwise>
     			<a href="${page.url }&curPage=${i }" class="aBtn">${i }</a>
     		</c:otherwise>
     	</c:choose>
     </c:forEach>
     
     <%-- 显示... --%>
     <c:if test="${end lt page.totalPage }">
     	<span class="spanApostrophe">...</span>
     </c:if>
     
     <%-- 下一页 --%>
     <c:choose>
     	<c:when test="${page.currentPage eq page.totalPage }">
     		<span class="spanBtnDisabled">下一页</span>		
     	</c:when>
     	<c:otherwise>
     		<a href="${page.url }&curPage=${page.currentPage+1 }" class="aBtn bold">下一页</a>
     	</c:otherwise>
     </c:choose>
     
     <%-- 尾页 --%>
     <c:choose>
     	<c:when test="${page.currentPage eq page.totalPage }">
     		<span class="spanBtnDisabled">尾页</span>		
     	</c:when>
     	<c:otherwise>
     		<a href="${page.url }&curPage=${page.totalPage }" class="aBtn bold">尾页</a>
     	</c:otherwise>
     </c:choose>
     
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<%-- 共N页 到M页 --%>
	<span>当前第${page.currentPage }页，总共${page.totalPage }页，总共${page.totalRows }条记录</span>
	<span>到</span>
	<input type="text" class="ipt20" id="pageCode" value="${page.currentPage }" />
	<span>页</span>
	<a href="javascript:_go();" class="aBtn bold">确定</a>
	</div>
</div>