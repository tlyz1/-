-- -------------------------------------------------------------------------------------------------- order 订单主题数据库建表
IF (EXISTS(SELECT * FROM master.dbo.sysdatabases WHERE dbid=db_ID('order')))
BEGIN
    USE master
    ALTER DATABASE [order]
    SET single_user
    WITH ROLLBACK IMMEDIATE
    DROP DATABASE [order]
END
go

create database [order]
go

use [order]
go

create table store_receive(
    id                  int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    uid                 varchar(64) ,
    order_id            varchar(64) ,
    order_source        int ,
    store_no            varchar(64) ,
    store_name          varchar(64) ,
    goods_no            varchar(64) ,
    goods_name          varchar(200) ,
    dc_no               varchar(64) ,
    dc_name             varchar(64) ,
    vendor_no           varchar(64) ,
    vendor_name         varchar(64) ,
    order_type          int ,
    receive_price       decimal(27, 2) ,
    receive_qty         decimal(27, 3) ,
    git_qty             decimal(27, 3) ,
    create_time         datetime ,
    stock_deal_time     datetime ,
    dc_send_order_id    varchar(64) ,
    red_order_id        varchar(64) ,
    contract_no         varchar(64) ,
    contract_name       varchar(64) ,
    trade_mode          int ,
    order_source_type   int ,
    sync_time           datetime default current_timestamp
)
go


create table store_return_to_dc(
    id                  int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    uid                 varchar(64) ,
    order_id            varchar(64) ,
    order_source        int ,
    store_no            varchar(64) ,
    store_name          varchar(64) ,
    goods_no            varchar(64) ,
    goods_name          varchar(200) ,
    dc_no               varchar(64) ,
    dc_name             varchar(64) ,
    vendor_no           varchar(64) ,
    vendor_name         varchar(64) ,
    return_price        decimal(27, 2) ,
    return_qty          decimal(27, 3) ,
    create_time         datetime default current_timestamp ,
    stock_deal_time     datetime,
    original_order_id   varchar(64) ,
    is_fresh            int ,
    is_entity           int ,
    responsible_person  varchar(64) ,
    return_reason_big   varchar(64) ,
    return_desc_big     varchar(64) ,
    return_reason_small varchar(64) ,
    return_desc_small   varchar(64) ,
    sync_time           datetime default current_timestamp ,
    batch_type_id       varchar(64)
)
go



create table store_return_to_vendor(
    id                  int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    uid                 varchar(64) ,
    order_id            varchar(64) ,
    order_source        int ,
    goods_no            varchar(64)  ,
    goods_name          varchar(200)  ,
    store_no            varchar(64) ,
    store_name          varchar(64) ,
    dc_no               varchar(64) ,
    dc_name             varchar(64) ,
    vendor_no           varchar(64) ,
    vendor_name         varchar(64) ,
    return_price        decimal(27, 2) ,
    return_qty          decimal(27, 3) ,
    create_time         datetime default current_timestamp,
    stock_deal_time     datetime,
    original_order_id   varchar(64) ,
    is_fresh            int,
    is_entity           int,
    responsible_person  varchar(64) ,
    return_reason_big   varchar(64) ,
    return_desc_big     varchar(64) ,
    return_reason_small varchar(64) ,
    return_desc_small   varchar(64) ,
    sync_time           datetime default current_timestamp
)
go


create table store_alloc_in(
    id                      int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    uid                     varchar(64) ,
    order_id                varchar(64) ,
    order_source            int ,
    goods_no                varchar(64) ,
    goods_name              varchar(200) ,
    alloc_in_store_no       varchar(64) ,
    alloc_in_store_name     varchar(64) ,
    alloc_out_store_no      varchar(64) ,
    alloc_out_store_name    varchar(64) ,
    alloc_price             decimal(27, 4) ,
    alloc_qty               decimal(27, 3) ,
    alloc_reason            varchar(255) ,
    alloc_amount            decimal(27, 2) ,
    create_time             datetime default current_timestamp,
    stock_deal_time         datetime,
    sync_time               datetime default current_timestamp,
    vendor_no               varchar(64) ,
    vendor_name             varchar(64)
)
go


