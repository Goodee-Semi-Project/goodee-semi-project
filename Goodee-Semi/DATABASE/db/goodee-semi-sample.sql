INSERT INTO authority (auth_no, auth_name) VALUES
(1, '훈련사'),
(2, '회원');

INSERT INTO attach_type VALUES
(1, '사용자'),
(2, '반려견'),
(3, '교육과정'),
(4, '사전학습'),
(5, '과제'),
(6, '제출물'),
(7, '후기'),
(8, '공지사항');

INSERT INTO account VALUES
(1, 2, 'admin1234', 'ffGLRdHRm2GUrvSDsMbTdvmjzJJfKpGarBSeMtEaFmUjPug1lC/poBs7AS+C2XYNS+FI416hCQhaP+SahuFTog==', '정유니', 'Y'),
(2, 1, 'tame9010', 'ffGLRdHRm2GUrvSDsMbTdvmjzJJfKpGarBSeMtEaFmUjPug1lC/poBs7AS+C2XYNS+FI416hCQhaP+SahuFTog==', '이몽룡', 'Y'),
(3, 1, 'pets3343', 'ffGLRdHRm2GUrvSDsMbTdvmjzJJfKpGarBSeMtEaFmUjPug1lC/poBs7AS+C2XYNS+FI416hCQhaP+SahuFTog==', '임꺽정', 'Y'),
(4, 2, 'blue1934', 'ffGLRdHRm2GUrvSDsMbTdvmjzJJfKpGarBSeMtEaFmUjPug1lC/poBs7AS+C2XYNS+FI416hCQhaP+SahuFTog==', '김민수', 'Y'),
(5, 2, 'tree8472', 'ffGLRdHRm2GUrvSDsMbTdvmjzJJfKpGarBSeMtEaFmUjPug1lC/poBs7AS+C2XYNS+FI416hCQhaP+SahuFTog==', '이서진', 'Y'),
(6, 2, 'cloud2931', 'ffGLRdHRm2GUrvSDsMbTdvmjzJJfKpGarBSeMtEaFmUjPug1lC/poBs7AS+C2XYNS+FI416hCQhaP+SahuFTog==', '박태우', 'Y'),
(7, 2, 'stone7645', 'ffGLRdHRm2GUrvSDsMbTdvmjzJJfKpGarBSeMtEaFmUjPug1lC/poBs7AS+C2XYNS+FI416hCQhaP+SahuFTog==', '최영민', 'Y'),
(8, 2, 'rain6273', 'ffGLRdHRm2GUrvSDsMbTdvmjzJJfKpGarBSeMtEaFmUjPug1lC/poBs7AS+C2XYNS+FI416hCQhaP+SahuFTog==', '정지훈', 'Y');
	
INSERT INTO account_info VALUES
(1, 1, '2025-07-11 16:44:09', 'M', '000101', '010-4444-3321', 'comasocean@gmail.com', '08591', '서울 금천구 가산디지털1로 16', 'KM타워'),
(2, 2, '2025-07-11 16:45:01', 'M', '900115', '010-5532-4455', 'dogking88@example.com', '17064', '경기 용인시 기흥구 신구로 6-1', '모모훈련소'),
(3, 3, '2025-07-11 16:45:04', 'M', '871018', '010-7777-8912', 'catqueen95@example.com', '17064', '경기 용인시 기흥구 신구로 6-1', '모모훈련소'),
(4, 4, '2025-07-11 16:45:07', 'M', '950218', '010-2384-6721', 'sunbeam42@example.com', '08500', '서울 금천구 가마산로 70', '민수분식'),
(5, 5, '2025-07-11 16:46:16', 'F', '020715', '010-9832-1475', 'windfox88@example.com', '12661', '경기 여주시 가남읍 가남로 9', '서진물류'),
(6, 6, '2025-07-11 16:47:17', 'M', '870403', '010-4729-0012', 'greentree5@example.com', '48755', '부산 동구 성남로 24', '태우건설'),
(7, 7, '2025-07-11 16:48:01', 'M', '991130', '010-5810-3902', 'moonlit22@example.com', '37947', '경북 포항시 남구 장기면 계원길 1', '하늘정원'),
(8, 8, '2025-07-11 16:49:32', 'M', '760512', '010-3321-4871', 'pebblestream@example.com', '25436', '강원특별자치도 강릉시 사천면 가마골길 10', '강릉맥주');

