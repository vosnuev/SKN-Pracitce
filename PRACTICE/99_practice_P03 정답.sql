-- Active: 1773042196355@@127.0.0.1@3306@employeedb
-- SELECT 기초 (SELECT ~ LIMIT)
-- 1. 모든 사원의 모든 컬럼 조회
SELECT
  *
FROM 
  employee;

-- 2. 사원들의 사번(사원번호), 이름 조회
SELECT
  emp_id,
  emp_name
FROM 
  employee;

-- 3. 201번 사번의 사번 및 이름 조회
SELECT
  emp_id, 
  emp_name
FROM 
  employee
WHERE 
  emp_id = '201';

-- 4. 부서 코드가 'D9'인 사원의 이름과 부서코드 조회
SELECT
  emp_name,
  dept_code
FROM 
  employee
WHERE 
  dept_code = 'D9';

-- 5. 직급 코드가 'J1'인 사원 조회
SELECT
  emp_name, 
  job_code
FROM 
  employee
WHERE 
  job_code = 'J1';

-- 6. 급여가 300만원 이상(>=)인 사원의 사번, 이름, 급여를 조회
SELECT
  emp_id,
  emp_name,
  salary
FROM 
  employee
WHERE 
  salary >= 3000000;

-- 7. 부서코드가 'D6'이고 급여를 300만원보다 많이 받는 사원의 이름, 급여 조회
SELECT
  emp_name,
  salary
FROM 
  employee
WHERE
  dept_code = 'D6' AND
  salary > 3000000;

-- 8. 보너스를 받지 않는 사원의 사번, 이름, 급여, 보너스 조회
SELECT
  emp_id,
  emp_name,
  salary, 
  bonus
FROM 
  employee
WHERE 
  bonus IS NULL;

-- 9. 'D9' 부서에서 근무하지 않는 사원의 사번, 이름 조회
SELECT
  emp_id,
  emp_name
FROM 
  employee
WHERE 
  dept_code <> 'D9';

-- 10. 퇴사 여부가 N인 직원의 사번, 이름, 입사일 조회 (별칭 사용)
SELECT
  emp_id AS '사번',
  emp_name AS '이름',
  hire_date AS '입사일'
FROM 
  employee
WHERE 
  ent_yn = 'N';

-- 11. 급여가 350만원 이상 550만원 이하를 받는 직원의 사번, 이름, 급여 조회
SELECT
  emp_id AS '사번',
  emp_name AS '이름',
  salary AS '급여'
FROM 
  employee
WHERE 
  salary BETWEEN 3500000 AND 5500000;

-- 12. '성이 김씨'인 직원의 사번, 이름, 입사일 조회
SELECT
  emp_id,
  emp_name,
  hire_date
FROM 
  employee
WHERE 
  emp_name LIKE '김%';

-- 13. '성이 김씨'가 아닌 직원의 사번, 이름, 입사일 조회
SELECT
  emp_id,
  emp_name,
  hire_date
FROM 
  employee
WHERE 
  emp_name NOT LIKE '김%';

-- 14. 이름에 '하' 문자가 포함된 직원의 이름, 주민번호, 부서코드 조회
SELECT
  emp_name,
  emp_no,
  dept_code
FROM 
  employee
WHERE 
  emp_name LIKE '%하%';

-- 15. 'J2'직급이거나 'J7'직급인 직원들 중 급여가 200만원 이상인 직원의 이름, 급여 조회
SELECT
  emp_name,
  salary
FROM 
  employee
WHERE 
  job_code IN ('J2', 'J7') AND
  salary >= 2000000;

-- 16. 급여가 높은 순서대로 사원의 이름, 급여 조회 (상위 5명만)
SELECT
  emp_name, 
  salary
FROM 
  employee
ORDER BY 
  salary DESC
LIMIT 5;

-- 17. 중복된 급여 범위를 제거하고 급여 조회
SELECT
  DISTINCT salary
FROM
  employee
ORDER BY
  salary;

-- 18. 사원들의 이름을 사전 순서대로 정렬하고 상위 10명 조회
SELECT
  emp_name
FROM  
  employee
ORDER BY 
  emp_name ASC
LIMIT 10;

-- -------------------------------------------------------------------------------------------
-- 1. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오. (1행)
SELECT
  a.emp_id,
  a.emp_name,
  b.dept_title
FROM 
  employee a
LEFT JOIN department b ON (a.dept_code = b.dept_id)
WHERE 
  a.emp_name LIKE '%형%';

