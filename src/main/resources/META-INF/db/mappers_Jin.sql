SELECT * FROM MEMBER;
SELECT * FROM NOTICE;
SELECT * FROM ADMIN;
SELECT * FROM ATTRACTION;
SELECT * FROM ZONE;
SELECT * FROM AT_REVIEW;
--------------------------------------------------------------------------------
--------------------------------- Member Query ---------------------------------
--------------------------------------------------------------------------------
-- (1) 내가 쓴 기구 리뷰 리스트 id = myArvList
SELECT M.*,
    (SELECT MNAME FROM MEMBER WHERE M.MID=MID)MNAME
    FROM (SELECT ROWNUM RN, R.*
        FROM (SELECT * FROM AT_REVIEW WHERE MID = 'fff' ORDER BY ARVNUM DESC ) R)M
    WHERE RN BETWEEN 1 AND 5;
    
-- (2) 내가 쓴 기구 리뷰 상세보기 id = myArvContent
SELECT M.*,
    (SELECT MNAME FROM MEMBER WHERE M.MID=MID)MNAME
    FROM (SELECT ROWNUM RN, R.*
        FROM (SELECT * FROM AT_REVIEW WHERE MID = 'fff') R)M
    WHERE ARVNUM = 16;
--------------------------------------------------------------------------------
--------------------------------- ADMIN QUERY ----------------------------------
--------------------------------------------------------------------------------
-- (1) 관리자 계정 로그인
SELECT * FROM ADMIN WHERE ADID = 'dbswls0209' AND ADPW='111';

-- (2) 로그인 후 세션에 넣을 용도 : ADMIN ADID로 (MODEL, VO, DTO) 가져오기
SELECT * FROM ADMIN WHERE ADID = 'dbswls0209';

-- (3) 목록 출력을 위한 전체 회원 수
SELECT COUNT(*) FROM MEMBER;

-- (4) 전체 회원 목록 출력 (startRow~endRow)
SELECT *
    FROM (SELECT ROWNUM RN, A.*
        FROM (SELECT MID, MMAIL, MNAME, MTEL, MVISIT, GRADE 
    FROM MEMBER, MEMBER_GRADE
    WHERE MVISIT BETWEEN LOWVI AND HIGHVI)A)
    WHERE RN BETWEEN 1 AND 5;
    
-- (5) 회원 삭제 
DELETE FROM MEMBER WHERE MID='bbb';

--------------------------------------------------------------------------------
---------------------------------- NOTICE QUERY --------------------------------
--------------------------------------------------------------------------------

-- (1) 공지사항 리스트 출력 - 최신 글 맨 위로 (startRow ~ end Row)
    -- 1. schItem == null;
    SELECT N.*,
        (SELECT ADNAME FROM ADMIN WHERE N.ADID = ADID)ADNAME
        FROM (SELECT ROWNUM RN, B.*
            FROM (SELECT * FROM NOTICE ORDER BY NNO DESC) B)N
        WHERE RN BETWEEN 1 AND 5;
    
    -- 2. schItem == 'all';
    SELECT N.*,
        (SELECT ADNAME FROM ADMIN WHERE N.ADID = ADID)ADNAME
        FROM (SELECT ROWNUM RN, B.*
            FROM (SELECT * FROM NOTICE WHERE NTITLE LIKE '%'||'안'||'%' OR 
            NTYPE LIKE '%'||'공지'||'%' ORDER BY NNO DESC) B)N
        WHERE RN BETWEEN 1 AND 10;  
    
    -- 3. schItem == 'title';
    SELECT N.*,
        (SELECT ADNAME FROM ADMIN WHERE N.ADID = ADID)ADNAME
        FROM (SELECT ROWNUM RN, B.*
            FROM (SELECT * FROM NOTICE WHERE NTITLE LIKE '%'||'안'||'%' ORDER BY NNO DESC) B)N
        WHERE RN BETWEEN 1 AND 10; 
    
    -- 4. schItem == 'ntype'
    SELECT N.*,
        (SELECT ADNAME FROM ADMIN WHERE N.ADID = ADID)ADNAME
        FROM (SELECT ROWNUM RN, B.*
            FROM (SELECT * FROM NOTICE WHERE NTYPE LIKE '%'||'공지'||'%' ORDER BY NNO DESC) B)N
        WHERE RN BETWEEN 1 AND 10;  

