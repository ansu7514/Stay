<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- css -->
<link rel="stylesheet" href="${root}/css/hostReservationDetail.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<!-- js -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<title>Insert title here</title>
</head>
<body>
	<div class="reser-detail-wrap">
		<div class="room-detail">
			<!-- 숙소 이름 -->
			<div class="title">
				<a href="/room/content?no=${roomDto.no}">${roomDto.name}</a>
			</div>
			
			<!-- 숙소 주소, 예약 번호 -->
			<div class="addr">
				<label>주소 | ${roomDto.addr_load} ${roomDto.addr_detail}</label>	
				<label>예약번호 | ${reserDto.no}</label>
			</div>
			
			<hr style="margin: 20px 0;">
			
			<div class="photo-reser">
				<!-- 숙소 이미지 -->
				<div id="slideShow">
					<ul class="slides">
						<c:forEach var="img" items="${roomDto.photos}">
							<li>
								<img src="../photo/roomPhoto/${img}">
							</li>
						</c:forEach>
					</ul>
					
					<p class="controller">
						<!-- &lang: 왼쪽 방향 화살표 &rang: 오른쪽 방향 화살표 -->
						<span class="prev">&lang;</span>
						<span class="next">&rang;</span>
					</p>
				</div>
				
				<!-- 예약 정보 -->
				<div class="reser">
					<!-- 체크인 -->
					<div class="check-wrap">
						<div class="check-in">
							<div class="check-title">
								<label>체크인</label>
							</div>
							
							<hr>
							
							<div class="date">
								<span>${start[0]}년 ${start[1]}월 ${start[2]}일 (${startDayWeek})</span>
							</div>
						</div>
						
						<!-- 체크아웃 -->
						<div class="check-out">
							<div class="check-title">
								<label>체크아웃</label>
							</div>
							
							<hr>
							
							<div class="date">
								<span>${end[0]}년 ${end[1]}월 ${end[2]}일 (${endDayWeek})</span>
							</div>
						</div>
					</div>
					
					<!-- 가격 -->
					<div class="price-wrap">
						<div class="price-title">
							<label>결제 세부 정보</label>
						</div>
						
						<hr>
						
						<div class="price-de">
							<div class="price">
								<fmt:formatNumber value="${reserDto.price}" type="currency"/>
							</div>
							
							<div class="receipt">
								<span>영수증 보기</span>
								<span class="bi bi-receipt-cutoff" onclick="postPopUp()"></span>
								<!-- from -->
								<form action='/receipt/detail' method='post' id="receiptPop">
									<input type="hidden" name="reserNo" value="${reserDto.no}">
								</form>
							</div>
						</div>
					</div>
					
					<!-- 공동 게스트 -->
					<div class="guest-wrap">
						<div class="guest-title">
							<label>게스트 (최대 ${roomDto.max_per}명)</label>
						</div>
						
						<hr>
						
						<div class="guest">
							<span id="joinNum">${joinGuestNum}명</span>
							
							<!-- hidden -->
							<input type="hidden" name="joinNum" value="${joinGuestNum}">
							
							<div class="guest-btn">
								<c:if test="${roomDto.max_per > joinGuestNum}">
									<c:if test="${preCheck == false and canCheck == false}">
										<span class="bi bi-plus-circle" onclick="addGuest(this)" style="margin-right: 20%"
										no="${reserDto.no}" hostId="${hostDto.id}" myid="${sessionScope.myid}"
										maxPer="${roomDto.max_per}" id="addGuest"></span>
									</c:if>
								</c:if>
								
								<div onclick="guestInfo(${reserDto.no}, ${roomDto.max_per})" data-toggle="modal" data-target="#guestList">
									<span class="bi bi-three-dots"></span>
								</div>
							</div>
						</div>
						
						<!-- 게스트리스트 모달 -->
						<div id="guestList" class="modal">
							<div class="modal-dialog modal-dialog-centered">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">게스트 상세 목록</h4>
									</div>
									
									<div class="modal-body">
										<div class="main-guest-wrap">
											<div class="main-guest-img">
												<c:if test="${not fn:contains(guestDto.id, '@')}">
													<img id="main-img" src="${root}/photo/memberPhoto/${guestDto.photo}">
												</c:if>
												
												<c:if test="${fn:contains(guestDto.id, '@')}">
													<img id="main-img" src="${guestDto.photo}">
												</c:if>
											</div>
											
											<label>${guestDto.id}</label>
											
											<button type="button" class="btn btn-default" onclick="location.href='../chat'">메인 게스트</button>
										</div>
										
										<div class="join-guest-wrap" id="${join.memDto.id}">
										</div>
										
										<c:forEach var="join" items="${joinList}">
											<div class="join-guest-wrap" id="${join.memDto.id}">
												<hr>
												
												<div class="join-guest-de">
													<div class="join-guest-img">
														<c:if test="${not fn:contains(join.memDto.id, '@')}">
															<img src="${root}/photo/memberPhoto/${join.memDto.photo}">
														</c:if>
														
														<c:if test="${fn:contains(join.memDto.id, '@')}">
															<img src="${join.memDto.photo}">
														</c:if>
													</div>
													
													<label>${join.memDto.id}</label>
												</div>
											</div>
										</c:forEach>
									</div>
									
									<div class="modal-footer">
										<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<hr>
			
			<div class="guest-comment-wrap">
				<div class="guest-comment-main">
					<!-- 게스트 후기 -->
					<c:if test="${gcommentDto == null and preCheck == true and canCheck == false}">
						<div class="empty">등록된 후기가 없습니다.</div>
					</c:if>
					
					<c:if test="${gcommentDto != null and preCheck == true and canCheck == false}">
						<div class="comment-title">
							<div class="guest-photo">
								<c:if test="${not fn:contains(guestDto.id, '@')}">
									<img src="${root}/photo/memberPhoto/${guestDto.photo}"
									onclick="location.href='/profile/profileform?id=${guestDto.id}'">
								</c:if>
								
								<c:if test="${fn:contains(guestDto.id, '@')}">
									<img src="${guestDto.photo}" onclick="location.href='/profile/profileform?id=${guestDto.id}'">
								</c:if>
							</div>
						
							<div class="comment-detail-wrap">
								<div class="guest-id">
									<span>${guestDto.id}</span>
								</div>
							
								<div class="rating">
									<div class="rate-part">
										<input type="radio" name="rate-u" id="star-1-u" value="${gcommentDto.rating}"
										 ${gcommentDto.rating == '1.0' ? 'checked="checked"' : ''} onclick="return(false);">
									    <input type="radio" name="rate-u" id="star-2-u" value="${gcommentDto.rating}"
									     ${gcommentDto.rating == '2.0' ? 'checked="checked"' : ''} onclick="return(false);">
									    <input type="radio" name="rate-u" id="star-3-u" value="${gcommentDto.rating}"
									     ${gcommentDto.rating == '3.0' ? 'checked="checked"' : ''} onclick="return(false);">
									    <input type="radio" name="rate-u" id="star-4-u" value="${gcommentDto.rating}"
									     ${gcommentDto.rating == '4.0' ? 'checked="checked"' : ''} onclick="return(false);">
									    <input type="radio" name="rate-u" id="star-5-u" value="${gcommentDto.rating}"
									     ${gcommentDto.rating == '5.0' ? 'checked="checked"' : ''} onclick="return(false);">
									    
									    <div class="content">
									        <div class="stars">
									            <label for="star-1-u" class="star-1 fas fa-star"></label>
									            <label for="star-2-u" class="star-2 fas fa-star"></label>
									            <label for="star-3-u" class="star-3 fas fa-star"></label>
									            <label for="star-4-u" class="star-4 fas fa-star"></label>
									            <label for="star-5-u" class="star-5 fas fa-star"></label>
									        </div>
									    </div>
									    
									    <!-- hidden -->
								    	<input type="hidden" name="reserNo" id="reserNo" value="${reserDto.no}">
								    	
									    <fmt:parseNumber var="star" value="${gcommentDto.rating}" integerOnly="true" />
									    
									    <span class="numa" id="starNum">${star}</span>
									    <span class="numa" style="margin-left: 0;">점</span>
									</div>
									
									<div class="date-part">
								    	<fmt:formatDate var="writeDay" value="${gcommentDto.write_day}" pattern="yyyy년 MM월 dd일"/>
								    	<span class="date">작성일 | ${writeDay}</span>
								    </div>
								</div>
							</div>
						</div>
						
						<div class="comment-content">
							<textarea class="content-input" readonly="readonly">${gcommentDto.content}</textarea>
						</div>
						
						<!-- 게스트 후기 댓글 -->
						<!-- hidden -->
						<input type="hidden" name="guestId" value="${guestDto.id}">
					</c:if>
				</div>
			</div>
			
			<c:if test="${canCheck == true}">
				<!-- 취소 버튼 -->
				<div class="can-wrap">
					<c:if test="${canReserDto.refund_check == 'ing'}">
						<button class="btn btn-secondary can-btn" id="can-reser" no="${reserDto.no}" onclick="reserRef(this)">예약 취소가 진행 중입니다.</button>
					</c:if>
					
					<c:if test="${canReserDto.refund_check == 'end'}">
						<button class="btn btn-secondary can-btn" id="can-reser" style="pointer-events: none;">결제 환불이 진행 중입니다.</button>
					</c:if>
					
					<c:if test="${canReserDto.refund_check == 'can'}">
						<button class="btn btn-warning can-btn" id="can-reser" style="pointer-events: none;">예약 취소가 완료되었습니다.</button>
					</c:if>
				</div>
			</c:if>
		</div>
	</div>
			
	
	<!-- js -->
	<script src="${root}/js/hostReservationDetail.js"></script>
</body>
</html>