-- 2. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오. (9행)
SELECT
  a.emp_name AS '사원명',
  c.job_name AS '직급명',
  a.dept_code AS '부서코드',
  b.dept_title AS '부서명'
FROM 
  employee a
JOIN department b ON (a.dept_code = b.dept_id)
JOIN job c ON (a.job_code = c.job_code)
WHERE 
  b.dept_title LIKE '%해외영업%';

-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오. (8행)
-- (INNER JOIN 결과)
SELECT
  a.emp_name,
  a.bonus,
  b.dept_title,
  c.local_name
FROM 
  employee a
JOIN department b ON (a.dept_code = b.dept_id)
JOIN location c ON (b.location_id = c.local_code)
WHERE 
  a.bonus IS NOT NULL;

-- 4. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오. (3행)
SELECT
  a.emp_name AS '사원명',
  c.job_name AS '직급명',
  b.dept_title AS '부서명',
  d.local_name AS '근무지역명'
FROM 
  employee a
JOIN department b ON (a.dept_code = b.dept_id)
JOIN job c ON (a.job_code = c.job_code)
JOIN location d ON (b.location_id = d.local_code)
WHERE 
  a.dept_code = 'D2';

-- 5. 급여 테이블의 등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉에 보너스포인트를 적용하시오. (20행)
SELECT
  a.emp_name AS '사원명',
  b.job_name AS '직급명',
  a.salary AS '급여',
  a.salary * (1 + IFNULL(a.bonus, 0)) * 12 AS '연봉'
FROM 
  employee a
JOIN job b ON (a.job_code = b.job_code)
JOIN sal_grade c ON (a.sal_level = c.sal_level)
WHERE 
  a.salary > c.min_sal;

-- 6. 한국(KO)과 일본(JP)에 근무하는 직원들의
-- 사원명, 부서명, 지역명, 국가명을 조회하시오. (15행)
SELECT
  a.emp_name AS '사원명',
  b.dept_title AS '부서명',
  c.local_name AS '지역명',
  d.national_name AS '국가명'
FROM 
  employee a
JOIN department b ON (a.dept_code = b.dept_id)
JOIN location c ON (b.location_id = c.local_code)
JOIN national d ON (c.national_code = d.national_code)
WHERE 
  c.national_code IN ('KO', 'JP');

-- 7. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의
-- 사원명, 직급명, 급여를 조회하시오.
-- 단, JOIN과 IN 사용할 것 (8행)
SELECT
  a.emp_name,
  b.job_name,
  a.salary
FROM 
  employee a
JOIN job b ON (a.job_code = b.job_code)
WHERE 
  a.job_code IN ('J4', 'J7') AND
  a.bonus IS NULL;

-- 8. 직급이 대리이면서 아시아 지역(ASIA1, ASIA2, ASIA3 모두 해당)에 근무하는 직원 조회 (2행)
-- 사번(EMPLOYEE.EMP_ID), 이름(EMPLOYEE.EMP_NAME), 직급명(JOB.JOB_NAME), 부서명(DEPARTMENT.DEPT_TITLE),
-- 근무지역명(LOCATION.LOCAL_NAME), 급여(EMPLOYEE.SALARY)를 조회하시오.
SELECT
  a.emp_id,
  a.emp_name,
  b.job_name,
  c.dept_title,
  d.local_name,
  a.salary
FROM 
  employee a
JOIN job b ON (a.job_code = b.job_code)
JOIN department c ON (a.dept_code = c.dept_id)
JOIN location d ON (c.location_id = d.local_code)
WHERE 
  b.job_name = '대리' AND
  d.local_name IN ('ASIA1', 'ASIA2', 'ASIA3');

-- 9. 각 부서별 평균 급여와 직원 수를 조회하시오. (NULL 급여는 제외)
-- 평균 급여가 높은 순으로 정렬하시오. (6행)
SELECT
  b.dept_title AS '부서명',
  COUNT(a.emp_id) AS '직원 수',
  AVG(a.salary) AS '평균 급여'
FROM 
  employee a
JOIN department b ON (a.dept_code = b.dept_id)
WHERE 
  a.salary IS NOT NULL
GROUP BY 
  b.dept_title
ORDER BY 
  AVG(a.salary) DESC;

-- 10. 직원 중 보너스를 받는 직원들의 연봉 총합이 1억 원을
-- 초과하는 부서의 부서명과 연봉 총합을 조회하시오. (1행)
SELECT
  b.dept_title AS '부서명',
  SUM(a.salary * (1 + IFNULL(a.bonus, 0)) * 12) AS '연봉 총합'