create table store_alloc_out(
    id                      int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    uid                     varchar(64) ,
    order_id                varchar(64) ,
    order_source            int ,
    goods_no                varchar(64) ,
    goods_name              varchar(200) ,
    alloc_in_store_no       varchar(64) ,
    alloc_in_store_name     varchar(64) ,
    alloc_out_store_no      varchar(64) ,
    alloc_out_store_name    varchar(64) ,
    alloc_price             decimal(27, 4) ,
    alloc_qty               decimal(27, 3) ,
    alloc_reason            varchar(255) ,
    alloc_amount            decimal(27, 2) ,
    create_time             datetime default current_timestamp,
    stock_deal_time         datetime,
    sync_time               datetime default current_timestamp,
    vendor_no               varchar(64) ,
    vendor_name             varchar(64)
)
go

create table store_require(
    id                       int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    uid                      varchar(64) ,
    order_id                 varchar(64) ,
    order_source             int ,
    store_no                 varchar(64)  ,
    store_name               varchar(64)  ,
    goods_no                 varchar(64)  ,
    goods_name               varchar(200) ,
    dc_no                    varchar(64)  ,
    dc_name                  varchar(64)  ,
    vendor_no                varchar(64)  ,
    vendor_name              varchar(64)  ,
    group_no                 varchar(64)  ,
    require_price            decimal(27, 2) ,
    require_qty              decimal(27, 3) ,
    create_time              datetime default current_timestamp,
    send_time                datetime,
    collect_require_order_id varchar(64),
    require_type_code        int ,
    is_online                int ,
    confirm_time             datetime,
    is_canceled              int,
    sync_time                datetime default current_timestamp,
    is_urgent                int ,
    original_order_price     decimal(38, 4) 
)
go

CREATE TABLE dc_send(
    id                          int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    order_source                int ,
    order_id                    varchar(64) ,
    goods_no                    varchar(64) ,
    goods_name                  varchar(64) ,
    dc_no                       varchar(64) ,
    dc_name                     varchar(64) ,
    vendor_no                   varchar(64) ,
    vendor_name             	varchar(64) ,
    trade_mode_id               varchar(64) ,
    send_price                  decimal(27, 2) ,
    send_qty                    decimal(27, 3) ,
    gift_qty                    decimal(27, 3) ,
    single_tare_weight          decimal(27, 3) ,
    tare_weight                 decimal(27, 3) ,
    freight_amount              decimal(27, 2) ,
    tax_rate                    decimal(27, 3) ,
    create_time                 datetime default current_timestamp ,
    stock_deal_time             datetime ,
    collect_require_order_id    varchar(64) ,
    red_order_id                varchar(64) ,
    order_type                  int ,
    store_no                    varchar(64) ,
    store_name                  varchar(64) ,
    cost_price                  decimal(27, 2) ,
    delivery_type               int ,
    order_source_type           int ,
    sync_time                   datetime 
)
go

-- --------------插入数据-------
DECLARE @diff int = (select DATEDIFF(day,  '2023-05-19', GETDATE()))
insert into store_receive
select
    uid                
    ,order_id           
    ,order_source       
    ,store_no           
    ,store_name         
    ,goods_no           
    ,goods_name         
    ,dc_no              
    ,dc_name            
    ,vendor_no          
    ,vendor_name        
    ,order_type         
    ,receive_price      
    ,receive_qty        
    ,git_qty            
    ,dateadd(dd, @diff, create_time) as create_time        
    ,dateadd(dd, @diff, stock_deal_time) as stock_deal_time    
    ,dc_send_order_id   
    ,red_order_id       
    ,contract_no        
    ,contract_name      
    ,trade_mode         
    ,order_source_type  
    ,dateadd(dd, @diff, sync_time) as sync_time               
from [temp].[dbo].store_receive
go

