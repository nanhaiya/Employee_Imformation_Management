/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2020/7/22 ������ 16:17:14                       */
/*==============================================================*/


drop table if exists admin;

drop table if exists employeeimfo;

drop table if exists internimfo;

drop table if exists internjobscript;

drop table if exists jobimfo;

drop table if exists salarypurchase;

/*==============================================================*/
/* Table: 管理员表                                                 */
/*==============================================================*/
create table admin
(
   admin                varchar(10) not null,
   password             char(10) not null,
   primary key (admin)
);

/*==============================================================*/
/* Table: 员工信息表                                          */
/*==============================================================*/
create table employeeimfo
(
   Id                   int not null,
   Name                 varchar(10) not null,
   jobId                int not null,
   SalaryId             int not null,
   WorkPlace            varchar(50) not null,
   Kind                 varchar(10) not null,
   TraineeId            int not null,
   primary key (Id)
);

/*==============================================================*/
/* Table: 实习生进度表                                            */
/*==============================================================*/
create table internimfo
(
   Id                   int not null,
   AdaptPeriod          int(3) not null,
   GraowPeriod          int(3) not null,
   AssiPeriod           int(3) not null,
   primary key (Id)
);

/*==============================================================*/
/* Table: 实习生进度描述                                       */
/*==============================================================*/
create table internjobscript
(
   internjobId          int not null,
   internjobscript      varchar(50) not null,
   primary key (internjobId)
);

/*==============================================================*/
/* Table: 工作信息表                                               */
/*==============================================================*/
create table jobimfo
(
   jobId                int not null,
   jobName              varchar(10) not null,
   jobScrite            varchar(50) not null,
   jobNeedP             int not null,
   imageName            varchar(20),
   primary key (jobId)
);

/*==============================================================*/
/* Table: 薪资管理表                                        */
/*==============================================================*/
create table salarypurchase
(
   Id                   int not null,
   BasicS               double,
   FullAS               double,
   WorkS                double,
   OvertimeS            double,
   Deduct               double,
   Tax                  double,
   primary key (Id)
);

/*==============================================================*/
/* 需要添加字段，管理员表、员工信息表添加至少一个员工                 */
/*==============================================================*/
