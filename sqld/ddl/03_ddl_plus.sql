-- 데이터 그룹화 (GROUP BY. HAVING절)

-- 1. 데이터 그룹화 => GROUP BY
-- - 나열한 컬럼에 따라 그룹화 생성, 그룹화 된 순서 중요함
-- - 집계함수 사용: 데이터 그룹화 
-- - HAVING문 사용: 그룹화된 데이터 필터링


-- 1.1 DISTICT VS GROUP BY 
-- - DISTICT/GROUPBY : 중복 데이터 제거
-- - DISTICT : 중복 제거 O, 집계 X
-- - GROUPBY : 중복 제거 O, 집계 O 


-- 1-2 집계함수 
-- SUM() : 합계 구하는 함수 
-- AVG() :  평균 구하는 함수 (NULL값 무시)
-- MIN(): 최소값 구함
-- MAX() :  최대값 구함
-- COUNT() :  행의 개수 구현 (NULL값 무시)


-- HAVING 으로 데이터 필터
SELECT special_features, rating
    FROM film 
    GROUP BY special_features, rating
    HAVING rating = "G";


-- 열에서 데이터 개수 50보다 큰 것만 필터링 
SELECT special_features, COUNT(*) AS cnt FROM film GROUP BY special_features HAVING cnt > 50;


-- DISTINCT
-- SELECT DISTINCT rating FROM film;
-- SELECT DISTINCT special_features, rating FROM film;



-- LIKE 구문 
-- - 문자열의 일부 글자 검색 혹은 특정 문자열이 지정된 패턴과 일치하는 지 확인
-- - 패턴은 일반문자와 카드 문자를 포함할 수 있음.
-- => 패턴 일치:  일반문자는 지정된 문자와 일치할 것
-- - 와일드 카드: 문자열에서 어느 한 부분만 일치하면 된다.
-- - ASCII 패턴일치와 유니코드 패턴 일치 지원함.
-- - 모든 인수가 ASCII 문자인 경우 ASCII 패턴 일치 수행된다.
-- - 인수 중 유니코드 데이터 형식 있으면 유니코드 패턴일치 수행된다.
-- - LIKE 구문은 성능 문제 발생으로 사용 주의!-

-- 1.1 LIKE 구문 사용 방식
-- %조건% : 앞뒤에 어느 문자열 와도 조건문에 포함된 데이터 반환
-- 언더바(_) : 어떤 글자든 하나의 글자만 허용
-- [(text)] :  [] 안에 적힌 글자만 허용
-- [^(text)] :  ^뒤에 적힌 글자 제외한 글자들만 허용


-- 1.2 LIKE 와 % 특정 문자열 검색 
-- - 특정 문자열 포함하는 문자열 검색은 % 허용
-- - %는 0개 이상의 문자열 대치
-- - % 선정 위치로 특정 문자열 포함하는 문자열 검색
--  => A% : A로 시작하는 모든 문자열
--  => %A : A로 끝나는 모든 문자열
--  => %A% : A를 포함하는 모든 문자열

-- 1.3 NOT LIKE 와 % 특정 문자열 제외 검색
-- -구문 : WHERE 컬럼 NOT LIKE '%VALUE%'; 


-- 1.4 특수 문자를 포함한 문자열 검색 
-- - %는 예약어(시스템이 사용하기 위해 미리 정의)임,  LIKE는'%%%' 검색 X
-- - ESCAPE 명령을 통해 특수 기호 포함하는 데이터 검색할 수 있음.
-- - 구문 : ~ WHERE 컬럼 LIKE '%#%%' ESCAPE '#'; 

-- 1.5 LIKE 와 언더바(_)로 문자열 검색
-- - 언더바(_): 특정 길이의 문자열 포함한 데이터 검색
--  => A_ : A로 시작하면서 뒤 글자 상관없고 전체 글자 수 2개인 문자열
--  => _A : 로 시작하면서 앞 글자 상관없고 전체 글자 수 2개인 문자열
--  => _A_ : 세 글자 중에 글자 A를 포함하는 모든 문자열 


--  1.6 LIKE 와 언더바(_)로 문자열 검색
--  특정 문자열로 시작하면서 특정 범위에 사용자가 원하는 문자열을 포함하는 데이터 검색 시 사용함


-- 1.7 REGEXP로 문자열 패턴 검색 
-- - 특정 범위 글자 포함, 특정 문자 반복 패턴, 특정 글자 범위 포함되지 않는 데이터 조회 사용
-- - 각종 오류를 포함하는 경우, SQL 인젝션(보안취약점) 취약 => 사용시 주의

-- 1-1 REGEXP(정규표현식 검색) 
--  종류
-- . :  줄바꿈 문자(\n) 제외한 임의의 한 문자 의미
-- * :  해당 문자 패턴 0번 이상 반복
-- + :  해당 문자 패턴 1번 이상 반복
-- ^, $ :  ^ => 문자열의 처음, $: 문자열 끝
-- | : OR 의미
-- [...] :  괄호 안에 있는 어떠한 문자 의미
-- [^...] :  괄호 안에 있지 않은 어떠한 문자 의미
-- { n } :  반복횟수 지정
-- { m, n } :  반복횟수의 최솟값과 최댓값 지정


-- 1.2 문자 범위 제외한 문자열 검색 
-- ^ : 특정 범위의 문자열 포함하지 않는 문자열 검색
-- ex : [^A]% :  첫 번째 글자가 A 아닌 모든 문자열 검색

-- 1.3 실습 정리
---- 전체 5글자 이상이면 RI 포함된 경우
SELECT * FROM customer WHERE first_name REGEXP '..RI.';

-- 5글자이면서 마지막 I글자로 끝나는 문자열 검색 ($: 마지막)
SELECT * FROM customer WHERE first_name REGEXP '..RI$';


---- OR 조건
-- SELECT * FROM customer WHERE first_name REGEXP 'X|Y|Z';
-- [(TEXT)] 
 SELECT * FROM customer WHERE first_name REGEXP '[XYZ]';
 SELECT * FROM customer WHERE first_name REGEXP '[ALM]D';

---- 해당 문자열 포함되지 않는 경우
SELECT * FROM customer WHERE first_name REGEXP '[^MARY]';
SELECT * FROM customer WHERE first_name REGEXP '^[^A-U]';

---- 0회 이상 등장하는 문자열 검색
SELECT * FROM customer WHERE first_name REGEXP 'A*';
SELECT * FROM customer WHERE first_name REGEXP 'N+';


---- 알파벳이 포함된 데이터 검색
SELECT * FROM film WHERE rating REGEXP '[A-Z]+';