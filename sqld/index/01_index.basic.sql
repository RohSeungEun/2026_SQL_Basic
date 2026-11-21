--11/15 인덱스 복습
-- 인덱스(index)
-- 인덱스는 데이터베이스에서 검색 속도를 향상시키기 위해 사용되는 자료 구조.
-- 인덱스는 데이터 빠르게 찾는 도구 실무에서 현실적으로 인덱스 없이 DB 운영 불가능함.

-- 인덱스 장점
-- SELECT 문 검색 속도가 매우 빨라짐
-- 컴퓨터 부담 저하, 시스템 성능 향상됨

-- 인덱스 단점
-- 인덱스 검색 시 산출 빠를지, SELECT문 전체 조회가 빠를지 MySQL이 판단함.
-- 필요없는 인덱스 사용 시 DB 공간 낭비 (인덱스 대략 테이블 크기 10% 공간 추가로 필요함)
-- 인덱스 검색보다 전체 데이터 찾는 것보다 느려짐.
-- SELECT 문 아닌 데이터 변경 작업이 자주 일어나면 오히려  성능 저하됨.

-- 인덱스 종류
-- 1): 클러스트형 인덱스 (자동사전) 
--    - 기본키로 지정 시 자동 생성되며 테이블에 1개만 만들 수 있음. (자동 정렬 o)
-- 2): 보조 인덱스: 일반 적인 책
--    - 고유 키로 지정 시 자동 생성되며 테이블에 여러 개 만들 수 있음. (자동 정렬 x) 
-- 3) 고유 인덱스 : 값이 중복되지 않는 인덱스 

---클러스트형 인덱스 SQL
USE market_db;
-- 테이블 생성
CREATE TABLE TABLE1 (
    COL1 INT PRIMARY KEY -- 기본키 지정
    COL2 INT,
    COL3 INT
);

SHOW INDEX FROM TABLE1;  -- 인덱스 정보 확인
-- 클러스트형 인덱스 결과 
-- 컬럼에 Key_name PRIMARY 산출 => 자동 생성된 인덱스 
-- column_name COL1 => 기본키로 지정된 컬럼 
-- Non_unique 0 => 고유키로 지정된 컬럼, 중복 허용되지 않는 인덱스
-- 고유키 여러 개 지정 가능함

-- 보조 인덱스 SQL 산출 연습
CREATE TABLE TABLE2 (
    COL1 INT PRIMARY KEY -- 기본키 지정
    COL2 INT UNIQUE, -- 고유키 지정
    COL3 INT UNIQUE -- 고유키 지정
);

SHOW INDEX FROM TABLE2;  -- 인덱스 정보 확인

-- 보조 인덱스 결과
-- 보조 인덱스: KEY_NAME COL2, COL3 
-- Non_unique 0 => 고유키로 지정된 컬럼, 중복 허용되지 않는 인덱스
-- UNIQUE => 고유키로 지정된 컬럼, 보조 인덱스 여러 개 지정 가능함.


-- 자동 정렬되는 클러스트형 예시

DROP TABLE IF EXISTS member;

CREATE TABLE member (
    mem_id CHAR(8) , 
    mem_name VARCHAR(10), 
    mem_number INT     addr CHAR(2)
);

INSERT INTO member VALUES('TWS', '트와이스', 9, '서울');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남');        
INSERT INTO member VALUES('WHN', '여자친구', 6, '경기');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울');

-- mem_id 컬럼 기준 정렬
SELECT * FROM member; 

-- mem_id 컬럼에 클러스터형 인덱스 생성(mem_id 컬럼 기준 정렬)
ALTER TABLE member ADD CONSTRAINT PRIMARY KEY(mem_id);

-- 클러스터형 인덱스 생성된 열 데이터 자동 정렬됨.
SELECT * FROM member; 

ALTER TABLE member DROP PRIMARY KEY; -- 클러스터형 인덱스 제거


-- 자동 정렬되지 않는 보조 인덱스 예시
ALTER TABLE member ADD CONSTRAINT UNIQUE(mem_name); -- 보조 인덱스 생성
--고유키 여러개 설정 가능하고, 기존 고유키 제거할 필요 없음.

SELECT * FROM member; -- mem_name 컬럼 기준 정렬되지 않음.


