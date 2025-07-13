// '추가 등록' 버튼을 눌렀을 때 리스트에 등록되고 등록된 지점으로 페이지 이동
// 정보를 수정할 수 있도록 정보가 input 안에 표시됨 & 이미지 테두리선 색깔이 생김 
// & '수정', '삭제' 버튼이 '수정사항 저장'으로 바뀜
// 수정사항 저장 시 유효성 검사
// 유효성 검사 통과시: '수정되었습니다' 라는 메시지 창이 뜨고, '확인'을 누르면 메시지 창 사라짐

// TODO 수정, 삭제 기능 먼저 구현 후 등록 기능 구현하기

/////////////////////////////// 수정 /////////////////////////////// 

// input의 disabled 속성 제거 함수
function enableInputs(inputs) {
    inputs.forEach(input => input.removeAttribute('disabled'));
}

// input에 disabled 속성 추가 함수
function disableInputs (inputs) {
    inputs.forEach(input => input.setAttribute('disabled', true));
}

// 이미지 클릭 시 이미지 파일을 넣는 input을 클릭하는 함수
function imageClick(img, fileInput) {
    const handler = () => fileInput.click();
    img.addEventListener('click', handler);
    return handler; // 제거할 수 있도록 반환
}

// 수정 버튼 클릭 시 실행되는 함수
function editPetEvent(petLi) {
    // 1. 반려견 요소들을 가져옴
    const petDetailInputs = petLi.querySelectorAll('.pet-detail input');
    const petBtn = petLi.querySelector('.pet-btn');
    const petImg = petLi.querySelector('.pet-img');
    const petImgInput = petLi.querySelector('.pet-img-input');
    
    // 2. input 요소들의 disabled 속성 제거
    enableInputs(petDetailInputs);
    
    // 3. 버튼 바꾸기
    const oriPetBtnHtml = petBtn.innerHTML;
    const btnSaveHtml = '<button class="pet-btn-save">수정 완료</button>';
    petBtn.innerHTML = btnSaveHtml;

    // TODO 반려견 이미지 삭제 기능 추가

    // 4. 반려견 이미지 img 클릭 시 input:file의 클릭 이벤트(파일 선택창 열기)를 발생시킴
    const imgClickEvent = imageClick(petImg, petImgInput);

    // 5. 파일을 선택하면 이미지 프리뷰를 반려견 이미지 img에 띄움
    petImgInput.addEventListener('change', function () {
        const file = this.files[0];
        
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                petImg.src = e.target.result; // 미리보기
            };
            reader.readAsDataURL(file); // reader.onload 실행
        }
    });

    // 6. save 버튼 누를 시 ajax로 수정 요청 보내고 응답받아 input 안의 value 수정 &
    // 버튼 되돌리고 input disabled로 전환
    const saveBtn = petBtn.querySelector('.pet-btn-save');
    saveBtn.addEventListener('click', function (btn) {
        // 1) ajax로 요청 보내고 응답 받아 value 수정
        // (1) 이미지 파일도 가져와야 하므로 input 안의 value값을 가져와서 FormData에 바인딩
        const petName = petLi.querySelector('.pet-name').value;
        const petAge = petLi.querySelector('.pet-age').value;
        const petGender = petLi.querySelector('.pet-gender').value;
        const petBreed = petLi.querySelector('.pet-breed').value;
        const petNo = petLi.querySelector('.pet-no').value;
        const accountNo = petLi.querySelector('.account-no').value;
        
        const formData = new FormData();
        formData.append("petName", petName);
        formData.append("petAge", petAge);
        formData.append("petGender", petGender);
        formData.append("petBreed", petBreed);
        formData.append("petNo", petNo);
        formData.append("accountNo", accountNo);
        formData.append("petImg", petImgInput.files[0]);

        // TODO 정보, 사진 유효성 검사 추가하기

        // (2) ajax
        $.ajax({
            url: '/myPet/update',
            type: 'post',
            data: formData,
            processData: false, //  jQuery가 데이터를 문자열로 변환하지 않게 함
            contentType: false, // multipart/form-data 헤더를 브라우저가 자동으로 넣게 함
            dataType: 'json',
            success: function (data) {
                console.log('응답:', data);
            },
            error: function (err) {
                console.log('에러:', err);
            }
        });
        
        // 1) 버튼 복원
        petBtn.innerHTML = '';
        petBtn.innerHTML = oriPetBtnHtml;
        
        // 2) input disabled로 전환
        disableInputs(petDetailInputs);

        // 3) 수정 버튼 클릭 시 이벤트 다시 달기 (재귀적으로 호출)
        const newEditBtn = petBtn.querySelector('.pet-btn-up');
        newEditBtn.addEventListener('click', () => {
		    editPetEvent(petLi);
		});
		
		// 4) 삭제 버튼 클릭 시 이벤트 다시 달기
		const newDelBtn = petBtn.querySelector('.pet-btn-del');
		newDelBtn.addEventListener('click', () => {
		    const petLi = newDelBtn.closest('li');
		    showDeleteModal(petLi);
		});
        
        // 5) 이미지 클릭 시의 이벤트리스너 제거
        petImg.removeEventListener('click', imgClickEvent);
    });            
}

