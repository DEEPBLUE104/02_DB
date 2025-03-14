-- DDL(Data Definition Language)
-- 객체를 만들고(CREATE), 바꾸고(ALTER), 삭제(DROP) 하는 데이터 정의 언어


/*
 * ALTER(바꾸다, 수정하다, 변조하다)
 * 
 * -- 테이블에서 수정할 수 있는 것
 * 1) 제약 조건(추가/삭제)
 * 2) 컬럼(추가/수정/삭제)
 * 3) 이름변경 (테이블명, 컬럼명..)
 * 
 * 
 * */


-- 1) 제약조건(추가/삭제)-- 

-- [작성법]
-- 1) 추가 : ALTER TABLE 테이블명
--			ADD [CONSTRAINT 제약조건명] 제약조건(지정할컬럼명)
--			[REFERENCES 테이블명[(컬럼명)]]; <-- FK 인 경우 추가


-- 2) 삭제 : ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;

-- * 제약조건 자체를 수정하는 구문은 별도 존재하지 않음!
--> 삭제 후 추가를 해야함.


-- DEPARTMENT 테이블 복사 (컬럼명, 데이터타입, NOT NULL 만 복사)
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- DEPT_COPY의 DEPT_TITLE 컬럼에 UNIQUE 추가
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DEPT_COPY_TITLE_U UNIQUE(DEPT_TITLE); 

-- DEPT_COPY의 DEPT_TITLE 컬럼에 UNIQUE 삭제
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DEPT_COPY_TITLE_U;


-- *** DEPT_COPY 의 DEPT_TITLE 컬럼에 NOT NULL 제약조건 추가 / 삭제 ***
ALTER TABLE DEPT_COPY 
ADD CONSTRAINT DEPT_COPY_TITLE_NN NOT NULL(DEPT_TITLE);
-- ORA-00904: : 부적합한 식별자
--> NOT NULL 제약조건은 새로운 조건을 추가하는 것이 아닌
-- 컬럼자체에 NULL 허용/비허용을 제어하는 성질 변경의 형태로 인식됨.

-- MODIFY (수정하다) 구문을 사용해서 NULL 제어
ALTER TABLE DEPT_COPY 
MODIFY DEPT_TITLE NOT NULL; -- DEPT_TITLE컬럼에 NOT NULL 적용


ALTER TABLE DEPT_COPY 
MODIFY DEPT_TITLE NULL; -- DEPT_TITLE컬럼에 NULL 허용

--------------------------------------------------------------------------------


-- 2. 컬럼(추가/수정/삭제)

-- 컬럼 추가
-- ALTER TABLE 테이블명 ADD(컬럼명 데이터타입 [DEFAULT '값']);


-- 컬럼 수정
-- ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입; --> 데이터 타입 변경

-- ALTER TABLE 테이블명 MODIFY 컬럼명 DEFAULT '값'; --> DEFAULT 값 변경


-- 컬럼 삭제
-- ALTER TABLE 테이블명 DROP (삭제할컬럼명);
-- ALTER TABLE 테이블명 DROP COLUMN 삭제할컬럼명;

SELECT * FROM DEPT_COPY;

--CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD(CNAME VARCHAR2(30));
-- 새로 추가한 컬럼에 있는 값은 NULL

-- LNAME 컬럼 추가 (기본값 '한국')
ALTER TABLE DEPT_COPY ADD(LNAME VARCHAR2(30) DEFAULT '한국');
-- 컬럼이 생성되면서 DEFAULT 값이 자동 삽입되어있음


-- D10 개발1팀 추가
INSERT INTO DEPT_COPY 
VALUES ('D10', '개발1팀','L1', NULL, DEFAULT);
--ORA-12899: "KH"."DEPT_COPY"."DEPT_ID" 열에 대한 값이 너무 큼(실제: 3, 최대값: 2)
--> DEPT_ID의 데이터 타입이 CHAR(2) 이므로 영어 + 숫자 2글자까지 저장 가능
--> D10은 3바이트. CHAR(2)에 들어갈 수 없음
--> VARCHAR2(3)으로 변경해보기 (VARCHAR2는 남는 바이트 메모리 반환을 해줌)

-- DEPT_ID 컬럼 데이터 타입 수정
ALTER TABLE DEPT_COPY MODIFY DEPT_ID VARCHAR2(3);
--> 컬럼 데이터 타입 수정 후 다시 위 INSERT 실행 -> 삽입 성공 확인


--LNAME의 기본값을 'KOREA'로 수정
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT 'KOREA';
--> !! 기본값을 변경했다고 해서 기존 데이터가 변하지는 않는다!
--> 앞으로 INSERT 될 데이터만 변경된 내용을 삽입됨

INSERT INTO DEPT_COPY 
VALUES ('D10', '개발1팀','L1', NULL, DEFAULT);







