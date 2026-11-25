-- 11/25 인덱스 실제 사용법 정리

-- member 테이블 전체 조회
SELECT * FROM member;

-- key_name이 PRIMARY 확인 -> mem_id에 클러스트형 인덱스 확인 가능
SHOW INDEX FROM member;

-- 테이블 인덱스 크기 확인 => 1페이지 할당됨.(16KB)
SHOW TABLE STATUS LIKE 'member'; 

-- 인덱스 생성
-- * 클러스트형 인덱스가 있으므로 단순 보조 인덱스(주소 중복 허용) 생성 
-- * 보조 인덱스 : 단순 보조 인덱스(중복 허용)와 고유 보조 인덱스(중복허용 안됨)로 나뉨
CREATE INDEX idx_member_addr 
    ON member (addr);

-- 생성한 인덱스 확인
-- 보조 인덱스 index_length가 0으로 결과 처리됨
SHOW INDEX FROM member;

-- 생성한 인덱스를 실행해야 인덱스가 실제적 적용됨.
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