FROM 
  employee a
JOIN department b ON (a.dept_code = b.dept_id)
WHERE 
  a.bonus IS NOT NULL
GROUP BY 
  b.dept_title
HAVING 
  SUM(a.salary * (1 + IFNULL(a.bonus, 0)) * 12) > 100000000;

-- 11. 국내 근무하는 직원들 중 평균 급여 이상을 받는
-- 직원들의 사원명, 급여, 부서명을 조회하시오. (서브쿼리 사용) (4행)
SELECT
  a.emp_name AS '사원명',
  a.salary AS '급여',
  b.dept_title AS '부서명'
FROM 
  employee a
JOIN department b ON (a.dept_code = b.dept_id)
JOIN location c ON (b.location_id = c.local_code)
WHERE 
  a.salary >= (
    SELECT
      AVG(salary)
    FROM 
      employee
    WHERE 
      salary IS NOT NULL
  ) AND
  c.national_code = 'KO';

-- 12. 모든 부서의 부서명과 해당 부서에 소속된 직원 수를 조회하시오.
-- 직원이 없는 부서도 함께 표시하시오. (9행)
SELECT
  b.dept_title AS '부서명',
  COUNT(a.emp_id) AS '직원 수'
FROM 
  department b
LEFT JOIN employee a ON (b.dept_id = a.dept_code)
GROUP BY 
  b.dept_title;

-- 13. 차장(J4) 이상 직급을 가진 직원과 사원(J7) 직급을 가진
-- 직원들의 급여 합계를 비교하여 결과를 출력하시오. (SET OPERATOR 사용) (2행)
SELECT
  '차장 이상' AS '구분',
  SUM(a.salary) AS '급여합계'
FROM 
  employee a
WHERE 
  a.job_code IN ('J1', 'J2', 'J3', 'J4')
UNION ALL
SELECT
  '사원' AS '구분',
  SUM(a.salary) AS '급여합계'
FROM 
  employee a
WHERE 
  a.job_code = 'J7';

-- -------------------------------------------------------------------------------------------
-- Q1
DROP TABLE IF EXISTS member_info;
DROP TABLE IF EXISTS team_info;

CREATE TABLE IF NOT EXISTS team_info (
	team_code INT AUTO_INCREMENT COMMENT '소속코드',
	team_name VARCHAR(100) NOT NULL COMMENT '소속명',
	team_detail VARCHAR(500) COMMENT '소속상세정보',
	use_yn CHAR(2) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
	PRIMARY KEY (team_code),
	CHECK (use_yn IN ('Y', 'N'))
) COMMENT '소속정보';

CREATE TABLE member_info (
	member_code INT AUTO_INCREMENT COMMENT '회원코드',
	member_name VARCHAR(70) NOT NULL COMMENT '회원이름',
	birth_date DATE COMMENT '생년월일',
	division_code CHAR(2) COMMENT '구분코드',
	detail_info VARCHAR(500) COMMENT '상세정보',
	contact VARCHAR(50) NOT NULL COMMENT '연락처',
	team_code INT NOT NULL COMMENT '소속코드',
	active_status CHAR(2) NOT NULL DEFAULT 'Y' COMMENT '활동상태',
	PRIMARY KEY (member_code),
	FOREIGN KEY (team_code) REFERENCES team_info (team_code),
	CHECK (active_status IN ('Y', 'N', 'H'))
) COMMENT '회원정보';

-- Q2
INSERT INTO 
	team_info(team_code, team_name, team_detail, use_yn)
VALUES 
	(null, '음악감상부', '클래식 및 재즈 음악을 감상하는 사람들의 모임', 'Y');
INSERT INTO 
	team_info(team_name, team_detail, use_yn)
VALUES 
	('맛집탐방부', '맛집을 찾아다니는 사람들의 모임', 'N');
INSERT INTO 
	team_info(team_name)
VALUES 
	('행복찾기부');
    
INSERT INTO 
	member_info(member_code, member_name, birth_date, division_code, detail_info, contact, team_code, active_status)
VALUES 
	(null, '송가인', '1990-01-30', 1, '안녕하세요 송가인입니다~', '010-9494-9494', 1, 'H');
INSERT INTO 
	member_info(member_name, birth_date, detail_info, contact, team_code, active_status)
VALUES 
	('임영웅', '1992-05-03', '국민아들 임영웅입니다~', 'hero@trot.com', 1, 'Y');
INSERT INTO 
	member_info(member_name, contact, team_code)
VALUES 
	('태진아', '(1급 기밀)', 3);