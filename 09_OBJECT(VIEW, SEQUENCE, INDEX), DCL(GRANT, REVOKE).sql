/*
	< VIEW(뷰) >			--권한을 받아야만 사용 가능(개발자의 영역이 아님)
	SELECT문을 저장하는 가상 테이블
*/
-- 환자명, 진료과, 계열, 병동명, 담당의, 성별, 혈액형, 입원일을 조회하시오.
CREATE OR REPLACE VIEW VIEW_PATIENT_INFO
AS 
SELECT
	   PATIENT_NAME
	 , DEPT_NAME
	 , DEPT_TYPE
	 , WARD_NAME
	 , FLOOR(MONTHS_BETWEEN(SYSDATE, BIRTH_DATE) / 12) AGE
	 , DOCTOR_NAME
	 , GENDER
	 , BLOOD_TYPE
	 , ADMISSION_DATE
  FROM
	   PATIENT p 
  JOIN 
  	   DEPT d USING (DEPT_ID)
  JOIN 
  	   WARD w USING (WARD_ID)
  JOIN
  	   DOCTOR d2 USING (DOCTOR_ID);
  	  


SELECT * FROM VIEW_PATIENT_INFO;

SELECT VIEW_NAME, TEXT FROM USER_VIEWS;
----------------------------------------------------
/*
 * < SEQUENCE(시퀀스) >		-- 오라클 11버전 이하에서 사용
 * 
 * 채번하는 객체   - 숫자 붙이기 '일련번호 생성'
 * 주로 PRIMARY KEY값을 자동으로 생성할 떄 사용
 * 
 * 시퀀스는 테이블과 연결되어 있지 않음.
 */

CREATE TABLE SNACK(
   SNACK_NO VARCHAR(5) PRIMARY KEY,
   SNACK_NAME VARCHAR(15 CHAR) NOT NULL,
   PRICE NUMBER NOT NULL 
);

INSERT INTO SNACK
VALUES ('S1', '오사쯔', 4500);

INSERT INTO SNACK
VALUES ('S2', '빼뺴로', 2000);

ROLLBACK;


CREATE SEQUENCE SEQ_SNACK_ID;	-- 시퀀스 
/*
 * START WITH 시작번호
 * INCREMENT BY 증가값
 * MAXVALUE 최대값
 * MINVALUE 최소값
 * CYCLE | NOCYCLE -- 최대 도달 시 순환여부
 * CACHE 크기 | NOCACHE
 */

-- 사용 : 시퀀스명.NEXTVAL / 시퀀스명.CURRVAL

SELECT SEQ_SNACK_ID.CURRVAL FROM DUAL;	-- 현재 시퀀스의 마지막 값을 확인용

SELECT SEQ_SNACK_ID.NEXTVAL FROM DUAL;  -- 유일한 번호를 보장, 연속성은 보장하지 않음

--NEXTVAL은 호출 시 번호가 소비됨, FOLLVACK해도 번호가 돌아오지 않음


INSERT 
  INTO 
  	   SNACK
 VALUES
 	    (
 	    'S' || SEQ_SNACK_ID.NEXTVAL
 	  , '과자3'
 	  , 4000
 	    );


SELECT * FROM SNACK;

---- 12C 이상
-- MySQL AUTO_INCREMENT
CREATE TABLE VISIT_LOG(
	LOG_NO NUMBER GENERATED ALWAYS AS IDENTITY,
	PATIENT_ID CHAR(3) REFERENCES PATIENT
);

INSERT INTO VISIT_LOG(PATIENT_ID) VALUES('P01');
-- 시퀀스를 자동 생성해서 번호를 증가시킴 테이블을 지우면 시퀀스도 같이 지워짐

SELECT * FROM VISIT_LOG;




-- INDEX<인덱스>
/*
 * 데이터 검색 속도를 향상 시키기 위한 객체
 * 
 * PRIMARY KEY 제약조건이 있는 컬럼은 자동으로 인덱스를 생성
 * WHERE절에 자주 쓰이는 컬럼, 조인컬럼(FK)에 주로 생성
 * 
 * CREATE INDEX 인덱스명 ON 테이블명(컬럼명);
 * DROP INDEX 인덱스명;
 * 
 */

SELECT INDEX_NAME, TABLE_NAME, UNIQUENESS FROM USER_INDEXES
 WHERE TABLE_NAME IN ('DEPT', 'WARD', 'POSITION');

SELECT * FROM DEPT WHERE DEPT_ID = 'D8';
---------------------------------------------------------------

-- < DCL (Data Control Language) >

/*
 * GRANT(권한 부여), REVOKE(권한 회수)
 * 
 * 시스템 권한 : 
 * CREATE SESSTION : DB 접속 권한
 * CREATE TABLE : 테이블 생성 권한
 * CREATE VIEW : 뷰 생성 권한
 * CREATE SEQUENCE : 시퀀스 생성 권한
 * 
 * 객체권한
 * SELECT, INSERT, UPDATE, DELETE ON 테이블명
 * 
 * GRANT 권한 TO 사용자;
 * REVOKE 권한 FROM 사용자;
 * 
 * 
 * ROLE
 * CONNECT : CREATE SESSTIN
 * RESOURCE : CREATE TABLE, CREATE SEQUENCE, CREATE TRIGGER,
 * 			  CREATE PROCEDURE 등등/..
 * DBA : 최고 강력한 관리자 권한
 */
CREATE OR REPLACE VIEW MY_VIEW
    AS
SELECT * FROM DEPT;

GRANT CREATE VIEW TO HOSPITAL;
REVOKE CREATE VIEW FROM HOSPITAL;