---- 인덱스 구조
-- 페이지: MySQL에서 데이터를 저장하는 단위, 16KB(16384byte) 크기
-- 인덱스 구조: B+Tree 구조로 되어 있음.
-- B+Tree 구조: 데이터가 정렬되어 저장되며, 검색 속도가 빠름.
-- Index 구조: 루트 노드, 내부 노드, 리프 노드로 구성됨.
-- Index 구조: 루트 노드 -> 내부 노드 -> 리프 노드 순으로 검색됨.
-- Inesert 구문에서 Index는 데이터 변경 작업이 오히려 느려짐 


--- 클러스트형 인덱스 균형 트리 구조
CREATE TABLE clustTbr (
    mem_id CHAR(8) , 
    mem_name VARCHAR(10), 
);

INSERT INTO clustIndexTbr VALUES('TWS', '트와이스');
INSERT INTO clustIndexTbr VALUES('BLK', '블랙핑크');
INSERT INTO clustIndexTbr VALUES('WHN', '여자친구');
INSERT INTO clustIndexTbr VALUES('OMY', '오마이걸');
INSERT INTO clustIndexTbr VALUES('BTS', '방탄소년단');
INSERT INTO clustIndexTbr VALUES('NCT', '엔시티');
INSERT INTO clustIndexTbr VALUES('EXO', '엑소');
INSERT INTO clustIndexTbr VALUES('SE7EN', '세븐');
INSERT INTO clustIndexTbr VALUES('BIGBANG', '빅뱅');
INSERT INTO clustIndexTbr VALUES('2PM', '투피엠');

SELECT * FROM clustTbr; 

-- 클러스터형 인덱스 생성
ALTER TABLE clustTbr ADD CONSTRAINT PRIMARY KEY(mem_id); 

-- 기본키(mem_id)로 컬럼 기준 자동 정렬
SELECT * FROM clustTbr; 

-- 위 결과: 데이터 페이지 정렬되고 균형 트리 형태의 인덱스 형성됨.
-- 클러스트형 인덱스는 데이터 페이지 정렬되며, 검색 속도가 빠름.
-- 클러스트형 인덱스는 루투페이지와 리프페이지로 구성됨.
-- => 인덱스 페이지의 리프 페이지는 데이터 페이지 그 자체임.


--- 보조 인덱스에서 균형 트리 구성
CREATE TABLE nonClustTbr (
    mem_id CHAR(8) , 
    mem_name VARCHAR(10), 
);

INSERT INTO clustIndexTbr VALUES('TWS', '트와이스');
INSERT INTO clustIndexTbr VALUES('BLK', '블랙핑크');
INSERT INTO clustIndexTbr VALUES('WHN', '여자친구');
INSERT INTO clustIndexTbr VALUES('OMY', '오마이걸');
INSERT INTO clustIndexTbr VALUES('BTS', '방탄소년단');
INSERT INTO clustIndexTbr VALUES('NCT', '엔시티');
INSERT INTO clustIndexTbr VALUES('EXO', '엑소');
INSERT INTO clustIndexTbr VALUES('SE7EN', '세븐');
INSERT INTO clustIndexTbr VALUES('BIGBANG', '빅뱅');
INSERT INTO clustIndexTbr VALUES('2PM', '투피엠');


-- mem_name 컬럼에 UNIQUE 지정 후 보조 인덱스 생성
Alter TABLE nonClustTbr ADD CONSTRAINT UNIQUE(mem_name); 

SELECT * FROM nonClustTbr;
-- 보조 인덱스는 루트페이지, 내부페이지, 리프페이지로 구성됨.
-- 보조 인덱스는 리프페이지에 데이터 페이지의 주소를 저장함.
-- 보조 인덱스는 데이터 페이지를 건드리지 않음. (데이터 페이지 정렬되지 않음)
-- 보조 인덱스 구성 시 별도의 공간에 인덱스 페이지 생성함.
-- 보조 인덱스는 데이터 위치가 페이지번호 +#위치로 기록되어 있음.


--- 인덱스 검색
-- 클러스트형 인덱스는 2개의 페이지만 읽어서 결과 생성
-- 보조 인덱스는 3개의 페이지만 읽어서 결과 생성
-- 인덱스 검색 시 보조 인덱스보다 클러스트형 인덱스가 조금 더 빠름.