-- 26/11/25 인덱스 실제 사용법 정리
-- 책: 나혼자 SQL 참고.


-- member 테이블 전체 조회
SELECT * FROM member;

-- key_name이 PRIMARY 확인 -> mem_id에 클러스트형 인덱스 확인 가능
SHOW INDEX FROM member;

-- 테이블 인덱스 크기 확인 => 1페이지 할당됨.(16KB)
SHOW TABLE STATUS LIKE 'member'; 

---⭐⭐⭐ 인덱스 생성
-- * 클러스트형 인덱스가 있으므로 단순 보조 인덱스(주소 중복 허용) 생성 
-- * 보조 인덱스 : 단순 보조 인덱스(중복 허용)와 고유 보조 인덱스(중복허용 안됨)로 나뉨
CREATE INDEX idx_member_addr 
    ON member (addr);

-- 생성한 인덱스 확인
-- 보조 인덱스 index_length가 0으로 결과 처리됨
SHOW INDEX FROM member;

-- ⭐⭐생성한 인덱스를 실행해야 인덱스가 실제적 적용됨.
ANALYZE TABLE member;

-- 생성한 인덱스 테이블 인덱스 크기 확인 시 index_length가 16KB 적용됨.
SHOW TABLE STATUS LIKE 'member'; 

-- 고유 보조 인덱스(중복 허용함). 
-- 중복 제거 UNIQUE
-- 인덱스 생성 시 기존 입력값에 중복이 있으면 안됨.
-- 인덱스 생성 후 입력되는 데이터와도 중복될 수 없기에 데이터 유형 선정에 신중해야 함

-- => ERROR CODE 결과값
CREATE UNIQUE INDEX idx_member_mem_number
    ON member (mem_number);

-- mem_name의 중복허용하지 않는 고유 보조 인덱스
CREATE UNIQUE INDEX idx_memver_mem_name
    ON member (mem_name);


-- 결과값 column_name의 Non_unique의 결과값이 0으로 설정됨
-- => 결과값 0은 중복 허용하지 않음을 의미함으로 잘 설정됨.
SHOW INDEX FROM member;


-- 26/11/28 인덱스 실제 활용

ANALYZE TABLE member;

SHOW UNDEX FROM member;

SELECT * FROM member;

-- 인덱스 사용 여부는 MySQL Execution PLAN창 확인 - 전체 테이블 검색한 것이 확인.
SELECT mem_id, mem_name, addr FROM member;

---⭐⭐ WHERE 절 사용된 열에 인덱스 생성 
-- 인덱스 생성된 mem_name이 에이핑크인 행 조회
-- 결과: Execution PLAN창 확인 시 SINGLE ROW
-- SINGLE ROW: 인덱스 결과를 얻었다는 의미임.
SELECT mem_id, mem_name, addr FROM member
    WHERE mem_name = '에이핑크';


-- 보조 인덱스 생성
CREATE INDEX idx_member_mem_number
    ON member(mem_number);

-- member 테이블 인덱스 적용함.
-- 결과: Execution PLAN창 확인 index Range Scan
ANALYZE TABLE member;


SELECT mem_name, mem_number FROM member
    WHERE mem_number >= 7;

-- 결과: Execution PLAN창 확인 FULL TABLE Scan
-- WHERE문 열에 연산 => 인덱스 사용하지 않음
-- WHERE문에 연산을 하지 않는 것이 좋음!
SELECT mem_name, mem_number FROM member
    WHERE mem_number*2 >= 14;

-- 인덱스 사용하지 않을 때 쿼리문, 인덱스 사용하지 않음
-- 결과: Execution PLAN창 확인 FULL TABLE Scan
SELECT mem_name, mem_number FROM member
    WHERE mem_number >= 1;


---⭐⭐인덱스 제거

-- 생성된 인덱스 있는지 테이블 확인
SHOW INDEX FROM member;


-- ⭐DROP INDEX : 인덱스 제거문
-- 클러스트형/보조 인덱스 있을 시 보조 인덱스 먼저 제거하는 것이 좋음
-- 클러스트형 친덱스 먼저 제거해도 되지만, 데이터 불필요한 재구성과 시간이 오래걸림.(단점)
DROP INDEX idx_member_mem_name ON member;
DROP INDEX idx_member_addr ON member;
DROP INDEX idx_member_mem_number ON member;


-- ⭐ALTER TABLE로 PRIMARKEY 설정된 클러스트형 인덱스 제거
-- 단 외래키 잠조 테이블 시 기본 키 제거 전 외래키 관계를 제거 해야 함,
ALTER TABLE member DROP PRIMARY KEY;


-- information_schema DB의 referential_constraints 테이블 조회
-- 외래키 이름을 알아야 외래키 관계 제거 시 더 편리함.
-- referential_constraints: MySQL 내 원래 포함된 시스템 DB와 TABLE임.
-- 결과: CONSTRAINT_NAME의 결과 값이 buy_ibfk_1
SELECT table_name, constraint_name 
    FROM information_schema.referential_constrains
    where constraint_schema = 'market_db';


-- 외래 키 제거 후 기본 키 제거.
ALTER TABLE buy DROP FOREIGN KEY buy_ibfk_1;
ALTER TABLE member DROP PRIMARY KEY;


--- 인덱스 성능 향상 방법
-- 1. 인덱스는 WHRER 절에 사용되는 열에 생성할 것.
-- 2. WHERE 절에 사용된 인덱스는 자주 사용해야 가치가 있음.
-- 3. 인덱스는 데이터 중복 높은 열에 생성 시 별 효과가 없다.
-- 4. 클러스트형 인덱스는 테이블 하나만 생성할 수 있음. 
--    - 빈번한 조회 많이 사용되는 열에 지정이 효과적임.
-- 5. 사용하지 않는 인덱스 제거하기. (공간 확보/ 데이터 입력 시 발생되는 부하 감소)