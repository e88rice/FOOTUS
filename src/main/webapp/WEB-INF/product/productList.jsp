<%@ page import="com.example.fus.dto.UserDTO" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%
    // 페이징 세팅
    int pagePerBlock = 10; // 페이지 출력 시 나올 범위.
    int pageNum = Integer.parseInt((String) request.getAttribute("pageNum"));
    String category = request.getParameter("category");
    int count =  Integer.parseInt((String)request.getAttribute("count")); // 총 게시물 갯수
    int totalPage = count % 4 == 0 ? (count / 4) : (count / 4) + 1; // 총 페이지
    // 총 게시물 갯수를 pagePerBlock으로 나눴을 때 나머지 없이 딱 떨어지면 바로 몫으로 페이징, 나머지가 있으면 +1 해서 페이징
    int totalBlock = totalPage % pagePerBlock == 0 ? totalPage / pagePerBlock : totalPage / pagePerBlock + 1; // 6 % 5 0
    int thisBlock = ((pageNum - 1) / pagePerBlock) + 1; // 현재 블럭
    int firstPage = ((thisBlock - 1) * pagePerBlock) + 1; // 블럭의 첫 페이지
    int lastPage = thisBlock * pagePerBlock; // 블럭의 마지막 페이지
    lastPage = (lastPage > totalPage) ? totalPage : lastPage;

    String memberId = null;
    if(session.getAttribute("loginInfo") != null){
        UserDTO userDTO = (UserDTO) session.getAttribute("loginInfo");
        memberId = userDTO.getMemberId();
    }

%>
<html lang="ko">
<head>
    <title>상품 목록</title>
    <script src="https://kit.fontawesome.com/4ae8b5f015.js" crossorigin="anonymous"></script> <%-- 폰트어썸(아이콘 사이트) --%>
    <script src="/assets/js/product/productList.js"></script>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false" />
<div class="margin-block"></div>
<c:set var="totalPage" value="<%=totalPage%>" />
<c:set var="pagePerBlock" value="<%=pagePerBlock%>" />
<c:set var="totalBlock" value="<%=totalBlock%>" />
<c:set var="thisBlock" value="<%=thisBlock%>" />
<c:set var="firstPage" value="<%=firstPage%>" />
<c:set var="lastPage" value="<%=lastPage%>" />
<c:set var="pageNum" value="<%=pageNum%>" />
<c:set var="category" value="<%=category%>" />
<c:set var="memberId" value="<%=memberId%>" />


<div class="product-list-nav">
    <ul class="nav navbar">
        <%--   관리자만 볼 수 있음   --%>
        <c:if test="${memberId == 'testman3'}">
            <li class="nav-item"><a class="nav-link" href="/product/add">상품 등록</a></li>
            <li class="nav-item"><a class="nav-link" href="/product/edit?pageNum=1&category=ALL">상품 편집</a></li>
        </c:if>
    </ul>
</div>

<div class="wrapper2">
    <div class="products-category-container">
        <div class="league-container">
            <a href="/product/list?pageNum=1&category=ALL">
            <div class="products-category league" data-value="ALL">
                <span>전체</span>
            </div>
            </a>
            <a href="/product/list?pageNum=1&category=EPL">
            <div class="products-category league" data-value="EPL">
                <img class="fa-bounce" src="/assets/images/league/EPL.png">
                <span>프리미어리그</span>
            </div>
            </a>
            <a href="/product/list?pageNum=1&category=ESP">
            <div class="products-category league" data-value="ESP">
                <img class="fa-bounce" src="/assets/images/league/ESP.png">
                <span>프리메라리가</span>
            </div>
            </a>
            <a href="/product/list?pageNum=1&category=GER">
            <div class="products-category league" data-value="GER">
                <img class="fa-bounce" src="/assets/images/league/GER.png">
                <span>분데스리가</span>
            </div>
            </a>
            <a href="/product/list?pageNum=1&category=SERIA">
            <div class="products-category league" data-value="SERIA">
                <img class="fa-bounce" src="/assets/images/league/SERIE.png">
                <span>세리에</span>
            </div>
            </a>
            <a href="/product/list?pageNum=1&category=FRA">
            <div class="products-category league" data-value="FRA">
                <img class="fa-bounce" src="/assets/images/league/FRA.png">
                <span>리그1</span>
            </div>
            </a>
            <a href="/product/list?pageNum=1&category=NAT">
            <div class="products-category league" data-value="NAT">
                <img class="fa-bounce" src="/assets/images/league/worldCup.png">
                <span>국가대표</span>
            </div>
            </a>
        </div>

    </div>
