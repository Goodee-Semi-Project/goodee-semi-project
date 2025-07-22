// TODO 차수 관련 기능 추가
const calendarEl = document.querySelector('#calendar');

// 선택된 날짜 저장 변수
let selectedDate = null;

// DB에서 받아온 일정 데이터들을 담는 변수 (fullcalendar의 임시 데이터 저장소)
let eventDatas = [];

const calendar = new FullCalendar.Calendar(calendarEl, {
	timeZone: 'Asia/Seoul', // 기준시간 설정
	headerToolbar: {
		left: 'prev,next today',
		center: 'title',
		right: 'dayGridMonth,timeGridWeek,timeGridDay'
	},
	locale: 'ko', // 언어 설정
	navLinks: true, // 요일과 날짜 클릭 시 일이나 주단위로 보여주는 화면으로 넘어감
 	editable: true, // 드래그해서 수정 가능한지
	selectable: true,
	selectMirror: true,
	dayMaxEvents: false, // +more 표시 전 최대 이벤트 갯수, default: false | true: 셀 높이에 의해 결정, false: 일정만큼 셀 높이 확장
	
    // 이벤트 데이터 로드
    events: function(fetchInfo, successCallback, failureCallback) {
		// 함수 형식으로 events 옵션을 넘기면 FullCalendar가 내부적으로 세 개의 인자를 자동으로 넘겨줌
		// fetchInfo: FullCalendar가 지금 보고 있는 달력의 날짜 범위
		// successCallback(eventsArray): 이 콜백 함수에 이벤트 배열을 넘겨주면, 달력에 그 일정들이 표시됨
		// failureCallback(): 만약 서버에서 일정 데이터를 가져오는 데 실패했을 경우 호출하면 FullCalendar가 에러 처리 (예: 메시지 표시)
		console.log(fetchInfo);
		console.log(successCallback);
		console.log(failureCallback);
		
		$.ajax({
            url: '/schedule/list',
            type: 'post',
            data: {
                start: fetchInfo.startStr,
                end: fetchInfo.endStr
            },
            dataType: 'json',
            success: function (data) {
				console.log("성공: ", data);
				eventDatas = data;
				successCallback(data);
            },
            error: function (err) {
				console.log("에러: ", err);
            }
		});
		
		console.log('이벤트 데이터 로드 완료');
    },

    // 날짜 선택 시 새 이벤트 생성
    select: function(selectionInfo) {
        console.log("[날짜 선택] 받아온 정보: ", selectionInfo);
		selectedDate = selectionInfo.startStr.split('T')[0]; // 선택된 날짜 저장 (ex. 0000-00-00)
        showEventModal('create', selectionInfo);
    },

    // 이벤트 클릭 시 수정/삭제
    eventClick: function(clickInfo) {
		selectedDate = clickInfo.event.startStr.split('T')[0]; // 이벤트 날짜 저장
        showEventModal('edit', clickInfo);
    },
	
	// 마우스 위치에 툴팁 표시
	eventDidMount: function(info) {
	    // 기존 시간 표시 요소 삭제
	    const oriTimeDiv = document.querySelector('.fc-event-time');
	    if (oriTimeDiv) {
	        oriTimeDiv.remove();
	    }
	    
	    let tooltipText = '';
	    let displayText = '';
	    
	    // 시간 정보 생성 (timezone 고려)
	    if (info.event.start && !info.event.allDay) {
	        // 한국 시간으로 변환
	        const startTime = new Date(info.event.startStr).toLocaleTimeString('ko-KR', {
	            hour: '2-digit',
	            minute: '2-digit',
	            hour12: false,
	            timeZone: 'Asia/Seoul'
	        });
	        
	        if (info.event.end) {
	            const endTime = new Date(info.event.endStr).toLocaleTimeString('ko-KR', {
	                hour: '2-digit',
	                minute: '2-digit',
	                hour12: false,
	                timeZone: 'Asia/Seoul'
	            });
	            displayText = `${startTime} - ${endTime}`;
	        } else {
	            displayText = startTime;
	        }
	    }
	    
	    // 캘린더 표시용 HTML 생성
	    const eventTitle = info.event.title;
	    let htmlContent = '';
	    
	    if (displayText) {
	        // 교육과정명과 회원명-반려견명을 분리
	        const titleMatch = eventTitle.match(/\(([^)]+)\)\s*(.+)/);
	        if (titleMatch) {
	            const courseTitle = titleMatch[1];  // 교육과정명
	            const memberInfo = titleMatch[2];   // 회원명-반려견명
	            
	            htmlContent = `
	                <div style="font-size: 11px; color: #666; line-height: 1.2;">${displayText}</div>
	                <div style="font-size: 12px; line-height: 1.2; margin-bottom: 2px;">${courseTitle}</div>
	                <div style="font-size: 11px; line-height: 1.2; color: #555;">${memberInfo}</div>
	            `;
	            tooltipText = displayText + '\n' + courseTitle + '\n' + memberInfo;
	        } else {
	            htmlContent = `
	                <div style="font-size: 11px; color: #666; line-height: 1.2;">${displayText}</div>
	                <div style="font-size: 12px; line-height: 1.2;">${eventTitle}</div>
	            `;
	            tooltipText = displayText + '\n' + eventTitle;
	        }
	    } else {
	        htmlContent = `<div style="font-size: 12px;">${eventTitle}</div>`;
	        tooltipText = eventTitle;
	    }
	    
	    // 기존 title 속성 제거 (중복 방지)
	    info.el.removeAttribute('title');
	    
	    // 이벤트 요소의 내용 수정
	    const titleElement = info.el.querySelector('.fc-event-title');
	    if (titleElement) {
	        titleElement.innerHTML = htmlContent;
	    }
	    
	    // 전체 이벤트 요소의 내용을 직접 수정 (더 확실한 방법)
	    const eventMain = info.el.querySelector('.fc-event-main');
	    if (eventMain) {
	        eventMain.innerHTML = htmlContent;
	    }
	    
	    // 새로운 툴팁용 title 속성 추가
	    info.el.setAttribute('title', tooltipText);
	}
});

