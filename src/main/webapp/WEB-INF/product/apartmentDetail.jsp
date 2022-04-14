<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../resources/css/product.css">
<!-- JQuery -->
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- 구글 차트 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- 카카오 지도 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=676eb5fa2637b234997b24dd7566e9ba&libraries=services"></script>

<!-- 구글 차트 정보 -->
<script type="text/javascript">

google.charts.load('current', {packages: ['corechart', 'bar']});

google.charts.setOnLoadCallback(drawBasic);

 
function drawBasic() {
var data = new google.visualization.DataTable();
data.addColumn('string', '날짜');
data.addColumn('number', '계약건수');

data.addRows([
['22.01', <c:out value="${ACount}"/>],
['22.02', <c:out value="${BCount}"/>],
['22.03', <c:out value="${CCount}"/>],
]);

var options = {
title: '해당 아파트 다른 거래',
hAxis: {
title: '',
viewWindow: {
min: [3, 0],
max: [3, 10]
}
},

vAxis: {
title: ''
}
};

var chart = new google.visualization.ColumnChart(
document.getElementById('chart_div'));
chart.draw(data, options);
}

</script>

<style>
.map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap {position:relative;width:700px;height:500px;}
#category {position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
#category li {float:left;list-style: none;width:100px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
#category li.on {background: #eee;}
#category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
#category li:last-child{margin-right:0;border-right:0;}
#category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
#category li .category_bg {background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;}
#category li .bank {background-position: -10px 0;}
#category li .mart {background-position: -10px -36px;}
#category li .pharmacy {background-position: -10px -72px;}
#category li .oil {background-position: -10px -108px;}
#category li .cafe {background-position: -10px -144px;}
#category li .store {background-position: -10px -180px;}
#category li.on .category_bg {background-position-x:-46px;}
.placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
.placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.placeinfo .tel {color:#0f7833;}
.placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
</style>
</head>
<body>



<div class="wrapper">
  <div class="productContainer">
 <!-- 사이드바 정보 -->
	<div class="sidebar">
	<div class="sidebarName">${vo.name}</div>
		<div style="padding:0px 0px 10px 0px;">
			<div class="sidebarTitle">
				<div>거래 날짜</div>
				<div>가격</div>
				<div>주소</div>
				<div>전용 면적</div>
				<div>층수</div>
				<div>건축년도</div>
				<div>거래유형</div>
				<div>중개사 소재지</div>
			</div>
			<div class="sidebarContent">
		 		<div>${c_date }</div>
			  	<div>
			  		<c:choose>
					  		<c:when test="${p2!=0}">
								 	${p1 }억 ${p2 }만원
							</c:when>
							<c:when test="${p2==0 }">
								 	${p1 }억원
						 	</c:when>
				 	</c:choose>
				</div>
				<div>
					 	 		<span id="address_first"> ${addr_B} </span>	<span id="address_second"> ${addr_R} </span>
						  		<button class="buttonChange" onclick="button_address()">⇆</button>
				</div>
			 	<div>
			 			<span id="area_first">${area_size1}㎡</span> <span id="area_second">${area_size2}평</span>
			 			<button class="buttonChange" onclick="button_area()">⇆</button>
				</div>
				<div>${vo.floor }층</div>
				<div>${vo.construction_date}년</div>
				<div>${vo.deal_type}</div>
				<div>${vo.agent_seat}</div>
		 </div>
	</div>
	<div class="buttonMenu">
			<button class="button2" onclick="button_mark();">즐겨찾기</button>
			<button class="button3" onclick="button_back()">목록</button>
	</div>
  </div>
	
	
<!-- /////////////////////카카오 맵////////////////////// -->
		<div class="map_wrap">
    	<div id="map" style="width:700px;height:500px;position:relative;overflow:hidden;"></div>
	
		    <ul id="category">
		        <li id="HP8" data-order="0"> 
		            <span class="category_bg bank"></span>
		            병원
		        </li>       
		        <li id="PS3" data-order="1"> 
		            <span class="category_bg mart"></span>
		            어린이집,유치원
		        </li>  
		        <li id="SC4" data-order="2"> 
		            <span class="category_bg pharmacy"></span>
		            학교
		        </li>  
		        <li id="SW8" data-order="3"> 
		            <span class="category_bg oil"></span>
		            지하철역
		        </li>  
		        <li id="CE7" data-order="4"> 
		            <span class="category_bg cafe"></span>
		            카페
		        </li>  
		        <li id="CS2" data-order="5"> 
		            <span class="category_bg store"></span>
		            편의점
		        </li>      
		    </ul>
	</div>
	
	
<!-- /////////////////////차트///////////////////////////// -->
	<div id="chart_div"></div>
  
	
<!-- ///////////////////이름 같은 매물 정보/////////////////////// -->
 	<div>
		<table class="table2">
			<tr style="background-color:gray;color:white;">
				<th width=25% class="text-center">매물명</th>
				<th width=20% class="text-center">가격</th>
				<th width=15% class="text-center">전용면적</th>
				<th width=10% class="text-center">층수</th>
				<th width=20% class="text-center">거래 날짜</th>
				<th width=10% class="text-center">거래유형</th>
					
			</tr>
			  <c:forEach var="asvo" items="${aSameList }">
				<c:if test="${asvo.no ne vo.no }">
					<c:if test="${not empty aSameList }">
							<tr style="height:30px;">
								<td width=25% class="text-center">
										<a href="../product/apartmentDetail.do?no=${asvo.no}">${asvo.name }</a>
								</td>
								<td width=20% class="text-center">
											<c:choose>
												<c:when test="${asvo.price>99999 }">
													${fn:substring(asvo.price,0,2) }억 ${fn:substring(asvo.price,2,6) }만원
												</c:when>
												<c:otherwise>
													${fn:substring(asvo.price,0,1) }억 ${fn:substring(asvo.price,1,5) }만원
												</c:otherwise>
											</c:choose>
											<c:if test="${asvo.price > vo.price }">(↑)</c:if>
											<c:if test="${asvo.price == vo.price }">(동일)</c:if>
											<c:if test="${asvo.price < vo.price }">(↓)</c:if>
								</td>
								<td width=15% class="text-center">
											${asvo.area_size } ㎡
											<c:if test="${asvo.area_size > vo.area_size }">(↑)</c:if>
											<c:if test="${asvo.area_size == vo.area_size }">(동일)</c:if>
											<c:if test="${asvo.area_size < vo.area_size }">(↓)</c:if>
								</td>							
								<td width=10% class="text-center">${asvo.floor }층</td>
								<td width=20% class="text-center"><fmt:formatDate value="${asvo.contract_date}" pattern="yyyy-MM-dd"/></td>
								<td width=10% class="text-center">${asvo.deal_type }</td>
							</tr>
					</c:if>
				</c:if>
			  </c:forEach>
			<c:if test="${fn:length(aSameList)==1 }">
					<tr style="height:30px;">
						<td colspan="6" class="text-center">다른 계약 매물 없음</td>
					</tr>
			</c:if>
		</table>
 	</div>
	   	<ul>
			<br>
		</ul>
  </div>
</div>

<script>

/* 문의하기 버튼 */
function button_mark() {
	if(${not empty sessionScope.username}){
		if(confirm("즐겨찾기에 추가되었습니다. 마이페이지로 이동하시겠습니까?"))
		{
		location.href="../mypage/main.do";
		}
		else
		{
		}
	}else{
		alert("로그인후 사용이 가능합니다.");
		location.href="../user/signin.do";
	}
}
/* 목록으로 돌아가기 버튼 */
function button_back() {
		   location.href="../product/apartmentlist.do"

}

$('#address_first').hide();
let i = 0;
function button_address() {
	if(i==0){
		$("#address_first").show();
		$("#address_second").hide();
		i=1
	}else{
		$("#address_first").hide();
		$("#address_second").show();
		i=0;
	}
};

let j =0;
$('#area_first').hide();
function button_area() {
	if(j==0){
		$("#area_first").show();
		$("#area_second").hide();
		j=1
	}else{
		$("#area_first").hide();
		$("#area_second").show();
		j=0;
	}
};



//////////////////////////////////카카오지도////////////////////////////////

	// 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
	var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
	    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
	    markers = [], // 마커를 담을 배열입니다
	    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
	 
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 5 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch("${addr_R}", function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });


	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});    

	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 5 // 지도의 확대 레벨
	    };

	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places(map); 

	// 지도에 idle 이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'idle', searchPlaces);

	// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
	contentNode.className = 'placeinfo_wrap';

	// 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
	// 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
	addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
	addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

	// 커스텀 오버레이 컨텐츠를 설정합니다
	placeOverlay.setContent(contentNode);  

	// 각 카테고리에 클릭 이벤트를 등록합니다
	addCategoryClickEvent();

	// 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
	function addEventHandle(target, type, callback) {
	    if (target.addEventListener) {
	        target.addEventListener(type, callback);
	    } else {
	        target.attachEvent('on' + type, callback);
	    }
	}

	// 카테고리 검색을 요청하는 함수입니다
	function searchPlaces() {
	    if (!currCategory) {
	        return;
	    }
	    
	    // 커스텀 오버레이를 숨깁니다 
	    placeOverlay.setMap(null);

	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
	}

	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
	        displayPlaces(data);
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	        // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

	    } else if (status === kakao.maps.services.Status.ERROR) {
	        // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
	        
	    }
	}

	// 지도에 마커를 표출하는 함수입니다
	function displayPlaces(places) {

	    // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
	    // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
	    var order = document.getElementById(currCategory).getAttribute('data-order');

	    

	    for ( var i=0; i<places.length; i++ ) {

	            // 마커를 생성하고 지도에 표시합니다
	            var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);

	            // 마커와 검색결과 항목을 클릭 했을 때
	            // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
	            (function(marker, place) {
	                kakao.maps.event.addListener(marker, 'click', function() {
	                    displayPlaceInfo(place);
	                });
	            })(marker, places[i]);
	    }
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, order) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(27, 28),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });

	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	    return marker;
	}

	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}

	// 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
	function displayPlaceInfo (place) {
	    var content = '<div class="placeinfo">' +
	                    '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';   

	    if (place.road_address_name) {
	        content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
	                    '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
	    }  else {
	        content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
	    }                
	   
	    content += '    <span class="tel">' + place.phone + '</span>' + 
	                '</div>' + 
	                '<div class="after"></div>';

	    contentNode.innerHTML = content;
	    placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
	    placeOverlay.setMap(map);  
	}


	// 각 카테고리에 클릭 이벤트를 등록합니다
	function addCategoryClickEvent() {
	    var category = document.getElementById('category'),
	        children = category.children;

	    for (var i=0; i<children.length; i++) {
	        children[i].onclick = onClickCategory;
	    }
	}

	// 카테고리를 클릭했을 때 호출되는 함수입니다
	function onClickCategory() {
	    var id = this.id,
	        className = this.className;

	    placeOverlay.setMap(null);

	    if (className === 'on') {
	        currCategory = '';
	        changeCategoryClass();
	        removeMarker();
	    } else {
	        currCategory = id;
	        changeCategoryClass(this);
	        searchPlaces();
	    }
	}

	// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
	function changeCategoryClass(el) {
	    var category = document.getElementById('category'),
	        children = category.children,
	        i;

	    for ( i=0; i<children.length; i++ ) {
	        children[i].className = '';
	    }

	    if (el) {
	        el.className = 'on';
	    } 
	}
	
</script>

</body>
</html>