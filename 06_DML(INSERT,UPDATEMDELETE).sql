/*
	SELECT = Data Query Language	(DQL)	질의  - 검색할래
	
	INSERT, UPDATE, DELETE => Data Manipulation Language  (DML)  데이터 조작
	
	COMMIT, ROLLBACK

*/

-- < INSERT >

/*
 * '새로운 행'을 추가하는 구문	- 한 줄 단위로 데이터가 다 들어가야 함
 * 
 * INSERT INT 테이블명 VALUES(값,값,값, ....);    - 행에 해당하는 컬럼을 다 채워야 함
 */

-- 새로운 진료과 추가
INSERT INTO DEPT VALUES('D9', '안과', '기타'); 

SELECT * FROM DEPT;

INSERT 
  INTO 
  	   WARD 
VALUES
 	   (
 	   'W6'
 	 , '재활병동'
 	 , '일반'
 	 , 1
 	   );

SELECT * FROM WARD;


INSERT INTO DOCTOR(DOCTOR_ID,DOCTOR_NAME,POSITION_ID,HIRE_DATE) -- 원하는 컬럼만 선택후 입력값 받을 수 있다.
VALUES('DR13','홍길동','J4',SYSDATE);

SELECT * FROM DOCTOR;



-- DELETE   실무에선 거의 안씀

/*
 * DELETE FROM 테이블명    -> 이렇게만 적으면 테이블 모두 삭제
 * DELETE FROM 테이블명 WHERE 조건;
 * 
 * 테이블에서 행을 삭제하는 구문	- 가로줄을 삭제
 */

SELECT  * FROM DOCTOR;
DELETE FROM DOCTOR WHERE DOCTOR_ID = 'DR13';	-- 고유 식별자인 키값으로 조건을 걸어야 한다.

/*
 * TRUNCATE - 위험함, 무조건 테이블을 전체 삭제, (롤백 불가, 빠름-이론적)
 * DELETE -> 전체 삭제(롤백 가능)
 */

-------------------------------------------------------------------
/*
 * 
 * -UPDATE-
 * 
 * 
 * 
 * UPDATE
 * 		  테이블명
 * 	  SET
 * 		  컬럼명 = 바꿀값
 *  WHERE
 * 		  조건;
 */

SELECT * FROM DEPT;

UPDATE 
	   DEPT
   SET
	   DEPT_TYPE = '안과'
	 , DEPT_NAME = '진짜좋은안과'
 WHERE 
 	   DEPT_ID = 'D9';


