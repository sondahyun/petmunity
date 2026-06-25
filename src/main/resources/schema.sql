-- ============================================================================
-- Petmunity 데이터베이스 스키마 (schema.sql)
-- ----------------------------------------------------------------------------
-- 본 스크립트는 Petmunity 프로젝트의 DAO 코드(INSERT/SELECT/UPDATE 문, VO 필드
-- 타입, ResultSet getter 등)로부터 역으로 복원한 "실제" 스키마입니다.
-- 코드 어디에도 CREATE TABLE DDL이 존재하지 않으므로, 컬럼 순서/타입/PK/시퀀스/
-- 외래키는 모두 DAO와 VO를 정밀 분석하여 도출하였습니다.
--
-- ★★★ 실행 전 반드시 읽으세요 ★★★
--   1) 아래 "1) DROP TABLES / 2) DROP SEQUENCES" 구문은 기존 테이블과 데이터를
--      전부 삭제합니다. 학교 DB에 이미 petmunity 데이터가 들어있고 그대로 쓰려면
--      DROP 구문은 절대 실행하지 마세요. (확인: SELECT table_name FROM user_tables;)
--   2) 테이블이 아예 없을 때만 전체를 한 번에 실행하면 됩니다.
--   3) "5) FOREIGN KEYS"는 선택 사항입니다. 원본 코드에는 DB 외래키 제약이 없으며,
--      앱이 글 삭제 시 댓글을 먼저 지우지 않으므로 FK를 걸면 삭제가 막힐 수 있습니다
--      (ORA-02292). 데이터 정합성이 필요할 때만 실행하고, 아니면 건너뛰어도 앱은
--      정상 동작합니다.
--
-- 기타:
--   * VARCHAR2 컬럼의 크기(50/100/200/4000)는 합리적인 추정치이며 조정 가능합니다.
--   * Oracle 은 FK 가 PK 또는 UNIQUE 컬럼만 참조할 수 있어, loginId 를 참조하는
--     FK 를 위해 UserInfo.LOGINID 에 UNIQUE 제약을 부여했습니다.
-- ============================================================================


-- ----------------------------------------------------------------------------
-- 1) DROP TABLES  (★ 기존 데이터 삭제됨 — 신규 생성 시에만 실행)
--    자식 테이블 먼저 삭제하여 FK 의존성 충돌 방지
-- ----------------------------------------------------------------------------
DROP TABLE CommentInformation CASCADE CONSTRAINTS;
DROP TABLE CommentGroup CASCADE CONSTRAINTS;
DROP TABLE CommentPetstargram CASCADE CONSTRAINTS;
DROP TABLE CommentAdoption CASCADE CONSTRAINTS;
DROP TABLE ApplyForAdoption CASCADE CONSTRAINTS;
DROP TABLE AdoptionAnimal CASCADE CONSTRAINTS;
DROP TABLE Message CASCADE CONSTRAINTS;
DROP TABLE Pet CASCADE CONSTRAINTS;
DROP TABLE PostInformation CASCADE CONSTRAINTS;
DROP TABLE PostGroup CASCADE CONSTRAINTS;
DROP TABLE PostPetstargram CASCADE CONSTRAINTS;
DROP TABLE PostAdoption CASCADE CONSTRAINTS;
DROP TABLE UploadedFile CASCADE CONSTRAINTS;
DROP TABLE UserInfo CASCADE CONSTRAINTS;

-- ----------------------------------------------------------------------------
-- 2) DROP SEQUENCES  (★ 신규 생성 시에만 실행)
-- ----------------------------------------------------------------------------
DROP SEQUENCE user_seq;
DROP SEQUENCE pet_seq;
DROP SEQUENCE p0_seq;
DROP SEQUENCE p1_seq;
DROP SEQUENCE p2_seq;
DROP SEQUENCE p3_seq;
DROP SEQUENCE animal_seq;
DROP SEQUENCE apply_seq;
DROP SEQUENCE message_seq;
DROP SEQUENCE c0_seq;
DROP SEQUENCE c1_seq;
DROP SEQUENCE c2_seq;
DROP SEQUENCE c3_seq;


-- ----------------------------------------------------------------------------
-- 3) CREATE TABLES
-- ----------------------------------------------------------------------------

