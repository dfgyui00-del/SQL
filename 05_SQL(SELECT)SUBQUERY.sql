/*
	< SUBQUERY >
	메인 쿼리(FROM)를 보조하는 쿼리문이라 해서 보조 쿼리문(WHERE)
*/
-- 전체 환자의 평균 키보다 키가 더 큰 환자들의 이름을 조회
SELECT
	   AVG(HEIGHT_CM) 
  FROM
  	   PATIENT;

SELECT 
	   PATIENT_NAME
	 , HEIGHT_CM 
  FROM 
  	   PATIENT
 WHERE
 	   HEIGHT_CM > (SELECT AVG(HEIGHT_CM) FROM PATIENT)
 ORDER 
	BY
	   HEIGHT_CM;

-- 배준혁 환자와 같은 병동에 있는 환자들의 이름, 병동명
SELECT WARD_NAME FROM WARD
  JOIN PATIENT USING(WARD_ID) WHERE  PATIENT_NAME = '배준혁';

SELECT
	   PATIENT_NAME
	 , WARD_NAME
  FROM
  	   PATIENT p 
  JOIN 
  	   WARD w USING (WARD_ID)
 WHERE 
 	   W.WARD_NAME = (SELECT WARD_NAME FROM WARD
  JOIN PATIENT USING(WARD_ID) WHERE  PATIENT_NAME = '배준혁'); 


-- 허준이 담당하는 환자명 조회
SELECT DOCTOR_ID FROM DOCTOR WHERE DOCTOR_NAME = '허준';


SELECT 
	   PATIENT_NAME
  FROM 
  	   PATIENT p 
 WHERE 
 	   p.DOCTOR_ID = (SELECT DOCTOR_ID 
						FROM DOCTOR 
					   WHERE DOCTOR_NAME = '허준');



SELECT PATIENT_NAME 
  FROM PATIENT
  JOIN DOCTOR USING(DOCTOR_ID) WHERE DOCTOR_NAME ='허준';




-- 단일행 서브쿼리
SELECT 
	   PATIENT_NAME
  FROM 
  	   PATIENT
 WHERE 
 	   DEPT_ID = (SELECT DEPT_ID 
 	   				FROM DEPT
 	   			   WHERE DEPT_TYPE='외과계'); -- 결과값이 4개와 1개와 비교하려고 해서 오류남
				-- 다중행 서브쿼리
 	   

--다중행 서브쿼리 ** IN **
SELECT 
	   PATIENT_NAME
  FROM 
  	   PATIENT
 WHERE 
 	   DEPT_ID IN (SELECT DEPT_ID FROM DEPT WHERE DEPT_TYPE='외과계');


-- ANY : 서브쿼리 결과 중 하나라도 크면(최소값보다 크면)
-- ALL : 서브쿼리 결과 중 모두보다 크면(최대값보다 크면)

-- 다중열 서브쿼리
-- 진료과별로 가장 키가 큰 환자의 이름, 키 조회
SELECT MAX(HEIGHT_CM) FROM PATIENT GROUP BY DEPT_ID;


SELECT 
	   PATIENT_NAME, HEIGHT_CM
  FROM 
  	   PATIENT
 WHERE 
 	   (DEPT_ID, HEIGHT_CM) IN (SELECT DEPT_ID, MAX(HEIGHT_CM) 
							    FROM PATIENT GROUP BY DEPT_ID);
-- 2개를 조회하므로 다중열이 나오니까 2개의 값으로 조회시켜야 한다.

-- 서브쿼리 작성 후 메인 쿼리 작성


-- 오라클 11버전 이하라면 12이상은 못쓰는 거

-- 전체 환자들 중 몸무게 몸무게 TOP 5 환자조회
SELECT 
	   PATIENT_NAME
	 , WEIGHT_KG
	 , ROWNUM
  FROM 
  	   PATIENT
 WHERE
 	   ROWNUM <= 5
 ORDER  
	BY
	   WEIGHT_KG DESC ;

-- 인라인 뷰			FROM절에 서브쿼리 쓰는 것  -오라클 11버전-
-- 오라클 11버전이 실무니까 이걸 잘알아 두어야 한다.
SELECT
	   PATIENT_NAME
	 , WEIGHT_KG
  FROM (
		SELECT
			   PATIENT_NAME
			 , WEIGHT_KG
			 , ROWNUM RNUM
		  FROM 
		  	   (SELECT
					   PATIENT_NAME
					 , WEIGHT_KG
				  FROM 
				  	   PATIENT
				 ORDER 
				 	BY
				 	   WEIGHT_KG DESC))
 WHERE
 	   --ROWNUM <=5;
	   --ROWNUM BETWEEN 1 AND 10;
	   RNUM BETWEEN 6 AND 10; -- 1부터 해야 동작하게 만듬 ROWNUM이 문제 이름을 바꿔서 사용한다


	   
	   
-- 12C 이상		대부분 11버전이라서 이걸 못 쓸 확률이 높다
SELECT
	   PATIENT_NAME
	 , WEIGHT_KG
  FROM 
  	   PATIENT
 ORDER
 	BY
 	   WEIGHT_KG DESC
 FETCH FIRST 5 ROW ONLY;
SELECT 
	   PATIENT_NAME
	 , WEIGHT_KG
  FROM 
  	   PATIENT
 ORDER
 	BY
 	   WEIGHT_KG DESC
OFFSET 5 ROW FETCH NEXT 5 ROWS ONLY;

--------------------------------------------------
-- 스칼라 서브쿼리 --> 편의성
-- 값이 무조건 1개만 조회(SELECT)되어야 함
-- 실무에서 자주 씀 이유 => 귀찮아서
-- 안쓸 수 있으면 안쓰는게 좋다.
-- 캐싱되서 빠를 수도 있다. - 고급자용
SELECT 
	   PATIENT_NAME
	 , (SELECT DOCTOR_NAME FROM DOCTOR WHERE DOCTOR_ID = P.DOCTOR_ID )
	 , (SELECT WARD_NAME FROM WARD WHERE WARD_ID = P.WARD_ID )
	 , (SELECT DEPT_NAME FROM DEPT WHERE DEPT_ID = P.DEPT_ID )
  FROM
  	   PATIENT P;


