-- (1-1) 공지사항 메인 글 출력 
    SELECT N.*,
        (SELECT ADNAME FROM ADMIN WHERE N.ADID = ADID)ADNAME
        FROM (SELECT ROWNUM RN, B.*
            FROM (SELECT * FROM NOTICE ORDER BY NRDATE DESC) B)N
        WHERE RN BETWEEN 1 AND 4;
        
-- (2) 전체 글 갯수
    -- 1. schItem == null;
    SELECT COUNT(*) FROM NOTICE;
    
    -- 1. schItem == 'all';
    SELECT COUNT(*) FROM NOTICE WHERE NTITLE LIKE '%'||'안'||'%' OR NTYPE LIKE '%'||'공지'||'%';
    
    -- 1. schItem == 'title';
    SELECT COUNT(*) FROM NOTICE WHERE NTITLE LIKE '%'||'안'||'%';
    
    -- 1. schItem == 'ntype';
    SELECT COUNT(*) FROM NOTICE WHERE NTYPE LIKE '%'||'공지'||'%';
    
-- (3) 공지사항 글쓰기
INSERT INTO NOTICE(NNO, NTITLE, NTYPE, ADID)
    VALUES(NOTICE_SEQ.NEXTVAL, '개강 맞이 안녕 세상아!', '이벤트/뉴스', 'dbswls0209');
    
-- (4) 공지사항 상세보기
SELECT N.*,
    (SELECT ADNAME   FROM ADMIN WHERE N.ADID = ADID)ADNAME
    FROM (SELECT ROWNUM RN, B.*
        FROM (SELECT * FROM NOTICE ORDER BY NNO DESC) B)N
    WHERE NNO=100;
    
-- (5) 공지사항 수정하기
UPDATE NOTICE 
    SET NTITLE = '반갑습니다 환상의 나라',
        NCONTENT = 'HelloWorld',
        NTYPE = '뉴스/공지'
    WHERE NNO = 3;
    
-- (6) 공지사항 삭제하기
DELETE FROM NOTICE WHERE NNO = 2; 

-- (7) 공지사항 다음 글, 이전 글

    -- 이전 글
SELECT * 
    FROM NOTICE 
    WHERE NNO IN ((SELECT MAX(NNO) 
                    FROM NOTICE 
                    WHERE NNO < 90 )
    );

    -- 다음 글
SELECT * 
    FROM NOTICE 
    WHERE NNO IN ((SELECT MIN(NNO) 
                    FROM NOTICE 
                    WHERE NNO > 90 )
    );
    
FROM NOTICE 
WHERE NNO IN 
    (SELECT NNO FROM NOTICE NNO < 2 ORDER BY SEQ DESC LIMIT 1), 
     (SELECT NNO FROM NOTICE NNO < 2 ORDER BY SEQ LIMIT 1),);
--------------------------------------------------------------------------------
--------------------------------- AT_REVIEW QUERY ------------------------------
--------------------------------------------------------------------------------
-- (1) 리뷰 리스트 출력 (ATCODE별 리스트 작성일 역순)
    -- 1. schitem 이 null 또는 '' 일 때
    SELECT M.*,
        (SELECT MNAME FROM MEMBER WHERE M.MID = MID)MNAME
        FROM (SELECT ROWNUM RN, B.*
            FROM (SELECT * FROM AT_REVIEW ORDER BY ARVNUM DESC) B)M
        WHERE ATCODE = 5 AND RN BETWEEN 1 AND 4;
    