-- 사용자 정보 (부모 테이블)
CREATE TABLE UserInfo (
    USERID        NUMBER         NOT NULL,
    LOGINID       VARCHAR2(50)   NOT NULL,
    LOGINPWD      VARCHAR2(100)  NOT NULL,   -- BCrypt 해시(60자) 저장
    USERNICKNAME  VARCHAR2(50),
    USERBIRTH     DATE,
    PHONENUMBER   VARCHAR2(50),
    GENDER        VARCHAR2(50),
    ADDRESS       VARCHAR2(50),
    EMAIL         VARCHAR2(100),
    JOINGROUP     VARCHAR2(50),
    STATUS        NUMBER(1)      DEFAULT 0,   -- 0=활성, 1=탈퇴(소프트 삭제)
    PRIMARY KEY (USERID),
    CONSTRAINT UQ_UserInfo_LOGINID UNIQUE (LOGINID)
);

-- 업로드 이미지 저장 (BLOB) - 게시글/펫의 fileName(=fileKey)으로 참조
CREATE TABLE UploadedFile (
    FILEKEY       VARCHAR2(255)  NOT NULL,
    CONTENTTYPE   VARCHAR2(100),
    FILEDATA      BLOB,
    PRIMARY KEY (FILEKEY)
);

-- 반려동물 정보
CREATE TABLE Pet (
    petId        NUMBER         NOT NULL,
    name         VARCHAR2(50)   NOT NULL,
    gender       VARCHAR2(50),
    age          NUMBER,
    health       VARCHAR2(50),
    vaccination  VARCHAR2(50),
    kind         VARCHAR2(50),
    fileName     VARCHAR2(200),
    loginId      VARCHAR2(50)   NOT NULL,
    PRIMARY KEY (petId)
);

-- 일반(정보) 게시판 글
CREATE TABLE PostInformation (
    postId       NUMBER          NOT NULL,
    postTitle    VARCHAR2(200)   NOT NULL,
    postDate     DATE,
    postContent  VARCHAR2(4000),
    fileName     VARCHAR2(200),
    kind         VARCHAR2(50),
    loginId      VARCHAR2(50)    NOT NULL,
    PRIMARY KEY (postId)
);

-- 그룹(모임) 게시판 글
CREATE TABLE PostGroup (
    postId        NUMBER          NOT NULL,
    postTitle     VARCHAR2(200)   NOT NULL,
    postDate      DATE,
    postContent   VARCHAR2(4000),
    groupPurpose  VARCHAR2(4000),
    region        VARCHAR2(50),
    headCount     NUMBER,
    fileName      VARCHAR2(200),
    loginId       VARCHAR2(50)    NOT NULL,
    PRIMARY KEY (postId)
);

-- 펫스타그램 게시판 글
CREATE TABLE PostPetstargram (
    postId       NUMBER          NOT NULL,
    postTitle    VARCHAR2(200)   NOT NULL,
    postDate     DATE,
    postContent  VARCHAR2(4000),
    fileName     VARCHAR2(200),
    kind         VARCHAR2(50),
    loginId      VARCHAR2(50),
    PRIMARY KEY (postId)
);

-- 입양 게시판 글
CREATE TABLE PostAdoption (
    postId        NUMBER          NOT NULL,
    postTitle     VARCHAR2(200)   NOT NULL,
    postDate      DATE,
    aType         NUMBER,
    approval      NUMBER,
    approvalDate  DATE,
    postContent   VARCHAR2(4000),
    loginId       VARCHAR2(50)    NOT NULL,
    PRIMARY KEY (postId)
);

-- 입양 게시판에 등록되는 동물 정보 (PostAdoption 자식)
CREATE TABLE AdoptionAnimal (
    petId        NUMBER         NOT NULL,
    gender       VARCHAR2(50),
    age          NUMBER,
    health       VARCHAR2(50),
    vaccination  VARCHAR2(50),
    kind         VARCHAR2(50),
    fileName     VARCHAR2(200),
    postId       NUMBER         NOT NULL,
    PRIMARY KEY (petId)
);

-- 입양 신청서
CREATE TABLE ApplyForAdoption (
    applyId        NUMBER         NOT NULL,
    name           VARCHAR2(50),
    aType          NUMBER,
    birth          DATE,
    phoneNumber    VARCHAR2(50),
    hopeConditions VARCHAR2(4000),
    allergy        VARCHAR2(4000),
    address        VARCHAR2(200),
    housingType    VARCHAR2(50),
    resolution     VARCHAR2(4000),
    etc            VARCHAR2(4000),
    petId          NUMBER,
    PRIMARY KEY (applyId)
);

-- 쪽지(메시지)
CREATE TABLE Message (
    messageId  NUMBER          NOT NULL,
    sender     NUMBER          NOT NULL,
    receiver   NUMBER          NOT NULL,
    content    VARCHAR2(4000),
    sendDate   DATE,
    mTitle     VARCHAR2(200),
    PRIMARY KEY (messageId)
);

