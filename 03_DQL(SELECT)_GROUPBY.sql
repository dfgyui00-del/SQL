-- 그룹 함수
-- 매우 중요 ☆★☆★
SELECT DOCTOR_ID FROM PATIENT;


SELECT 
	   COUNT(*) "전체 환자 수"
  FROM 
  	   PATIENT;


SELECT
	   COUNT(DISCHARGE_DATE) AS "퇴원한 환자의 수"
	 , COUNT(DOCTOR_ID) AS "배정된 환자의 수"
	 , COUNT(*) - COUNT(DOCTOR_ID) "입원중인 환자의 수"
  FROM 
  	   PATIENT;


-- COUNT() : 행 수 반환


SELECT 
	   MAX(WEIGHT_KG)   -- 가장 높은 몸무게
	 , MIN(WEIGHT_KG)   -- 가장 작은 몸무게
	 , MAX(BIRTH_DATE)  "어린"-- 가장 어린 환자의 생년월일 
	 , MIN(PATIENT_NAME) "최소"-- ㄱ에 가까운 이름
	 , SUM(WEIGHT_KG ) "합계"
	 , AVG(HEIGHT_CM ) "평균"
  FROM 
  	   PATIENT;
 ORDER 
	BY WEIGHT_KG DESC;


/*
 * COUNT()	: 행 수	******* 중요 ********
 * MIN()	: 최소값
 * MAX()	: 최대값
 * SUM()	: 합계
 * AVG()	: 평균
 */
-----------------------------------------------------
SELECT * FROM PATIENT;

SELECT 
	   COUNT(*) 
  FROM
  	   PATIENT
 WHERE 
 	   DEPT_ID = 'D1';

-- 질료과별 환자수 조회
SELECT
	   DEPT_ID 
	 , COUNT(*)
  FROM
  	   PATIENT
 GROUP 
 	BY 
 	   DEPT_ID
 ORDER 
	BY DEPT_ID;


-- 성별별 환자 수
SELECT
	   GENDER
	 , COUNT(*)
  FROM 
  	   PATIENT
 GROUP 
 	BY
 	   GENDER;


-- 병동별 환자수
SELECT 
	   WARD_ID 
	 , DEPT_ID 
	 , COUNT(*)
  FROM
  	   PATIENT
 GROUP
 	BY 
 	   DEPT_ID 
 	 , WARD_ID; 


SELECT
	   GENDER 
	 , WARD_ID 
  FROM
  	   PATIENT
 GROUP 
 	BY
 	   WARD_ID
	 , GENDER ;
-- GROUP BY절에 없는 일반 컬럼을 SELECT문에 쓰면 오류
-- 성별로 묶었는데 환자 이름을 고를 순 없음


-- 병동별, 성별 환자수
SELECT 
	   WARD_ID
	 , GENDER
	 , COUNT(*)
  FROM 
  	   PATIENT
 GROUP 
 	BY
 	   WARD_ID
	 , GENDER;


-- GROUP BY
SELECT
	   TO_CHAR(ADMISSION_DATE, 'YYYY-MM') AS "입원월"
	 , COUNT(*)
  FROM
  	   PATIENT
 WHERE
 	   EXTRACT(MONTH FROM ADMISSION_DATE) = 8
 GROUP 
	BY
	   TO_CHAR(ADMISSION_DATE, 'YYYY-MM')
 ORDER 
	BY
	   COUNT(*);

 
 
 
 
SELECT EXTRACT(YEAR FROM SYSDATE),
	   EXTRACT(MONTH FROM SYSDATE),
	   EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

-----------------------------------------------------


-- 혈액형별로 환자 수가 10명 이상인 혈액형이랑 환자수만 조회
SELECT 
	   BLOOD_TYPE
	 , COUNT(*)
  FROM
  	   PATIENT
 --WHERE
 	  -- COUNT(BLOOD_TYPE ); >= 10
 GROUP 
	BY
	   BLOOD_TYPE
HAVING 
	   COUNT(*) >= 10;
-- HAVING절 : 그룹함수에 대한 조건을 제시할 때 사용


-- 진료과별 환자 수
SELECT 
	   DEPT_ID
	 , COUNT(*)
  FROM 
  	   PATIENT
 GROUP 
 	BY
 	   ROLLUP(DEPT_ID);




-- 정리!
/*
 * SELECT			5 별칭
 * 	 FROM			1
 *  WHERE			2 테이블에 조건 걸기
 *  GROUP BY		3
 * HAVING			4 그룹으로 된 걸 조건 걸기
 *  ORDER BY		6 별칭 사용 가능
 */









