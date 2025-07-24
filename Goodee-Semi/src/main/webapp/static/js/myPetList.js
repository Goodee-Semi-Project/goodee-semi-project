// '추가 등록' 버튼을 눌렀을 때 리스트에 등록되고 등록된 지점으로 페이지 이동
// 정보를 수정할 수 있도록 정보가 input 안에 표시됨 & 이미지 테두리선 색깔이 생김 
// & '수정', '삭제' 버튼이 '수정사항 저장'으로 바뀜
// 수정사항 저장 시 유효성 검사
// 유효성 검사 통과시: '수정되었습니다' 라는 메시지 창이 뜨고, '확인'을 누르면 메시지 창 사라짐

// TODO 반려견 이미지 등록하지 않을 시 기본 이미지 띄우기

//============================= 파일 업로드 검증 =============================
const petImgInputs = document.querySelectorAll('input[name="petImg"]');
petImgInputs.forEach(input => validatePetImgData(input));

function validatePetImgData(input) {
    // 1. input 안의 내용이 바뀔때마다 검증해야 함 => input[name="petImg"]에 change 이벤트리스너 추가
    input.addEventListener('change', () => {
        // 2. target 안의 file[0] 받아오기
        const file = input.files[0];

        // 3. 허용되지 않는 파일이 들어가있다면 target 안에 있는 value를 초기화
        const allowedTypes = ['image/png', 'image/jpeg'];

        console.log("[validatePetImgData] 업로드 된 파일 타입: ", file.type)
        console.log("[validatePetImgData] 업로드 된 파일 크기: ", file.type)
        
        if(!allowedTypes.includes(file.type)) {
            alert('PNG, JPG, JPEG 파일만 업로드 가능합니다.');
            input.value = '';

            return;
        }
        
        if(file.size > 5 * 1024 * 1024) { // 파일 크기를 5MB로 제한
            alert('파일 크기는 5MB 이하여야 합니다.');
            input.value = '';

            return;
        }

        console.log('파일 업로드 검증 통과');
    });
}

//============================= 공통 함수 =============================

// input의 disabled 속성 제거 함수
function enableInputs(inputs) {
    inputs.forEach(input => input.removeAttribute('disabled'));
}

// input에 disabled 속성 추가 함수
function disableInputs(inputs) {
    inputs.forEach(input => input.setAttribute('disabled', true));
}

// 이미지 클릭 시 이미지 파일을 넣는 input을 클릭하는 함수
function imageClick(img, fileInput) {
    const handler = () => fileInput.click();
    img.addEventListener('click', handler);
    return handler; // 제거할 수 있도록 반환
}

// 반려견 정보 유효성 검사 함수
function validatePetData(petName, petAge, petGender, petBreed) {
    if (!petName) {
        alert('반려견 이름을 입력해주세요.');
        return false;
    }
    if (!petAge) {
        alert('반려견 나이를 입력해주세요.');
        return false;
    }
    if (!petGender) {
        alert('성별을 선택해주세요.');
        return false;
    }
    if (!petBreed) {
        alert('견종을 입력해주세요.');
        return false;
    }
    return true;
}

// 서버 전송용 FormData 생성 함수 (파일 업로드 포함)
function createFormData(petName, petAge, petGender, petBreed, petNo, accountNo, petImgFile) {
    const formData = new FormData();
    formData.append("petName", petName);
    formData.append("petAge", petAge);
    formData.append("petGender", petGender);
    formData.append("petBreed", petBreed);
    if (petNo) formData.append("petNo", petNo); // 수정 시에만 petNo 포함
    formData.append("accountNo", accountNo);
    
    // 이미지 파일이 있고 유효한 경우에만 추가
    if (petImgFile && petImgFile.size > 0) {
        formData.append("petImg", petImgFile);
    }
    
    return formData;
}

// 이미지 파일 선택 시 미리보기 기능 설정 함수
function setupImagePreview(petImg, petImgInput) {
    petImgInput.addEventListener('change', function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                petImg.src = e.target.result; // 선택한 이미지를 img 태그에 표시
            };
            reader.readAsDataURL(file); // 파일을 데이터 URL로 읽기
        }
    });
}

//============================= 수정 기능 =============================