</div>


<div class="wrapper2">

    <h3 class="products-title">New items</h3>
    <div class="flex-test">
        <c:forEach var="newProduct" items="${newProducts}">
            <div class="product-list-wrap">
                <a href="/product/view?productId=${newProduct.productId}" class="product-wrap" role="button">
                    <div class="product-img-scale-wrap">
                        <img class="product-img" src="/upload/fus/product/${newProduct.fileName}">
                    </div>
                    <h4 class="product-name">${newProduct.productName}</h4>
                    <h6 class="product-description">${newProduct.description}</h6>
                    <h6 class="product-price">\<fmt:formatNumber type="number" maxFractionDigits="3" value="${newProduct.price}" /></h6>
                </a>
            </div>
        </c:forEach>
    </div>

    <h3 class="products-title">Hot items</h3>
    <div class="flex-test">
        <c:forEach var="orderProduct" items="${orderProducts}">
        <div class="product-list-wrap">
                <a href="/product/view?productId=${orderProduct.productId}" class="product-wrap" role="button">
                    <div class="product-img-scale-wrap">
                        <img class="product-img" src="/upload/fus/product/${orderProduct.fileName}">
                    </div>
                    <h4 class="product-name">${orderProduct.productName}</h4>
                    <h6 class="product-description">${orderProduct.description}</h6>
                    <h6 class="product-price">\<fmt:formatNumber type="number" maxFractionDigits="3" value="${orderProduct.price}" /></h6>
                </a>
        </div>
        </c:forEach>
    </div>

    <h3 class="products-title">Most reviews</h3>
    <div class="flex-test">
        <c:forEach var="reviewProduct" items="${reviewProducts}">
        <div class="product-list-wrap">
                <a href="/product/view?productId=${reviewProduct.productId}" class="product-wrap" role="button">
                    <div class="product-img-scale-wrap">
                        <img class="product-img" src="/upload/fus/product/${reviewProduct.fileName}">
                    </div>
                    <h4 class="product-name">${reviewProduct.productName}</h4>
                    <h6 class="product-description">${reviewProduct.description}</h6>
                    <h6 class="product-price">\<fmt:formatNumber type="number" maxFractionDigits="3" value="${reviewProduct.price}" /></h6>
                </a>
        </div>
        </c:forEach>
    </div>
</div>

<%-- 상품 리스트 페이지 이동 버튼들--%>
<div class="block-btn-wrap">
    <c:if test="${totalPage > 0}">
        <a href="<c:url value="/product/list?pageNum=1&category=${category}" />"><span><i class="fa-solid fa-angles-left"></i></span></a>
        <c:if test="${thisBlock > 1}">
            <a href="<c:url value="/product/list?pageNum=${firstPage - 1}&category=${category}" />"><span><i class="fa-solid fa-angle-left"></i></span></a>
        </c:if>

        <c:forEach var="i" begin="${firstPage}" end="${lastPage}">
            <a href="/product/list?pageNum=${i}&category=${category}">
                <c:choose>
                    <c:when test="${pageNum==i}">
                        <span style="color: #4C5317;font-weight: bold"> [${i}] </span>
                    </c:when>
                    <c:otherwise>
                        <span style="color: #4C5317;"> [${i}] </span>
                    </c:otherwise>
                </c:choose>
            </a>
        </c:forEach>

        <c:if test="${thisBlock < totalBlock}" >
            <a href="<c:url value="/product/list?pageNum=${lastPage + 1}&category=${category}" />"><span><i class="fa-solid fa-angle-right"></i></span></a>
        </c:if>
        <a href="<c:url value="/product/list?pageNum=${totalPage}&category=${category}" />"><span><i class="fa-solid fa-angles-right"></i></span></a>
    </c:if>
</div>

<jsp:include page="../layout/footer.jsp?" flush="false"/>
</body>
</html>