-- 정보 게시판 댓글 (PostInformation 자식)
CREATE TABLE CommentInformation (
    commentId       NUMBER          NOT NULL,
    commentDate     DATE,
    commentContent  VARCHAR2(4000),
    postId          NUMBER,
    userId          NUMBER,
    PRIMARY KEY (commentId)
);

-- 그룹 게시판 댓글 (PostGroup 자식)
CREATE TABLE CommentGroup (
    commentId       NUMBER          NOT NULL,
    commentDate     DATE            NOT NULL,
    commentContent  VARCHAR2(4000)  NOT NULL,
    postId          NUMBER          NOT NULL,
    userId          NUMBER          NOT NULL,
    PRIMARY KEY (commentId)
);

-- 펫스타그램 게시판 댓글 (PostPetstargram 자식)
CREATE TABLE CommentPetstargram (
    commentId       NUMBER          NOT NULL,
    commentDate     DATE            NOT NULL,
    commentContent  VARCHAR2(4000)  NOT NULL,
    postId          NUMBER          NOT NULL,
    userId          NUMBER          NOT NULL,
    PRIMARY KEY (commentId)
);

-- 입양 게시판 댓글 (PostAdoption 자식)
CREATE TABLE CommentAdoption (
    commentId       NUMBER          NOT NULL,
    commentDate     DATE            NOT NULL,
    commentContent  VARCHAR2(4000),
    postId          NUMBER          NOT NULL,
    userId          NUMBER          NOT NULL,
    PRIMARY KEY (commentId)
);


-- ----------------------------------------------------------------------------
-- 4) CREATE SEQUENCES
-- ----------------------------------------------------------------------------
CREATE SEQUENCE user_seq    START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE pet_seq     START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE p0_seq      START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE p1_seq      START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE p2_seq      START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE p3_seq      START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE animal_seq  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE apply_seq   START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE message_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE c0_seq      START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE c1_seq      START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE c2_seq      START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE c3_seq      START WITH 1 INCREMENT BY 1;


-- ----------------------------------------------------------------------------
-- 5) FOREIGN KEYS  (★ 선택 사항 — 위 주의사항 참고. 건너뛰어도 앱은 동작함)
--    모든 테이블 생성 후 ALTER 로 추가하여 생성 순서 의존성 제거
-- ----------------------------------------------------------------------------
ALTER TABLE Pet                ADD FOREIGN KEY (loginId)  REFERENCES UserInfo (loginId);
ALTER TABLE PostInformation    ADD FOREIGN KEY (loginId)  REFERENCES UserInfo (loginId);
ALTER TABLE PostGroup          ADD FOREIGN KEY (loginId)  REFERENCES UserInfo (loginId);
ALTER TABLE PostPetstargram    ADD FOREIGN KEY (loginId)  REFERENCES UserInfo (loginId);
ALTER TABLE PostAdoption       ADD FOREIGN KEY (loginId)  REFERENCES UserInfo (loginId);
ALTER TABLE AdoptionAnimal     ADD FOREIGN KEY (postId)   REFERENCES PostAdoption (postId);
ALTER TABLE ApplyForAdoption   ADD FOREIGN KEY (petId)    REFERENCES AdoptionAnimal (petId);
ALTER TABLE Message            ADD FOREIGN KEY (sender)   REFERENCES UserInfo (userId);
ALTER TABLE Message            ADD FOREIGN KEY (receiver) REFERENCES UserInfo (userId);
ALTER TABLE CommentInformation ADD FOREIGN KEY (postId)   REFERENCES PostInformation (postId);
ALTER TABLE CommentInformation ADD FOREIGN KEY (userId)   REFERENCES UserInfo (userId);
ALTER TABLE CommentGroup       ADD FOREIGN KEY (postId)   REFERENCES PostGroup (postId);
ALTER TABLE CommentGroup       ADD FOREIGN KEY (userId)   REFERENCES UserInfo (userId);
ALTER TABLE CommentPetstargram ADD FOREIGN KEY (postId)   REFERENCES PostPetstargram (postId);
ALTER TABLE CommentPetstargram ADD FOREIGN KEY (userId)   REFERENCES UserInfo (userId);
ALTER TABLE CommentAdoption    ADD FOREIGN KEY (postId)   REFERENCES PostAdoption (postId);
ALTER TABLE CommentAdoption    ADD FOREIGN KEY (userId)   REFERENCES UserInfo (userId);


-- ----------------------------------------------------------------------------
-- 6) COMMIT
-- ----------------------------------------------------------------------------
COMMIT;
