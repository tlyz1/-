-- 插入
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table  ods.ods_sale_store_sale_info_i partition(dt)
select *,date_format(trade_date,'yyyy-MM-dd') as dt from ods.ods_sale_store_sale_info_i_temp t
;

insert overwrite table  ods.ods_sale_store_sale_dtl_i partition(dt)
select *,date_format(trade_date,'yyyy-MM-dd') as dt from ods.ods_sale_store_sale_dtl_i_temp t
;

insert overwrite table  ods.ods_sale_shop_order_i partition(dt)
select *,date_format(t.create_time,'yyyy-MM-dd') as dt from ods.ods_sale_shop_order_i_temp t
;

insert overwrite table  ods.ods_sale_shop_order_item_i partition(dt)
select *,date_format(create_time,'yyyy-MM-dd') as dt from ods.ods_sale_shop_order_item_i_temp t
;

insert overwrite table  ods.ods_sale_shop_refund_i partition(dt)
select *,date_format(create_time,'yyyy-MM-dd') as dt from ods.ods_sale_shop_refund_i_temp t
;

insert overwrite table  ods.ods_sale_shop_refund_item_i partition(dt)
select *,date_format(create_time,'yyyy-MM-dd') as dt from ods.ods_sale_shop_refund_item_i_temp t
;

insert overwrite table  ods.ods_sale_store_sale_pay_i partition(dt)
select *,date_format(pay_date,'yyyy-MM-dd') as dt from ods.ods_sale_store_sale_pay_i_temp t
;

insert overwrite table  ods.ods_sale_shop_sale_pay_i partition(dt)
select *,date_format(trade_date,'yyyy-MM-dd') as dt from ods.ods_sale_shop_sale_pay_i_temp t
;

set hive.exec.max.dynamic.partitions.pernode=10000;
set hive.exec.max.dynamic.partitions=100000;
set hive.exec.max.created.files=150000;

-- 2023年之前的,一个月一个分区
insert overwrite table  ods.ods_mem_member_union_i partition(dt)
select *,if(reg_time < '2023-01-01',trunc(date_format(reg_time,'yyyy-MM-dd'),'MM'),date_format(reg_time,'yyyy-MM-dd')) as dt from ods.ods_mem_member_union_i_temp t
;

insert overwrite table  ods.ods_order_store_receive_i partition(dt)
select *,date_format(stock_deal_time,'yyyy-MM-dd') as dt from ods.ods_order_store_receive_i_temp t
;

insert overwrite table  ods.ods_order_store_return_to_dc_i partition(dt)
select *,date_format(stock_deal_time,'yyyy-MM-dd') as dt from ods.ods_order_store_return_to_dc_i_temp t
;

insert overwrite table  ods.ods_order_store_return_to_vendor_i partition(dt)
select *,date_format(stock_deal_time,'yyyy-MM-dd') as dt from ods.ods_order_store_return_to_vendor_i_temp t
;

insert overwrite table  ods.ods_order_store_alloc_in_i partition(dt)
select *,date_format(stock_deal_time,'yyyy-MM-dd') as dt from ods.ods_order_store_alloc_in_i_temp t
;

insert overwrite table  ods.ods_order_store_alloc_out_i partition(dt)
select *,date_format(stock_deal_time,'yyyy-MM-dd') as dt from ods.ods_order_store_alloc_out_i_temp t
;

insert overwrite table  ods.ods_order_store_require_i partition(dt)
select *,date_format(confirm_time,'yyyy-MM-dd') as dt from ods.ods_order_store_require_i_temp t
;

insert overwrite table  ods.ods_stock_store_stock_adj_i partition(dt)
select *,date_format(stock_deal_time,'yyyy-MM-dd') as dt from ods.ods_stock_store_stock_adj_i_temp t
;

insert overwrite table  ods.ods_mem_user_point_log_detailed_i partition(dt)
select *,date_format(created_time,'yyyy-MM-dd') as dt from ods.ods_mem_user_point_log_detailed_i_temp t
;

insert overwrite table  ods.ods_mem_store_amount_record_i partition(dt)
select *,date_format(create_time,'yyyy-MM-dd') as dt from ods.ods_mem_store_amount_record_i_temp t
;

insert overwrite table  ods.ods_order_dc_send_i partition(dt)
select *,date_format(stock_deal_time,'yyyy-MM-dd') as dt from ods.ods_order_dc_send_i_temp t
;

-- 删除临时表

DROP TABLE IF EXISTS ods.ods_sale_store_sale_info_i_temp;
DROP TABLE IF EXISTS ods.ods_sale_store_sale_dtl_i_temp;
DROP TABLE IF EXISTS ods.ods_sale_shop_order_i_temp;
DROP TABLE IF EXISTS ods.ods_sale_shop_order_item_i_temp;
DROP TABLE IF EXISTS ods.ods_sale_shop_refund_i_temp;
DROP TABLE IF EXISTS ods.ods_sale_shop_refund_item_i_temp;
DROP TABLE IF EXISTS ods.ods_sale_store_sale_pay_i_temp;
DROP TABLE IF EXISTS ods.ods_sale_shop_sale_pay_i_temp;
DROP TABLE IF EXISTS ods.ods_mem_member_union_i_temp;
DROP TABLE IF EXISTS ods.ods_order_store_receive_i_temp;
DROP TABLE IF EXISTS ods.ods_order_store_return_to_dc_i_temp;
DROP TABLE IF EXISTS ods.ods_order_store_return_to_vendor_i_temp;
DROP TABLE IF EXISTS ods.ods_order_store_alloc_in_i_temp;
DROP TABLE IF EXISTS ods.ods_order_store_alloc_out_i_temp;
DROP TABLE IF EXISTS ods.ods_order_store_require_i_temp;
DROP TABLE IF EXISTS ods.ods_stock_store_stock_adj_i_temp;
DROP TABLE IF EXISTS ods.ods_mem_user_point_log_detailed_i_temp;
DROP TABLE IF EXISTS ods.ods_mem_store_amount_record_i_temp;
DROP TABLE IF EXISTS ods.ods_order_dc_send_i_temp;