DECLARE @diff int = (select DATEDIFF(day,  '2023-05-19', GETDATE()))
insert into store_return_to_dc
select
    uid                 
    ,order_id            
    ,order_source        
    ,store_no            
    ,store_name          
    ,goods_no            
    ,goods_name          
    ,dc_no               
    ,dc_name             
    ,vendor_no           
    ,vendor_name         
    ,return_price        
    ,return_qty          
    ,dateadd(dd, @diff, create_time) as create_time        
    ,dateadd(dd, @diff, stock_deal_time) as stock_deal_time      
    ,original_order_id   
    ,is_fresh            
    ,is_entity           
    ,responsible_person  
    ,return_reason_big   
    ,return_desc_big     
    ,return_reason_small 
    ,return_desc_small   
    ,dateadd(dd, @diff, sync_time) as sync_time            
    ,batch_type_id       
from [temp].[dbo].store_return_to_dc
go

DECLARE @diff int = (select DATEDIFF(day,  '2023-05-19', GETDATE()))
insert into store_return_to_vendor
select
    uid                 
    ,order_id            
    ,order_source        
    ,goods_no            
    ,goods_name          
    ,store_no            
    ,store_name          
    ,dc_no               
    ,dc_name             
    ,vendor_no           
    ,vendor_name         
    ,return_price        
    ,return_qty          
    ,dateadd(dd, @diff, create_time) as create_time        
    ,dateadd(dd, @diff, stock_deal_time) as stock_deal_time   
    ,original_order_id   
    ,is_fresh            
    ,is_entity           
    ,responsible_person  
    ,return_reason_big   
    ,return_desc_big     
    ,return_reason_small 
    ,return_desc_small   
    ,dateadd(dd, @diff, sync_time) as sync_time               
from [temp].[dbo].store_return_to_vendor
go

DECLARE @diff int = (select DATEDIFF(day,  '2023-05-19', GETDATE()))
insert into store_alloc_in
select
    uid                    
    ,order_id               
    ,order_source           
    ,goods_no               
    ,goods_name             
    ,alloc_in_store_no      
    ,alloc_in_store_name    
    ,alloc_out_store_no     
    ,alloc_out_store_name   
    ,alloc_price            
    ,alloc_qty              
    ,alloc_reason           
    ,alloc_amount           
    ,dateadd(dd, @diff, create_time) as create_time        
    ,dateadd(dd, @diff, stock_deal_time) as stock_deal_time         
    ,dateadd(dd, @diff, sync_time) as sync_time            
    ,vendor_no              
    ,vendor_name            
from [temp].[dbo].store_alloc_in
go

DECLARE @diff int = (select DATEDIFF(day,  '2023-05-19', GETDATE()))
insert into store_alloc_out
select
    uid                   
    ,order_id              
    ,order_source          
    ,goods_no              
    ,goods_name            
    ,alloc_in_store_no     
    ,alloc_in_store_name   
    ,alloc_out_store_no    
    ,alloc_out_store_name  
    ,alloc_price           
    ,alloc_qty             
    ,alloc_reason          
    ,alloc_amount          
    ,dateadd(dd, @diff, create_time) as create_time       
    ,dateadd(dd, @diff, stock_deal_time) as stock_deal_time         
    ,dateadd(dd, @diff, sync_time) as sync_time            
    ,vendor_no             
    ,vendor_name           
from [temp].[dbo].store_alloc_out
go

DECLARE @diff int = (select DATEDIFF(day,  '2023-05-19', GETDATE()))
insert into store_require
select
    uid                      
    ,order_id                 
    ,order_source             
    ,store_no                 
    ,store_name               
    ,goods_no                 
    ,goods_name               
    ,dc_no                    
    ,dc_name                  
    ,vendor_no                
    ,vendor_name              
    ,group_no                 
    ,require_price            
    ,require_qty              
    ,dateadd(dd, @diff, create_time) as create_time
    ,dateadd(dd, @diff, send_time) as send_time    
    ,collect_require_order_id 
    ,require_type_code        
    ,is_online
    ,dateadd(dd, @diff, confirm_time) as confirm_time                 
    ,is_canceled              
    ,dateadd(dd, @diff, sync_time) as sync_time                
    ,is_urgent                
    ,original_order_price     