// 처음 로딩 시 수정 버튼들에 이벤트 연결
document.querySelectorAll('.pet-btn-up').forEach(btn => {
    btn.addEventListener('click', () => {
        const petLi = btn.closest('li'); // 해당 반려견 DOM 카드 요소 추출
        editPetEvent(petLi); // 수정 기능 바인딩
    });
});

/////////////////////////////// 삭제 /////////////////////////////// 

// 삭제 모달을 보여주는 함수
function showDeleteModal(petLi) {
	const petNo = petLi.querySelector('.pet-no').value;
	const confirmBtn = document.querySelector('#delete-confirm-btn');

	// petNo를 data 속성에 저장해 둠
	confirmBtn.setAttribute('data-pet-no', petNo);
	document.querySelector('#delete-input').value = ''; // 입력창 초기화
	document.querySelector('#delete-modal-box').style.display = 'flex';
}

// 삭제 모달을 숨기는 함수
function closeDeleteModal() {
	document.querySelector('#delete-modal-box').style.display = 'none';
}

// TODO 삭제 버튼 클릭 시 이벤트
function deletePetEvent() {
	const petNo = document.querySelector('#delete-confirm-btn').getAttribute('data-pet-no');
	const val = document.querySelector('#delete-input').value;
	
	if (val === '삭제') {
		// 삭제 로직 실행
		$.ajax({
			url: '/myPet/delete',
			type: 'post',
			data: {
				petNo: petNo
			},
			dataType: 'json',
			success: function (data) {
				alert('삭제되었습니다.');
				closeDeleteModal();
				
			    console.log('응답:', data);
				
				// 페이지 새로고침으로 최신 데이터 가져오기
				location.reload();
			},
			error: function (err) {
			    console.log('에러:', err);
			}
		});
	} else {
		alert("'삭제'를 입력해주세요.");
	}
}

// 처음 로딩 시 삭제 버튼들에 이벤트 연결
document.querySelectorAll('.pet-btn-del').forEach(btn => {
    btn.addEventListener('click', () => {
        const petLi = btn.closest('li');
        showDeleteModal(petLi);
    });
});

// 모달 내부 확인, 취소 버튼에 이벤트 연결
document.querySelector('#delete-confirm-btn').addEventListener('click', deletePetEvent);
document.querySelector('#delete-close-btn').addEventListener('click', closeDeleteModal);

/////////////////////////////// 등록 /////////////////////////////// 
// 추가 등록 버튼 클릭 시 input form 생성
document.querySelector('#add-pet-btn').addEventListener('click', () => {
    const petList = document.querySelector('#pet-list');
    const newLi = document.createElement('li');

    newLi.innerHTML = `
        <input type="file" class="pet-img-input" name="petImg" style="display: none;">
        <img src="/static/images/default-pet.png" class="pet-img" alt="반려견 이미지">
        <div class="pet-detail">
            <input type="text" class="pet-name" placeholder="이름">
            <div>
                <input type="text" class="pet-age" placeholder="나이">
                <p>살 / <p>
                <input type="text" class="pet-gender" placeholder="성별">
            </div>
            <input type="text" class="pet-breed" placeholder="견종">
            <input type="hidden" class="account-no" value="${document.querySelector('.account-no')?.value || ''}">
        </div>
        <div class="pet-btn">
            <button class="pet-btn-up">등록</button>
            <button class="pet-btn-del">삭제</button>
        </div>
        <hr>
    `;

    petList.appendChild(newLi);
    newLi.scrollIntoView({ behavior: 'smooth', block: 'center' });

    // 등록 버튼에 insert 기능 연결
    newLi.querySelector('.pet-btn-up').addEventListener('click', () => {
        const petName = newLi.querySelector('.pet-name').value;
        const petAge = newLi.querySelector('.pet-age').value;
        const petGender = newLi.querySelector('.pet-gender').value;
        const petBreed = newLi.querySelector('.pet-breed').value;
        const accountNo = newLi.querySelector('.account-no').value;
        const petImgInput = newLi.querySelector('.pet-img-input');

        const formData = new FormData();
        formData.append('petName', petName);
        formData.append('petAge', petAge);
        formData.append('petGender', petGender);
        formData.append('petBreed', petBreed);
        formData.append('accountNo', accountNo);
        formData.append('petImg', petImgInput.files[0]);

        $.ajax({
            url: '/myPet/insert',
            type: 'post',
            data: formData,
            processData: false,
            contentType: false,
            dataType: 'json',
            success: function () {
                alert('등록되었습니다.');
                location.href = '/myPet/list';
            },
            error: function (err) {
                console.log('에러:', err);
                alert('등록 실패');
            }
        });
    });

    // 삭제 버튼 기능
    newLi.querySelector('.pet-btn-del').addEventListener('click', () => {
        newLi.remove();
    });

    // 이미지 업로드 미리보기 연결
    const petImg = newLi.querySelector('.pet-img');
    const petImgInput = newLi.querySelector('.pet-img-input');
    petImg.addEventListener('click', () => petImgInput.click());

    petImgInput.addEventListener('change', function () {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = e => petImg.src = e.target.result;
            reader.readAsDataURL(file);
        }
    });
});