// 수정 버튼 클릭 시 실행되는 함수
function editPetEvent(petLi) {
    // 1. 반려견 요소들을 가져옴
    const petDetailInputs = petLi.querySelectorAll('.pet-detail input');
    const petBtn = petLi.querySelector('.pet-btn');
    const petImg = petLi.querySelector('.pet-img');
    const petImgInput = petLi.querySelector('.pet-img-input');
	const petGenderSelect = petLi.querySelector('.pet-gender');
	const petGender = petGenderSelect.value;
    
    // 2. input, select 요소들의 disabled 속성 제거
    enableInputs(petDetailInputs);

	// NiceSelect 업데이트 (jQuery 사용)
	$(petGenderSelect).attr('disabled', false);
	$(petGenderSelect).niceSelect('update');
	$(".pet-gender.nice-select").css('width', '60%');
    
    // 3. 버튼 바꾸기
    const oriPetBtnHtml = petBtn.innerHTML;
    const btnSaveHtml = '<button type="button" class="pet-btn-save btn btn-success" style="padding: 5px 10px;">적용</button>';
    petBtn.innerHTML = btnSaveHtml;

    // 4. 반려견 이미지 img 클릭 시 input:file의 클릭 이벤트(파일 선택창 열기)를 발생시킴
    const imgClickEvent = imageClick(petImg, petImgInput);

    // 5. 파일을 선택하면 이미지 프리뷰를 반려견 이미지 img에 띄움
    setupImagePreview(petImg, petImgInput);

    // 6. save 버튼 누를 시 ajax로 수정 요청 보내고 응답받아 input 안의 value 수정 &
    // 버튼 되돌리고 input disabled로 전환
    const saveBtn = petBtn.querySelector('.pet-btn-save');
    saveBtn.addEventListener('click', function(btn) {
        // 1) ajax로 요청 보내고 응답 받아 value 수정
        // (1) 이미지 파일도 가져와야 하므로 input 안의 value값을 가져와서 FormData에 바인딩
        const petName = petLi.querySelector('.pet-name').value.trim();
        const petAge = petLi.querySelector('.pet-age').value;
		const petGenderSelect = petLi.querySelector('.pet-gender');
		const petGender = petGenderSelect.value;
        const petBreed = petLi.querySelector('.pet-breed').value.trim();
        const petNo = petLi.querySelector('.pet-no').value;
        const accountNo = petLi.querySelector('.account-no').value;

        // 유효성 검사
        if (!validatePetData(petName, petAge, petGender, petBreed)) {
            return;
        }
        
        // 파일 유효성 검사 및 파일데이터 받아오기
		const selectedFile = petImgInput.files && petImgInput.files[0] ? petImgInput.files[0] : null;
		
        const formData = createFormData(petName, petAge, petGender, petBreed, petNo, accountNo, selectedFile);

        // (2) ajax
        $.ajax({
            url: '/myPet/update',
            type: 'post',
            data: formData,
            processData: false, //  jQuery가 데이터를 문자열로 변환하지 않게 함
            contentType: false, // multipart/form-data 헤더를 브라우저가 자동으로 넣게 함
            dataType: 'json',
            success: function(data) {
                console.log('응답:', data);
                alert('수정되었습니다.');
            },
            error: function(err) {
                console.log('에러:', err);
                alert('수정 실패');
            }
        });
        
        // 1) 버튼 복원
        petBtn.innerHTML = '';
        petBtn.innerHTML = oriPetBtnHtml;
        
        // 2) input, select 요소들을 disabled로 전환
        disableInputs(petDetailInputs);

		// NiceSelect 업데이트 (jQuery 사용)
		$(petGenderSelect).attr('disabled', true);
		$(petGenderSelect).niceSelect('update');
        
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
        
        // 5) 이미지 클릭 시의 이벤트리스너 제거 (수정 모드 종료)
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

//============================= 삭제 기능 =============================

// 삭제 모달을 보여주는 함수
function showDeleteModal(petLi) {
    const petNo = petLi.querySelector('.pet-no').value;
    const confirmBtn = document.querySelector('#delete-confirm-btn');

	// petNo를 data 속성에 저장해 둠
	confirmBtn.setAttribute('data-pet-no', petNo);
	document.querySelector('#delete-input').value = ''; // 입력창 초기화
	$('#delete-modal-box').modal("show");
}

// 삭제 확인 버튼 클릭 시 이벤트 ('삭제' 텍스트 입력 확인 후 실제 삭제)
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
				$('#delete-modal-box').modal("hide");
				
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

//============================= 등록 기능 =============================

// 새 반려견 정보 입력을 위한 HTML 생성 함수
function createNewPetItemHTML(accountNo) {
    return 	`
									<div class="container mb-3" style="display: flex; align-items: center; padding: 5px; border: 1px solid white; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.2);">
										<div class="col-3">
											<input type="file" class="pet-img-input" name="petImg" style="display: none;">
											<img width="150" height="150" src="/static/images/default-pet.png" class="pet-img" style="padding: 5px; margin-right: 10px; border: 1px solid #ced4da; object-fit: contain;" alt="반려견 이미지">						
										</div>
										<div class="pet-detail col-7" style="display: flex; align-items: center;">
											<div style="width: 60%; text-align: center;">
												<label>이름: </label>
												<input type="text" class="form-control pet-name mb-3" style="width: 80%; display: inline-block;" placeholder="이름">
												<br>
												<label>견종: </label>
												<input type="text" class="form-control pet-breed" style="width: 80%; display: inline-block;" placeholder="견종">							
											</div>
											
											<div style="width: 40%; margin-left: 20px; text-align: left;">
												<label>나이: </label>
												<input type="text" class="form-control pet-age mb-3" style="width: 60%; display: inline-block;" placeholder="나이">
												<br>
												<label>성별: </label>
												<select class="pet-gender" name="petGender" required>
													<option value="" selected>성별</option>
													<option value="M">남</option>
													<option value="F">여</option>
												</select>
											</div>
											<input type="hidden" class="account-no" value="${accountNo }">
										</div>
										<div class="pet-btn col-2" style="display: flex; flex-direction: column; justify-content: center; align-items: center;">
											<button class="pet-btn-up btn btn-success mb-3" style="padding: 5px 10px;">등록</button>
											<button class="pet-btn-del btn btn-outline-secondary" style="padding: 5px 10px;">취소</button>
										</div>
									</div>
    `;
}

// 새 반려견 등록 버튼 이벤트 설정 함수 (유효성 검사 + 서버 전송)
function setupNewPetRegisterEvent(newLi) {
    newLi.querySelector('.pet-btn-up').addEventListener('click', () => {
        const petName = newLi.querySelector('.pet-name').value.trim();
        const petAge = newLi.querySelector('.pet-age').value;
		const petGenderSelect = newLi.querySelector('.pet-gender');
		const petGender = petGenderSelect.value;
        const petBreed = newLi.querySelector('.pet-breed').value.trim();
        const accountNo = newLi.querySelector('.account-no').value;
        const petImgInput = newLi.querySelector('.pet-img-input');
        
        // 유효성 검사
        if (!validatePetData(petName, petAge, petGender, petBreed)) {
            return;
        }
        
        // 등록용 FormData 생성 (petNo는 null로 전달)
        const formData = createFormData(petName, petAge, petGender, petBreed, null, accountNo, petImgInput.files[0]);

        $.ajax({
            url: '/myPet/insert',
            type: 'post',
            data: formData,
            processData: false,
            contentType: false,
            dataType: 'json',
            success: function(data) {
                console.log('성공:', data);
                alert('등록되었습니다.');
                location.href = '/myPet/list'; // 등록 후 목록 페이지로 이동
            },
            error: function(err) {
                console.log('에러:', err);
                alert('등록 실패');
            }
        });
    });
}

// 새 반려견 삭제 버튼 이벤트 설정 함수 (DOM에서 제거)
function setupNewPetDeleteEvent(newLi) {
    newLi.querySelector('.pet-btn-del').addEventListener('click', () => {
        newLi.remove(); // 새로 추가된 아이템을 DOM에서 제거
    });
}

// 새 반려견 이미지 업로드 기능 설정 함수
function setupNewPetImageUpload(newLi) {
    const petImg = newLi.querySelector('.pet-img');
    const petImgInput = newLi.querySelector('.pet-img-input');
    
    // 이미지 클릭 시 파일 선택창 열기
    petImg.addEventListener('click', () => petImgInput.click());
    // 파일 선택 시 미리보기 표시
    setupImagePreview(petImg, petImgInput);
}

// 추가 등록 버튼 클릭 시 input form 생성
document.querySelector('#add-pet-btn').addEventListener('click', () => {
    const petList = document.querySelector('#pet-list');
    const newLi = document.createElement('li');
    const accountNo = document.querySelector('#add-pet-btn').getAttribute('data-account-no');
    
    console.log(accountNo);

    // 새 반려견 등록 폼 HTML 생성 및 추가
    newLi.innerHTML = createNewPetItemHTML(accountNo);
    petList.appendChild(newLi);
    newLi.scrollIntoView({ behavior: 'smooth', block: 'center' }); // 추가된 항목으로 스크롤
    
    const form = newLi.querySelector('form');
    
	// *** 중요: NiceSelect 초기화 ***
	const newSelect = newLi.querySelector('.pet-gender');
	$(newSelect).niceSelect();
	$(".pet-gender.nice-select").css('width', '60%');

	// 새로 추가된 항목에 이벤트 연결
	setupNewPetRegisterEvent(newLi);  // 등록 버튼 이벤트
	setupNewPetDeleteEvent(newLi);    // 삭제 버튼 이벤트
	setupNewPetImageUpload(newLi);    // 이미지 업로드 이벤트
});

// 성별 선택 창 크기 조절
$(".pet-gender.nice-select").css('width', '60%');