// 모달 표시 함수
function showEventModal(mode, info) {
	// 1. 모달의 요소 가져오기
	const modal = document.querySelector('#event-modal-box');
	const modalTitle = document.querySelector('#modal-title');
	const form = document.querySelector('#modal-form');
	const deleteBtn = document.querySelector('#btn-delete-event');
    
	// 2. 폼 초기화
	form.reset(); // reset(): 요소의 기본값 복원
	form.querySelector('#sched-step').innerHTML = '<option value="" disabled selected>차시 선택</option>';
	form.querySelector('#account-name').disabled = true;
	form.querySelector('#pet-name').disabled = true;

	// 3. 일정 등록 / 수정
	switch (mode) {
		case 'create': // 일정 등록
			modalTitle.textContent = '일정 등록';
			deleteBtn.style.display = 'none';
			modal.removeAttribute('data-event-id');
			break;

		case 'edit': // 일정 수정
			modalTitle.textContent = '일정 수정';
			deleteBtn.style.display = 'inline-block';
			
			// 기존의 일정 정보 가져옴
			console.log("[일정 정보] info: ", info);
			console.log("[일정 정보] info.event: ", info.event);
			const event = info.event;
			
			// 기존의 일정에 담긴 데이터를 표시
			document.querySelector('#course-title').value = event.extendedProps.courseTitle;
			document.querySelector('#account-name').value = event.extendedProps.accountName;
			document.querySelector('#pet-name').value = event.extendedProps.petName;
			document.querySelector('#sched-step').value = event.extendedProps.schedStep;
			document.querySelector('#start').value = event.startStr? event.startStr.split('T')[1] : "";
			document.querySelector('#end').value = event.endStr? event.endStr.split('T')[1] : "";

			// 현재 편집 중인 이벤트 ID 저장
			modal.setAttribute('data-event-id', event.id);
	}
	
	modal.style.display = 'flex';
}

// 날짜 + 시간 합치기 함수
function buildDateTime(date, timeStr) {
    const [h, m] = timeStr.split(':').map(String);
    return date + 'T' + h + ':' + m;
}