SELECT * FROM AT_REVIEW WHERE ATCODE = 1 ORDER BY ARVRDATE DESC; 
SELECT * 
    FROM (SELECT ROWNUM RN, A.*
        FROM (SELECT * FROM AT_REVIEW WHERE ATCODE = 1 ORDER BY ARVRDATE DESC)A)
    WHERE RN BETWEEN 2 AND 3;
    -- 2.  schitem 이 arvrating 일경우
    SELECT M.*,
    (SELECT MNAME FROM MEMBER WHERE M.MID = MID)MNAME
    FROM (SELECT ROWNUM RN, B.*
        FROM (SELECT * FROM AT_REVIEW ORDER BY ARVRATING DESC) B)M
    WHERE ATCODE = 5 AND RN BETWEEN 1 AND 4;
    -- 3. schitem 이 arvhit 일경우
    SELECT M.*,
    (SELECT MNAME FROM MEMBER WHERE M.MID = MID)MNAME
    FROM (SELECT ROWNUM RN, B.*
        FROM (SELECT * FROM AT_REVIEW ORDER BY ARVRATING DESC) B)M
    WHERE ATCODE = 5 AND RN BETWEEN 1 AND 4;
-- (2) 리뷰 갯수 (ATCODE별 토탈 갯수)
SELECT COUNT(*) FROM AT_REVIEW WHERE ATCODE =1;

-- (3) 리뷰 조회수 증가
UPDATE AT_REVIEW SET arvHIT = arvHIT +1
    WHERE ATCODE = 1 AND ARVNUM=5;

-- (4) 리뷰 상세보기 
    -- 1. schitem 이 null 또는 '' 일 때
SELECT M.*,
    (SELECT MNAME FROM MEMBER WHERE M.MID = MID)MNAME
    FROM (SELECT ROWNUM RN, B.*
        FROM (SELECT * FROM AT_REVIEW WHERE ATCODE = 1 ORDER BY ARVNUM DESC) B)M
    WHERE ARVNUM=1;
SELECT * FROM AT_REVIEW WHERE ATCODE=1 ORDER BY ARVRDATE DESC;
    -- 2. schitem 이 'all' 일 때
SELECT * FROM AT_REVIEW WHERE ATCODE=1 ORDER BY ARVRDATE, ARV_HIT, ARVRATING DESC;
    -- 3. schitem 이 'arvHIT' 일 때
SELECT * FROM AT_REVIEW WHERE ATCODE=1 ORDER BY ARVRDATE, ARV_HIT DESC;
    -- 4. schitem 이 'arvHIT' 일 때
SELECT * FROM AT_REVIEW WHERE ATCODE=1 ORDER BY ARVRDATE DESC, ARV_HIT ASC;
    -- 5. schitem 이 'arvRATING' (내림차순) 일 때 
SELECT * FROM AT_REVIEW WHERE ATCODE=1 ORDER BY ARVRDATE, ARVRATING DESC;
    -- 6. schitem 이 'arvRATING' (오름차순) 일 때
SELECT * FROM AT_REVIEW WHERE ATCODE=1 ORDER BY ARVRDATE DESC, ARVRATING ASC;
-- (5) 리뷰 등록
SELECT * FROM AT_REVIEW;
INSERT INTO AT_REVIEW (ARVNUM, ARVCONTENT, ARVRATING, ATCODE, MID)
    VALUES(AT_REVIEW_SEQ.NEXTVAL, '다음에 또 오고 싶어요', 5, 5, 'bbb');
select * from AT_REVIEW;
-- (6) 리뷰 수정
UPDATE AT_REVIEW
    SET ARVCONTENT = '지나가다가 귀여운 인형탈 아저씨가 아이에게 솜사탕을 주셨어요 감사합니다',
        ARVRATING = 5,
        ATCODE = 1,
        MID = 'aaa'
    WHERE ARVNUM = 2;
-- (7) 리뷰 삭제
DELETE FROM AT_REVIEW WHERE MID='bbb' AND ATCODE=1;
--------------------------------------------------------------------------------
--------------------------------- AT_RPLY QUERY --------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
------------------------------ ATTRACTION QUERY --------------------------------
--------------------------------------------------------------------------------
-- (1) id = attractionList 기구 리스트 출력 (startRow, endRow) 
    -- 1. schitem이 'null' 이거나 '' 일 때 (main)
