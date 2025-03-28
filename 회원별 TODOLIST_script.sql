CREATE TABLE TB_MEMBER (
   MEMBER_NO CHAR(2) CONSTRAINT MEMBER_NO_PK PRIMARY KEY,    
   MEMBER_ID VARCHAR2(30) NOT NULL,
   MEMBER_PW VARCHAR2(30) NOT NULL,
   MEMBER_NAME VARCHAR2(30) NOT NULL,
   ENROLL_DATE DATE DEFAULT SYSDATE
);

CREATE TABLE TB_TODO (
   TODO_NO NUMBER PRIMARY KEY, -- 자동 증가 번호
   TODO_DESC VARCHAR2(255) NOT NULL, -- 할 일 내용
   TODO_STATUS VARCHAR2(30) DEFAULT 'PENDING', -- 할 일 상태 (예: PENDING, COMPLETED)
   FINAL_DATE DATE DEFAULT SYSDATE -- 마감일
);

COMMENT ON COLUMN TB_TODO.TODO_NO    IS '숫자';
COMMENT ON COLUMN TB_TODO.TODO_DESC    IS '해야할 일';
COMMENT ON COLUMN TB_TODO.TODO_STATUS   IS '할 일 상태';
COMMENT ON COLUMN TB_TODO.FINAL_DATE   IS '마감일';

CREATE SEQUENCE MEMBER_NO NOCACHE;
CREATE SEQUENCE TODO_NO NOCACHE;

DROP TABLE TB_TODO;

INSERT INTO TB_MEMBER
VALUES(MEMBER_NO.NEXTVAL, 'user01', 'pass01', '고해준', DEFAULT );
INSERT INTO TB_MEMBER
VALUES(MEMBER_NO.NEXTVAL, 'user02', 'pass02', '백은영', DEFAULT );
INSERT INTO TB_MEMBER
VALUES(MEMBER_NO.NEXTVAL, 'user03', 'pass03', '박주완', DEFAULT );


INSERT INTO TB_TODO 
VALUES(TODO_NO.NEXTVAL,'JDBC','PENDING', DEFAULT);
INSERT INTO TB_TODO 
VALUES(TODO_NO.NEXTVAL,'영화 감상','PENDING', DEFAULT);
INSERT INTO TB_TODO 
VALUES(TODO_NO.NEXTVAL,'어바등 소설 읽기','COMPLETED', DEFAULT);

COMMIT;

SELECT * FROM TB_TODO;
SELECT * FROM TB_MEMBER;

UPDATE TB_MEMBER SET MEMBER_NO = '4'
WHERE MEMBER_NO = '8';

DELETE TB_MEMBER 
WHERE MEMBER_NO = 6;

SELECT MEMBER_NO, MEMBER_ID, MEMBER_PW, MEMBER_NAME,
					TO_CHAR(ENROLL_DATE,'YYYY"년" MM"월" DD"일"') ENROLL_DATE
					FROM TB_MEMBER
					ORDER BY MEMBER_NO;