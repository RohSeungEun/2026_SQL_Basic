// 24 (출처:패캠 강의 개념 정리) 기출 문제 풀기 복습
// 목표: DML 대표 명령문 3가지 이해

// 데이터 입력(INSERT)
// - 명령문 : INSERT INTO tbl_dml (col_1, col_2, col_3) VALUES (1, 'Hello MySQL', '2024-01-01');
// - 컬럼 삽읿할 데이터 유형 다를 경우 오류 발생
// - 열 이름 생략 시 입력 형식 == 테이블 열 목록 
// - 여러 데이터 삽입 시 1.INSERT문 반복,  2. 입력값 소괄호 리스트 형식 쉼표 구분
// - 특정 열에만 입력 시 해당 열 나열함
// - NULL 비허용 컬럼 경우 데이터 입력 필수임


// 예시 
// 01) 데이터 입력 (데이터 타입 불일치 오류 => 정수형 아님)
// INSERT INTO tbl_dml (col_1) VALUES ('Hello MySQL');


// 02) (컬럼이름 생략)
// INSERT INTO tbl_dml VALUES(2,'Hello MySQL','2024-01-02');

// 03) (컬럼 개수 불일치로 인한 오류)
// INSERT INTO tbl_dml VALUES(3,'Hello MySQL');

// 04) (특정 컬럼에만 데이터 입력) 
// INSERT INTO tbl_dml (col_1, col_2) VALUES(3,'Hello MySQL');

// 05) (컬럼 순서 변경)
// INSERT INTO tbl_dml (col_2, col_3, col_1) VALUES('Hello MySQL','2024-01-04',4);


// 06) 여러 데이터 한번에 입력 (순차적, 트랜잭션 3번)
// INSERT INTO tbl_dml (col_1, col_2, col_3) VALUES(5,'Hello MySQL','2024-01-05');
// INSERT INTO tbl_dml (col_1, col_2, col_3) VALUES(6,'Hello MySQL','2024-01-06');
// INSERT INTO tbl_dml (col_1, col_2, col_3) VALUES(7,'Hello MySQL','2024-01-07');

// 07) 여러 데이터 한번에 입력 (리스트 형식 => 트랜잭션 하나, 성능 향상)
// INSERT INTO tbl_dml (col_1, col_2, col_3) VALUES
// (8,'Hello MySQL','2024-01-08'),
// (9,'Hello MySQL','2024-01-09'),
// (10,'Hello MySQL','2024-01-10');



// 02. 데이터 수정 (UPDATE)
// 명령문 : UPDATE 테이블 명 SET 컬럼명=컬럼값 WHERE 컬럼명 = 컬럼값;  
// - SET문 수정 컬럼과 값 지정
// - 컬럼 유형과 수정할 데이터 유형 다를 시 오류 발생함
// - WHERE 문 조건 누락 시 테이블 전체 데이터 수정되므로 주의


// 예시) 데이터 수정
// UPDATE tbl_dml SET col_2 = 'Hello MySQL', col_3 = '2025-01-02'
// WHERE col_1 = 2;

// PK 없는 테이블로 인한 데이터 삭제 오류 시 안전모드 비활성화
// SET SQL_SAFE_UPDATES = 0;

// 조건 누락 시 전체 데이터 수정 시  전체 데이터 변경됨
// UPDATE tbl_dml SET col_2 = 'campus', col_3 = '2025-01-02';


// 03. 데이터 삭제(DELETE)
// - 명령문 : DELETE FROM table명 WHERE 컬럼명=컬럼값;
// - INSERT, UPDATE 구문과 다르게 반드시 "FROM" 필요
// - WHERE 문 조건 누락시 테이블의 전체 데이터 삭제되므로 주의!

// - 예시
// 1) 데이터 삭제 
// DELETE FROM tbl_dml WHERE col_1 = 2;

// 2) WHERE 조건 누락 시 전체 데이터 삭제 시 전체 데이터 변경됨
// DELETE FROM tbl_dml;