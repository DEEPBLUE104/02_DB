/*
 * SUBQUERY (서브쿼리 == 내부쿼리)
 * 
 * - 하나의 SQL문 안에 포함된 또다른 SQL문
 * - 메인쿼리(== 외부쿼리, 기존쿼리)를 위해 보조역할을 하는 쿼리문
 * 
 * -- 메인쿼리가 SELECT 문일 때
 * -- SELECT, FROM, WHERE, HAVING 절에서 사용 가능
 * 
 * */

-- 서브쿼리 예시1.

-- 부서코드가 노올철 사원과 같은 부서 소속의 직원의
-- 이름, 부서코드 조회

-- 1) 노올철 사원의 부서코드 조회(서브쿼리)
SELECT DEPT_CODE 
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; --D9

-- 2) 부서코드가 'D9'인 직원의 이름, 부서코드 조회(메인쿼리)
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 3) 부서코드가 노옹철 사원과 같은 소속의 직업 명단 조회
--> 위의 2개의 단계를 하나의 쿼리로 병합

SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE 
									 FROM EMPLOYEE
									 WHERE EMP_NAME = '노옹철');

-- 서브쿼리 예시2.
-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여 조회

-- 1) 전 직원의 평균 급여 조회(서브쿼리)
SELECT CEIL(AVG(SALARY))
FROM EMPLOYEE; -- 3,047,663

-- 2) 직원 중 급여가 3,047,663원 이상인 사원들의
-- 사번, 이름, 직급코드, 급여 조회(메인쿼리)
SELECT EMP_ID, EMP_NAME, JOB_CODE ,SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047663;

-- 3) 위의 2단계를 하나의 쿼리로 병합
SELECT EMP_ID, EMP_NAME, JOB_CODE ,SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT CEIL(AVG(SALARY)) FROM EMPLOYEE);

---------------------------------------------------------------

/* 서브쿼리 유형
 * 
 * - 단일행 (단일열) 서브쿼리 : 서브쿼리의 조회 결과 값의 개수가 1개일 때
 * 
 * - 다중행 (단일열) 서브쿼리 : 서브쿼리의 조회 결과 값의 개수가 여러개일 때
 * 
 * - 다중열 서브쿼리 : 서브쿼리의 SELECT 절에 나열된 항목수가 여러개일 때
 * 
 * - 다중행 다중열 서브쿼리 : 조회 결과 행 수와 열 수가 여러개일 때
 * 
 * - 상(호연)관 서브쿼리 : 서브쿼리가 만든 결과 값을 메인쿼리가 비교 연산할 때
 * 						메인쿼리 테이블의 값이 변경되면 
 * 						서브쿼리의 결과값도 바뀌는 서브쿼리
 * 
 * - 스칼라 서브쿼리 : 상관 쿼리이면서 결과 값이 하나인 서브쿼리
 * 
 * ** 서브쿼리 유형에 따라 서브쿼리 앞에 붙는 연산자가 다름 ** 
 * 
 * */		

------------------------------------------------------------

-- 1 단일행 서브쿼리 (SINGEL ROW SUBQUERY)
-- 서브쿼리의 조회 결과 값의 개수가 1개인 서브쿼리
-- 단일행 서브쿼리 앞에는 비교 연산자 사용
-- < , > , <= , >= , = , != , / <> / ^=

-- 전 직원의 급여 평균보다 많은(초과) 급여를 받는 직원의
-- 이름, 직급명, 부서명, 급여를 직급 순으로 정렬하여 조회

SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY JOB_CODE;
-- SELECT절에 명시되지 않은 컬럼이라도
-- FROM, JOIN으로 인해 테이블상 존재하는 컬럼이라면
-- ORDER BY절 사용 가능


-- 가장 적은 급여를 받는 직원의
-- 사번, 이름, 직급명, 부서코드, 급여, 입사일 조회

-- 서브쿼리
SELECT MIN(SALARY) FROM EMPLOYEE; -- 1,380,000

-- 메인쿼리 + 서브 쿼리
SELECT EMP_ID, JOB_NAME, DEPT_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE); 

-- 노옹철 사원의 급여보다 많이 (초과) 받는 직원의
-- 사원, 이름, 부서명, 직급명, 급여 조회

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE	WHERE EMP_NAME = '노옹철');
