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

INSERT INTO account VALUES
(9, 2, 'rain6274', 'ffGLRdHRm2GUrvSDsMbTdvmjzJJfKpGarBSeMtEaFmUjPug1lC/poBs7AS+C2XYNS+FI416hCQhaP+SahuFTog==', '정지훈', 'Y'),
(10, 2, 'rain6275', 'ffGLRdHRm2GUrvSDsMbTdvmjzJJfKpGarBSeMtEaFmUjPug1lC/poBs7AS+C2XYNS+FI416hCQhaP+SahuFTog==', '정지훈', 'Y');
	
INSERT INTO account_info VALUES
(1, 1, '2025-07-11 16:44:09', 'M', '000101', '010-4444-3321', 'comasocean@gmail.com', '08591', '서울 금천구 가산디지털1로 16', 'KM타워'),
(2, 2, '2025-07-11 16:45:01', 'M', '900115', '010-5532-4455', 'dogking88@example.com', '17064', '경기 용인시 기흥구 신구로 6-1', '모모훈련소'),
(3, 3, '2025-07-11 16:45:04', 'M', '871018', '010-7777-8912', 'catqueen95@example.com', '17064', '경기 용인시 기흥구 신구로 6-1', '모모훈련소'),
(4, 4, '2025-07-11 16:45:07', 'M', '950218', '010-2384-6721', 'sunbeam42@example.com', '08500', '서울 금천구 가마산로 70', '민수분식'),
(5, 5, '2025-07-11 16:46:16', 'F', '020715', '010-9832-1475', 'windfox88@example.com', '12661', '경기 여주시 가남읍 가남로 9', '서진물류'),
(6, 6, '2025-07-11 16:47:17', 'M', '870403', '010-4729-0012', 'greentree5@example.com', '48755', '부산 동구 성남로 24', '태우건설'),
(7, 7, '2025-07-11 16:48:01', 'M', '991130', '010-5810-3902', 'moonlit22@example.com', '37947', '경북 포항시 남구 장기면 계원길 1', '하늘정원'),
(8, 8, '2025-07-11 16:49:32', 'M', '760512', '010-3321-4871', 'pebblestream@example.com', '25436', '강원특별자치도 강릉시 사천면 가마골길 10', '강릉맥주');

INSERT INTO account_info VALUES
(9, 9, '2025-07-11 16:44:09', 'M', '000101', '010-4444-3320', 'comasocean@gmail.com', '08591', '서울 금천구 가산디지털1로 16', 'KM타워'),
(10, 10, '2025-07-11 16:45:01', 'M', '900115', '010-5532-4451', 'dogking88@example.com', '17064', '경기 용인시 기흥구 신구로 6-1', '모모훈련소');


INSERT INTO pet (pet_no, account_no, pet_name, pet_gender, pet_age, pet_breed) VALUES
(1, 1, '멍멍이1', 'M', 3, '치와와'),
(2, 2, '멍멍이2', 'F', 5, '말티즈'),
(3, 3, '멍멍이3', 'M', 6, '푸들'),
(4, 4, '멍멍이4', 'F', 2, '포메라니안'),
(5, 5, '멍멍이5', 'M', 4, '시바견'),
(6, 6, '멍멍이6', 'F', 1, '치와와'),
(7, 7, '멍멍이7', 'M', 7, '말티즈'),
(8, 8, '멍멍이8', 'F', 3, '푸들'),
(9, 9, '멍멍이9', 'M', 5, '포메라니안'),
(10, 10, '멍멍이10', 'F', 2, '시바견');


INSERT INTO course (course_no, account_no, title, sub_title, object, total_step, capacity, thumb) VALUES
(1, 2, '기본훈련1', '초급과정1', '반려견의 사회성 향상과 기본 훈련을 목표로 합니다.', 3, 13, NULL),
(2, 4, '기본훈련2', '초급과정2', '반려견의 사회성 향상과 기본 훈련을 목표로 합니다.', 4, 9, NULL),
(3, 2, '기본훈련3', '초급과정3', '반려견의 사회성 향상과 기본 훈련을 목표로 합니다.', 7, 7, NULL),
(4, 10, '기본훈련4', '초급과정4', '반려견의 사회성 향상과 기본 훈련을 목표로 합니다.', 6, 6, NULL),
(5, 1, '기본훈련5', '초급과정5', '반려견의 사회성 향상과 기본 훈련을 목표로 합니다.', 3, 11, NULL),
(6, 4, '기본훈련6', '초급과정6', '반려견의 사회성 향상과 기본 훈련을 목표로 합니다.', 7, 5, NULL),
(7, 9, '기본훈련7', '초급과정7', '반려견의 사회성 향상과 기본 훈련을 목표로 합니다.', 4, 18, NULL),
(8, 4, '기본훈련8', '초급과정8', '반려견의 사회성 향상과 기본 훈련을 목표로 합니다.', 6, 13, NULL),
(9, 1, '기본훈련9', '초급과정9', '반려견의 사회성 향상과 기본 훈련을 목표로 합니다.', 4, 18, NULL),
(10, 6, '기본훈련10', '초급과정10', '반려견의 사회성 향상과 기본 훈련을 목표로 합니다.', 5, 9, NULL);


INSERT INTO class (class_no, course_no, pet_no, class_prog) VALUES
(1, 1, 4, 97),
(2, 2, 6, 13),
(3, 3, 2, 48),
(4, 4, 2, 45),
(5, 5, 6, 77),
(6, 6, 5, 5),
(7, 7, 8, 68),
(8, 8, 2, 48),
(9, 9, 2, 70),
(10, 10, 5, 80);


INSERT INTO schedule (sched_no, class_no, sched_step, sched_date, sched_start, sched_end, sched_attend) VALUES
(1, 1, 5, '2024-07-02', '2024-07-02 10:00:00', '2024-07-02 11:00:00', 'N'),
(2, 2, 5, '2024-07-03', '2024-07-03 10:00:00', '2024-07-03 11:00:00', 'Y'),
(3, 3, 1, '2024-07-04', '2024-07-04 10:00:00', '2024-07-04 11:00:00', 'Y'),
(4, 4, 2, '2024-07-05', '2024-07-05 10:00:00', '2024-07-05 11:00:00', 'N'),
(5, 5, 1, '2024-07-06', '2024-07-06 10:00:00', '2024-07-06 11:00:00', 'Y'),
(6, 6, 1, '2024-07-07', '2024-07-07 10:00:00', '2024-07-07 11:00:00', 'N'),
(7, 7, 3, '2024-07-08', '2024-07-08 10:00:00', '2024-07-08 11:00:00', 'N'),
(8, 8, 3, '2024-07-09', '2024-07-09 10:00:00', '2024-07-09 11:00:00', 'Y'),
(9, 9, 3, '2024-07-10', '2024-07-10 10:00:00', '2024-07-10 11:00:00', 'N'),
(10, 10, 2, '2024-07-11', '2024-07-11 10:00:00', '2024-07-11 11:00:00', 'N');