// 이벤트 생성
function createEvent(eventData) { // eventData: 모달 form에서 받아온 데이터
	// 1. 데이터를 서버로 전송
	$.ajax({
        url: '/schedule/create',
        type: 'post',
        data: {
            accountNo: eventData.accountNo,
            courseNo: eventData.courseNo,
            schedStep: eventData.schedStep,
            petNo: eventData.petNo,
            start: eventData.start,
            end: eventData.end,
        },
        dataType: 'json',
        success: function (data) {
            console.log("성공: ", data);

			// 2. fullcalendar의 임시데이터 저장소에 추가
			eventDatas.push(data);

			// 3. 추가된 이벤트를 캘린더에 반영
			calendar.addEvent(data);
        },
        error: function (err) {
            console.log("에러: ", err);
        }
    });
}

// 이벤트 수정
function updateEvent(eventId, eventData) {
	$.ajax({
	    url: '/schedule/update',
	    type: 'post',
	    data: {
	        schedNo: eventId,
	        courseNo: eventData.courseNo,			
	        petNo: eventData.petNo,
			schedStep: eventData.schedStep,
			
	        schedDate: eventData.schedDate,
	        schedStart: eventData.start,
	        schedEnd: eventData.end,
	    },
		dataType: 'json',
	    success: function(data) {
			console.log("성공: ", data);
			
            location.reload();
	    },
	    error: function(err) {
	        console.log("에러: ", err);
	    }
	});
}

// 이벤트 삭제
function deleteEvent(eventId) {
	$.ajax({
		    url: '/schedule/delete',
		    type: 'post',
		    data: {
		        schedNo: eventId,
		    },
			dataType: 'json',
		    success: function(data) {
				console.log("성공: ", data);
				
				const event = calendar.getEventById(eventId);
			    if (event) {
			        event.remove();
			        
			        // fullcalendar의 임시 데이터 저장소에서 삭제
			        const dataIndex = eventDatas.findIndex(e => e.id === eventId);
			        if (dataIndex !== -1) {
			            eventDatas.splice(dataIndex, 1);
			        }
			    }
		    },
		    error: function(err) {
		        console.log("에러: ", err);
		    }
		});
	
}

// 교육과정, 회원, 반려견, 차시 input 검증
const courseSelect = document.getElementById('course-title'); // 기준 select
const accountSelect = document.getElementById('account-name');
const petSelect = document.getElementById('pet-name');
const schedStepSelect = document.getElementById('sched-step');

let courseNo;
let accountNo;
let petNo;

courseSelect.addEventListener('change', function() {
	petSelect.disabled = true;
	
	console.log("선택된 courseNo: " + this.value);
	
	if (this.value) { // 기준 select에 값이 선택되었는지 확인
        accountSelect.disabled = false;
		
		// 비동기통신하여 option에 데이터 뿌리기
		$.ajax({
			url: '/schedule/input',
			type: 'get',
			data: {
				valueType: "courseNo",
				courseNo: this.value
			},
			dataType: 'json',
			success: function (data) {
			    console.log("성공: ", data);
				
				let html = '<option value="" disabled selected>회원명 선택</option>';
				data.list.forEach(json => {
                    html += `<option value="${json.account_no}">${json.account_name}</option>`;
                });
				
				accountSelect.innerHTML = html;
			},
			error: function (err) {
			    console.log("에러: ", err);
			}
		});
    } else {
        accountSelect.disabled = true;
        accountSelect.value = ''; // 값 초기화
    }
});

accountSelect.addEventListener('change', function() {
	console.log("선택된 accountNo: " + this.value);
	
	if (this.value) { // 기준 select에 값이 선택되었는지 확인
        petSelect.disabled = false;
		
		// 비동기통신하여 option에 데이터 뿌리기
		$.ajax({
			url: '/schedule/input',
			type: 'get',
			data: {
				valueType: "accountNo",
				courseNo: courseSelect.value,
				accountNo: this.value
			},
			dataType: 'json',
			success: function (data) {
			    console.log("성공: ", data);
		        
		        let html = '<option value="" disabled selected>반려견명 선택</option>';
				data.list.forEach(json => {
		            html += `<option value="${json.pet_no}">${json.pet_name}</option>`;
		        });
				
				petSelect.innerHTML = html;
			},
			error: function (err) {
			    console.log("에러: ", err);
			}
		});
    } else {
        petSelect.disabled = true;
        petSelect.value = ''; // 값 초기화
    }
});