INSERT INTO course VALUES
(1, 2, '반려견 기초 훈련', '반려견 기초 훈련입니다.', '반려견 기초 훈련 테스트입니다.\n반려견 기초 훈련 테스트입니다.\n반려견 기초 훈련 테스트입니다.', 10, 10, 1),
(2, 2, '반려견 행동교정', '반려견 행동교정입니다.', '반려견 행동교정 테스트입니다.\n반려견 행동교정 테스트입니다.\n반려견 행동교정 테스트입니다.', 15, 7, 3),
(3, 3, '반려견 관리법', '반려견 관리법입니다.', '반려견 관리법 테스트입니다.\n반려견 관리법 테스트입니다.\n반려견 관리법 테스트입니다.', 7, 20, 5),
(4, 3, '반려견을 사랑하기', '반려견을 사랑합시다.', '반려견을 사랑하기 테스트입니다.\n반려견을 사랑하기 테스트입니다.\n반려견을 사랑하기 테스트입니다.', 5, 9, 7);

INSERT INTO pet VALUES
(1, 1, '유니', 'F', 4, '시바견'),
(2, 1, '칸나', 'F', 7, '비글'),
(3, 4, '시로', 'M', 2, '포메라니안'),
(4, 5, '나나', 'M', 3, '리트리버'),
(5, 6, '밥', 'M', 6, '닥스훈트'),
(6, 7, '이즈리얼', 'M', 5, '말티즈'),
(7, 8, '아메', 'F', 1, '사모예드');

INSERT INTO attachment VALUES
(1, 3, 1, 'pet_train1.jpg', '3efa98eda83644b681e55fb61eca473a.jpg'),
(2, 3, 1, 'pet_train2.jpg', 'be9f6e2d172d48748578cbf97a868a5b.jpg'),
(3, 3, 2, 'pet_teach1.jpg', 'a7e9e18900d24c17b3ee8fd128a34275.jpg'),
(4, 3, 2, 'pet_teach2.jpg', '2e37c4b8c4a24e10afead83341274640.jpg'),
(5, 3, 3, 'pet_condition1.jpg', '09eab68f9307486f83a0b7b5854ac962.jpg'),
(6, 3, 3, 'pet_condition2.jpg', 'f684843d23de4f0692690c40529429c0.jpg'),
(7, 3, 4, 'pet_love1.jpg', '32ae56880aa64adc9178f03531d74f83.jpg'),
(8, 3, 4, 'pet_love2.jpg', 'd3dca6385ed84ddf9d35e59ecf317e50.jpg'),
(9, 1, 1, 'profile1.jpg', '8ac72eef054f444f841c4e4f31632710.jpg'),
(10, 1, 2, 'profile2.jpg', '476268465eba45f18c52f77db388e801.jpg'),
(11, 1, 3, 'profile3.jpg', '87d193b83a744ff8a0b1fd4a2ca61ff7.jpg'),
(12, 1, 4, 'profile4.jpg', 'a9c6d5dc62ec4d5096c7be36a557e4ba.jpg'),
(13, 1, 5, 'profile5.jpg', '9f274c2859d64fd5b15a4e3015188c5e.jpg'),
(14, 1, 6, 'profile6.jpg', 'f0dda58476b742e7a810a5d83c81f4b3.jpg'),
(15, 1, 7, 'profile7.jpg', '4e6fd08234c241f6bcd36843b78c8441.jpg'),
(16, 1, 8, 'profile8.jpg', '0b52e7146faf400cba384fa0686310be.jpg'),
(17, 2, 1, 'pet-1-1.jpg', '4801f52fcfab48c8b16dcaa85e703186.jpg'),
(18, 2, 2, 'pet-1-2.jpg', 'dfca20573a8f46c891c68f9c35a010a2.jpg'),
(19, 2, 3, 'pet-4.jpg', '3f00fcc687564c63a49a789026a399e2.jpg'),
(20, 2, 4, 'pet-5.jpg', '7443a609c70d420287899546a1de9e6d.jpg'),
(21, 2, 5, 'pet-6.jpg', '3adb965971514f62995506c297b4a24b.jpg'),
(22, 2, 6, 'pet-7.jpg', '31739c62bd02455f81d6296b3acef18d.jpg'),
(23, 2, 7, 'pet-8.jpg', 'f937f8312f86445d92175d06668e3f81.jpg');