from [temp].[dbo].store_require
go

DECLARE @diff int = (select DATEDIFF(day,  '2023-05-19', GETDATE()))
insert into dc_send
select
    order_source              
    ,order_id                  
    ,goods_no                  
    ,goods_name                
    ,dc_no                     
    ,dc_name                   
    ,vendor_no                 
    ,vendor_name             
    ,trade_mode_id             
    ,send_price                
    ,send_qty                  
    ,gift_qty                  
    ,single_tare_weight        
    ,tare_weight               
    ,freight_amount            
    ,tax_rate                  
    ,dateadd(dd, @diff, create_time) as create_time               
    ,dateadd(dd, @diff, stock_deal_time) as stock_deal_time           
    ,collect_require_order_id  
    ,red_order_id              
    ,order_type                
    ,store_no                  
    ,store_name                
    ,cost_price                
    ,delivery_type             
    ,order_source_type         
    ,dateadd(dd, @diff, sync_time) as sync_time                    
from [temp].[dbo].dc_send
go


-- -------------------------------------------------------------------------------------------------- stock 库存主题数据库建表
IF (EXISTS(SELECT * FROM master.dbo.sysdatabases WHERE dbid=db_ID('stock')))
BEGIN
    USE master
    ALTER DATABASE [stock]
    SET single_user
    WITH ROLLBACK IMMEDIATE
    DROP DATABASE [stock]
END
go

create database [stock]
go

use [stock]
go

create table store_stock_adj(
    id                  int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    uid                 varchar(64) ,
    order_id            varchar(64) ,
    order_source        int ,
    store_no            varchar(64)  ,
    store_name          varchar(64)  ,
    goods_no            varchar(64)  ,
    goods_name          varchar(200) ,
    adj_type_big        varchar(64)  ,
    adj_type_small      varchar(64)  ,
    adj_reason_big      varchar(64)  ,
    adj_reason_small    varchar(64)  ,
    adj_qty             decimal(27, 3) ,
    adj_price           decimal(27, 2) ,
    adj_amount          decimal(27, 2) ,
    create_time         datetime default current_timestamp ,
    stock_deal_time     datetime ,
    sync_time           datetime default current_timestamp ,
    vendor_no           varchar(64) ,
    vendor_name         varchar(64) 
)
go


create table store_goods_stock_data_day(
    id                  int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    store_no            varchar(64) ,
    goods_no            varchar(64) ,
    is_saleable         int ,
    stock_qty           decimal(27, 3) ,
    stock_price         decimal(27, 4) ,
    stock_amount        decimal(27, 2) ,
    last_update_time    datetime default current_timestamp
)
go


DECLARE @diff int = (select DATEDIFF(day,  '2023-05-19', GETDATE()))
insert into store_stock_adj
select
    uid              
    ,order_id         
    ,order_source     
    ,store_no         
    ,store_name       
    ,goods_no         
    ,goods_name       
    ,adj_type_big     
    ,adj_type_small   
    ,adj_reason_big   
    ,adj_reason_small 
    ,adj_qty          
    ,adj_price        
    ,adj_amount       
    ,dateadd(dd, @diff, create_time) as create_time        
    ,dateadd(dd, @diff, stock_deal_time) as stock_deal_time         
    ,dateadd(dd, @diff, sync_time) as sync_time          
    ,vendor_no        
    ,vendor_name      
from [temp].[dbo].store_stock_adj
go

DECLARE @diff int = (select DATEDIFF(day,  '2023-05-19', GETDATE()))
insert into store_goods_stock_data_day
select
    store_no         
    ,goods_no         
    ,is_saleable      
    ,stock_qty        
    ,stock_price      
    ,stock_amount     
    ,dateadd(dd, @diff, last_update_time) as last_update_time     
from [temp].[dbo].store_goods_stock_data_day
go