-- SELECT * FROM (SELECT ROWNUM RN, A.* 
--    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATWEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME
--        FROM ATTRACTION A, ZONE Z WHERE A.ZNAME = Z.ZNAME ORDER BY ATCODE DESC)A)
--    WHERE RN BETWEEN 1 AND 5;
    SELECT A.*,
        (SELECT ZPLACE FROM ZONE WHERE A.ZNAME = ZNAME)ZPLACE
        FROM (SELECT ROWNUM RN, Z.*
            FROM (SELECT * FROM ATTRACTION ORDER BY ATCODE) Z)A
        WHERE RN BETWEEN 1 AND 5;
    -- 2. schitem이 'all' 일 떄 
    SELECT A.*,
        (SELECT ZPLACE FROM ZONE WHERE A.ZNAME = ZNAME)ZPLACE
        FROM (SELECT ROWNUM RN, Z.*
            FROM (SELECT * FROM ATTRACTION WHERE ZNAME LIKE '%'||'익스트림존'||'%' OR ATOLD
			         LIKE '%'||10||'%' OR ATHEIGHT LIKE '%'||150||'%' OR ATNOP LIKE '%'||40||'%' ORDER BY ATCODE) Z)A
        WHERE RN BETWEEN 1 AND 5;
SELECT * FROM ATTRACTION;

SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME
        FROM ATTRACTION A, ZONE Z WHERE A.ZNAME = Z.ZNAME  AND Z.ZNAME = '익스트림존' AND ATOLD >=10 AND ATHEIGHT>=150 ORDER BY ATCODE DESC)A)
    WHERE RN BETWEEN 1 AND 2;
    -- 3. schitem이 'ZNAME'
SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME 
        FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME  AND Z.ZNAME = '익스트림존' ORDER BY ATCODE DESC)A)
    WHERE RN BETWEEN 1 AND 2;
    -- 4. schitem이 'ATOLD'
SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME
        FROM ATTRACTION A, ZONE Z WHERE A.ZNAME = Z.ZNAME AND ATOLD >=10 ORDER BY ATCODE DESC)A)
    WHERE RN BETWEEN 1 AND 2;
    -- 5. schitem이 'ATHEIGHT'
SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME
        FROM ATTRACTION A, ZONE Z WHERE A.ZNAME = Z.ZNAME AND ATHEIGHT>=150 ORDER BY ATCODE DESC)A)
    WHERE RN BETWEEN 1 AND 2;
    -- 6. schitem 이 'ZNAME' 그리고 'ATOLD' 일 떄
SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME
        FROM ATTRACTION A, ZONE Z WHERE A.ZNAME = Z.ZNAME AND Z.ZNAME = '익스트림존' AND ATOLD >=10 ORDER BY ATCODE DESC)A)
    WHERE RN BETWEEN 1 AND 2;
    -- 7. schitem 이 'ZNAME' 그리고 'ATHEIGHT' 일 때
SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME
        FROM ATTRACTION A, ZONE Z WHERE A.ZNAME = Z.ZNAME AND Z.ZNAME = '익스트림존' AND ATHEIGHT>=150 ORDER BY ATCODE DESC)A)
    WHERE RN BETWEEN 1 AND 2;
    -- 8. schitem 'ATOLD' 그리고 'ATHEIGHT' 일 때
SELECT * FROM (SELECT ROWNUM RN, A.* 
    FROM (SELECT ATCODE, ATNAME, ATCONTENT, ATADDR, ATIMAGE, ATRDATE, ATOLD, ATHEIGHT, ATLAT, ATLNG, ADID, Z.ZNAME
        FROM ATTRACTION A, ZONE Z WHERE A.ZNAME = Z.ZNAME AND  ATOLD >=10 AND ATHEIGHT>=0 ORDER BY ATCODE DESC)A)
    WHERE RN BETWEEN 1 AND 2;
    
-- (2) id = totCntAttraction 등록된 기구 갯수
    -- 1. schitem이 'null' 이거나 '' 일 때
