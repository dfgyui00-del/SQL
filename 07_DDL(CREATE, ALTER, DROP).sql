
/*
 * < DDL (Data Definition Language) >
 * 
 * 데이터 정의 언어
 * 객체(테이블, 뷰, 시퀀스, 프로시져, 트리거, 함수...)를
 * 생성(CREATE), 변경(ALTER), 삭제(DROP)하는 구문
 * 
 */
--		 만들어지는거
-- CREATE TABLE 
/*
 * 
 * CREATE TABLE 테이블명 (
 * 	컬럼명 자료형,
 *  컬럼명 자료형,
 *  ...
 * );
 * 
 * -자료형-
 * CHAR(1~2000)   	: 고정 길이 문자
 * NVARCHAR2(1~4000): 1글자부터 4000글자까지 -> 실무에서 사용하지 않음
 * TIMESTAMP
 *  
 * 
 * VARCHAR2(크기)	: 문자 -> 가변길이문자 -> 최대 4000Byte
 * NUMBER			: 숫자(정수/실수)
 * DATE				: 날짜 -> 년월일시분초
 * 
 * CLOB				: 대용량 문자
 *
 */
-- ORACLE 기준

-- VARCHAR2(4000 CHAR) <- 4000글자 제한하는 방법. NVARCHAR2가 필요 없어짐



-- 진료기록 테이블 만들기 -> 환자가 진료를 받을 때마다 한 행씩 쌓이는 테이블
/*
 * 제약 조건
 * 
 * - NOT NULL    : NULL값을 허용하지 않음
 * - UNIQUE	     : 중복값을 허용하지 않음
 * - PRIMARY KEY : NOT NULL + UNIQUE = 기본키, 테이블당 하나만 사용 가능	-> PK
 * - CHECK 	     : 지정한 조건에 맞는 값만 허용 
 * - FOREIGN KEY : 다른 테이블의 컬럼값만 허용(참조 무결성)					-> FK
 * 
 * FK => 삭제 옵션
 * - 옵션없음(기본) : 자식이 있으면 부모 삭제 불가
 * - ON DELETE CASCADE : 부모 삭제 시 자식도 함께 삭제
 * - ON DELETE SET NULL : 부모 삭제 시 자식의 FK를 NULL로
 * 
 * 
 * 
 * 
 * 
 * 제약조건은 X => 기본값
 * [제약조건 명시 방법]
 * 컬럼명 자료형 제약조건 -> 컬럼 레벨
 */



/*
CREATE TABLE TREATMENT(
	RECODE_ID NUMBER NOT NULL UNIQUE,	--식별자 역활 가능, (중복X, NULL 안됨)
	PATIENT_ID CHAR(3) NOT NULL,	--제약 조건
	DOCTOR_ID CHAR(4) NOT NULL,
	TREAT_DATE DATE,
	PRESCRIPTION VARCHAR2(200),
	COST NUMBER
);
*/



CREATE TABLE TREATMENT(	-- 자식 테이블
	RECODE_ID NUMBER,	
	PATIENT_ID CHAR(3) NOT NULL,	
	DOCTOR_ID CHAR(4) NOT NULL REFERENCES DOCTOR (DOCTOR_ID),  --참조 테이블은 부모 테이블
	TREAT_DATE DATE DEFAULT SYSDATE,	-- 기본값 설정
	PRESCRIPTION VARCHAR2(200),
	CONSTRAINT TREAT_COST_CK COST NUMBER,	-- 제약 조건 이름을 붙일 수 있다
	PRIMARY KEY (RECODE_ID),
	FOREIGN KEY (PATIENT_ID) REFERENCES PATIENT (PATIENT_ID),	--외래키 참조
	CHECK (COST >= 100000)
);



COMMENT ON COLUMN TREATMENT.RECORD_ID IS '기록번호';		-- 코멘트 달기

SELECT * FROM TREATMENT;
DROP TABLE TREATMENT;									-- 실무에서 봉인(위험함)

SELECT 
	   *
  FROM USER_TAB_COLUMNS
 WHERE TABLE_NAME = 'TREATMENT';		-- 저장된 모든 것이 담겨있음

INSERT INTO TREATMENT 
VALUES(NULL, 'P01', 'DR02', SYSDATE, '위소매절제술', 1000000);

INSERT INTO TREATMENT (RECODE_ID, PATIENT_ID, DOCTOR_ID, COST)
VALUES(2, 'P02', 'DR03', 50000);

INSERT INTO TREATMENT (RECODE_ID, PATIENT_ID, DOCTOR_ID)
VALUES(3, 'P01', 'DR13');


DELETE FROM TREATMENT WHERE RECODE_ID = 1;


SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
  FROM USER_CONSTRAINTS
 WHERE TABLE_NAME = 'TREATMENT';


-----------------------------------------------------------------------
-- ALTER


-- 컬럼을 추가
ALTER TABLE TREATMENT ADD (NEXT_VISIT DATE);

-- 컬럼을 수정
ALTER TABLE TREATMENT MODIFY (PRESCRIPTION VARCHAR2(1000));

-- 안되는 케이스 (값이 있는데 바꾸려는 경우)
ALTER TABLE TREATMENT MODIFY (PRESCRIPTION NUMBER);

-- 컬럼명 변경
ALTER TABLE TREATMENT RENAME COLUMN NEXT_VISIT TO VISIT_DATE;

-- 제약 조건 추가 (UNIQUE)
ALTER TABLE TREATMENT ADD CONSTRAINT VISIT_UP UNIQUE(VISIT_DATE); 

-- NOT NULL
ALTER TABLE TREATMENT MODIFY (VISIT_DATE NOT NULL);

-- 제약 조건 삭제
ALTER TABLE TREATMENT DROP CONSTRAINT VISIT_UP; 

SELECT * FROM TREATMENT;

------------------------------------------------------------

-- DROP TABLE
/*
 * DROP TABLE 테이블명;
 * DROP TABLE 테이블명 CASCADE CONSTRAINTS; -> 이 테이블을 참조하는 FK까지 같이 제거
 * DROP TABLE 테이블명 PURGE;   -> 휴지통에 안넣고 바로 지움
 * 
 * FLASHBACK TABLE TREATMENT TO BEFORE DROP; -> 휴지통에서 복구
 * PUGRE RECYCLEBIN; 휴지통 비우기
 */




