petSelect.addEventListener('change', function() {
	console.log("petNo: " + this.value);
	
	if (this.value) { // 기준 select에 값이 선택되었는지 확인
		schedStepSelect.disabled = false;

		// 비동기통신하여 option에 데이터 뿌리기
		$.ajax({
			url: '/schedule/input',
			type: 'get',
			data: {
				valueType: "petNo",
				courseNo: courseSelect.value,
				petNo: this.value
			},
			dataType: 'json',
			success: function (data) {
				console.log("성공: ", data);

				let html = '<option value="" disabled selected>차시 선택</option>'
				html += `<option value="${data.schedStep}" selected>${data.schedStep}</option>`;
				
				schedStepSelect.innerHTML = html;
			},
			error: function (err) {
			    console.log("에러: ", err);
			}
		});
    } else {
        petSelect.disabled = true;
        petSelect.value = ''; // 값 초기화
    }
});
// 모달 이벤트 리스너
$(document).on('click', '#btn-cancel-event', function() {
    document.getElementById('event-modal-box').style.display = 'none';
});

$(document).on('click', '#btn-add-event', function() {
	const form = document.getElementById('modal-form');
	const formData = new FormData(form);
	console.log('[저장 클릭] formData: ');
	for (const x of formData.entries()) {
		console.log(x);
	};
	
	const modal = document.getElementById('event-modal-box');
	const eventId = modal.getAttribute('data-event-id');
	console.log('eventId: ', eventId);
	
	// value 값 가져오기
	const courseValue = formData.get('courseTitle');
	const accountValue = formData.get('accountName');
	const petValue = formData.get('petName');
	const schedStepValue = formData.get('schedStep');
	
	// text 값 가져오기
	const courseText = $('#course-title option:selected').text();
	const accountText = $('#account-name option:selected').text();
	const petText = $('#pet-name option:selected').text();

	console.log('선택된 값들:');
	console.log('코스 - value:', courseValue, 'text:', courseText);
	console.log('회원 - value:', accountValue, 'text:', accountText);
	console.log('펫 - value:', petValue, 'text:', petText);
	console.log('차수 - value:', schedStepValue);
	
    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }
    
	// 시간 검증
    const startTime = formData.get('start');
    const endTime = formData.get('end');
    
    if (!startTime || !endTime) {
        alert('시작 시간과 종료 시간을 입력해주세요.');
        return;
    }
    
    if (startTime >= endTime) {
        alert('종료 시간은 시작 시간보다 늦어야 합니다.');
        return;
    }
	
	const eventData = {
		accountNo: accountValue,
		accountName: accountText,
		
		petNo: petValue,
		petName: petText,

		classNo: null,

		schedStep: schedStepValue,
		schedDate: selectedDate,
		schedAttend: null,
		courseNo: courseValue,
		courseTitle: courseText,
		courseTotalStep: null,

		id: null,

		start: buildDateTime(selectedDate, startTime),
		end: buildDateTime(selectedDate, endTime),

		title: `(${courseText}) ${accountText}-${petText} ${schedStepValue}차시`
	};
    
	console.log('eventData 받아오기 완료: ', eventData);
	
    if (eventId) {
        // 수정
		console.log('updateEvent() 실행 시작');
        updateEvent(eventId, eventData);
    } else {
        // 생성
		console.log('createEvent() 실행 시작');
        createEvent(eventData);
    }
    
    modal.style.display = 'none';
    calendar.unselect();
});

$(document).on('click', '#btn-delete-event', function() {
    const modal = document.getElementById('event-modal-box');
    const eventId = modal.getAttribute('data-event-id');
    
    if (eventId && confirm('이 일정을 삭제하시겠습니까?')) {
        deleteEvent(eventId);
        modal.style.display = 'none';
    }
});

// 모달 외부 클릭 시 닫기
$(document).on('click', '#event-modal-box', function(e) {
    if (e.target === this) {
        this.style.display = 'none';
    }
});

// 캘린더 렌더링
calendar.render();