SELECT COUNT(*) FROM ATTRACTION;
    -- 2. schitem이 'all' 일 떄 
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND Z.ZNAME = '익스트림존' AND ATOLD >=10 AND ATHEIGHT>=150;
old height zname
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND ATOLD >=#{atold, jdbcType=VARCHAR} AND ATHEIGHT>=#{atheight, jdbcType=VARCHAR} AND Z.ZNAME = #{zname}
    -- 3. schitem이 'ZNAME'
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND Z.ZNAME = '익스트림존' ;
    -- 4. schitem이 'ATOLD'
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND ATOLD >=10;
    -- 5. schitem이 'ATHEIGHT'
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND ATHEIGHT>=150;
    -- 6. schitem 이 'ZNAME' 이거나 'ATOLD' 일 떄
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND Z.ZNAME = '익스트림존' AND ATOLD >=10;
    -- 7. schitem 이 'ZNAME' 이거나 'ATHEIGHT' 일 때
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND Z.ZNAME = '익스트림존' AND ATHEIGHT>=150;
    -- 8. schitem 'ATOLD' 이거나 'ATHEIGHT' 일 때
SELECT COUNT(*) FROM ATTRACTION A, ZONE Z WHERE  A.ZNAME = Z.ZNAME AND ATOLD >=10 AND ATHEIGHT>=150;
select * from attraction;
-- (3) id = getDetailAttraction (기구 번호로 dto 가져오기)
SELECT * FROM ATTRACTION WHERE ATCODE = 17;
-- (4) id = registerAttraction (기구 등록)
INSERT INTO ATTRACTION (atCODE, atNAME, atCONTENT, atADDR, atOLD, atHEIGHT, atLAT, atLNG, adID, zNAME )
    VALUES (ATTRACTION_SEQ.NEXTVAL, '아쿠아레일', '볼에서 즐겨요', '경기 용인시 처인구 포곡읍 에버랜드로 199', 10, 150,  37.293099327122114, 127.20219040246639, 'dbswls0209', '익스트림존');
INSERT INTO ATTRACTION (atCODE, atNAME, atCONTENT, atADDR, atIMAGE, atOLD, atHEIGHT, atWEIGHT, atLAT, atLNG, atYOUTUBE, atNOP, adID, zNAME )
    VALUES (ATTRACTION_SEQ.NEXTVAL, '워터레일', '시원한 여름 더위를 뚝 딱 날려주는 미끄럼틀!', '경기 용인시 처인구 포곡읍 에버랜드로 199', 'waterrail.jpg', 10, 150, 100, 37.293099327122114, 127.20219040246639, 'https://www.youtube.com/embed//l7jAhHjBT_k',4,'dbswls0209', '워터월드존');
INSERT INTO ATTRACTION (atCODE, atNAME, atCONTENT, atADDR, atPOST, atIMAGE, atOLD, atHEIGHT, atWEIGHT, atLAT, atLNG, atYOUTUBE, atNOP, adID, zNAME )
    VALUES (ATTRACTION_SEQ.NEXTVAL, '워터레일', '시원한 여름 더위를 뚝 딱 날려주는 미끄럼틀!', '경기 용인시 처인구 포곡읍 에버랜드로 199', 'waterrail.jpg', 10, 150, 100, 37.293099327122114, 127.20219040246639, 'https://www.youtube.com/embed//l7jAhHjBT_k',4,'dbswls0209', '워터월드존');

-- (5) id = modifyAttraction (기구 수정)
UPDATE ATTRACTION
    SET atNAME = '롤링 엑스트레인',
        atCONTENT = '꽈배기처럼 꼬인 스크류 회전과 360도의 찌릿찌릿 공중회전이 두 번씩!',
        atADDR = '경기 용인시 처인구 포곡읍 에버랜드로 199',
        atPOST = 17023,
        atIMAGE = 'lt.jpg',
        atOLD = 6,
        atHEIGHT = 200,
        atWEIGHT = 120,
        atLAT = 37.293099327122114 ,
        atLNG = 127.20219040246639 ,
        atYOUTUBE = 'https://www.youtube.com/embed//l7jAhHjBT_k',
        atNOP = 26,
        zname = '익스트림존'    
    WHERE atCODE = 7;


-- (6) id = deleteAttraction (기구 삭제)
DELETE FROM ATTRACTION WHERE ATCODE = 8;