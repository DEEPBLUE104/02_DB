DROP TABLE TB_GAMES;

CREATE TABLE TB_GAMES (
	GAME_NO     NUMBER CONSTRAINT TB_GAMES_PK PRIMARY KEY,
	GAME_NAME   VARCHAR2(30) NOT NULL,
	MANAGER_ID     VARCHAR2(30) NOT NULL,
	MANAGER_PW     VARCHAR2(30) NOT NULL,
	MANAGER_NAME  VARCHAR2(30) NOT NULL,	
	FINAL_UPDATE DATE DEFAULT CURRENT_DATE
);

COMMENT ON COLUMN TB_GAMES.GAME_NO     IS '게임 순위';
COMMENT ON COLUMN TB_GAMES.GAME_NAME   IS '게임 이름';
COMMENT ON COLUMN TB_GAMES.MANAGER_ID     IS '관리자 아이디';
COMMENT ON COLUMN TB_GAMES.MANAGER_PW     IS '관리자 비밀번호';
COMMENT ON COLUMN TB_GAMES.MANAGER_NAME   IS '관리자 이름';
COMMENT ON COLUMN TB_GAMES.FINAL_UPDATE IS '마지막 업데이트 날짜';

DROP SEQUENCE SEQ_GAMES_NO;
-- USER_NO 컬럼에 삽입될 시퀀스 생성
CREATE SEQUENCE SEQ_GAMES_NO NOCACHE;
-- 시퀀스도 중복되면 나오지 않는다. 그러니 기존에 있는 걸 삭제후 해야한다
-- 전체 시행할 때는 JAVA랑 똑같이 위에서 아래로 진행되는 것 같다
-- 그래서 밑에 INSERT가 안됐어..

-- 샘플 데이터 INSERT
INSERT INTO TB_GAMES 
VALUES(SEQ_GAMES_NO.NEXTVAL, '삼삼이와 고양이 유령', 'samsam2', 'samsampass', '삼고양', DEFAULT );
INSERT INTO TB_GAMES
VALUES(SEQ_GAMES_NO.NEXTVAL, '김씨네 농장 일기','kimsday', 'kimpass', '김농가', DEFAULT );


COMMIT;

SELECT * FROM TB_GAMES;