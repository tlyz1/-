-- 开启动态分区方案
-- 开启非严格模式
set hive.exec.dynamic.partition.mode=nonstrict;
-- 开启动态分区支持(默认true)
set hive.exec.dynamic.partition=true;
-- 设置各个节点生成动态分区的最大数量: 默认为100个  (一般在生产环境中, 都需要调整更大)
set hive.exec.max.dynamic.partitions.pernode=10000;
-- 设置最大生成动态分区的数量: 默认为1000 (一般在生产环境中, 都需要调整更大)
set hive.exec.max.dynamic.partitions=100000;
-- hive一次性最大能够创建多少个文件: 默认为10w
set hive.exec.max.created.files=150000;


--hive压缩
--开启中间结果压缩
set hive.exec.compress.intermediate=true;
--开启最终结果压缩
set hive.exec.compress.output=true;
--写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;


-- 时间维度表
insert overwrite table dim.dwd_dim_date_f
select
    trade_date,
    year_code,
    month_code,
    day_code,
    quanter_code,
    quanter_name,
    week_trade_date,
    month_trade_date,
    week_end_date,
    month_end_date,
    last_week_trade_date,
    last_month_trade_date,
    last_week_end_date,
    last_month_end_date,
    year_week_code,
    week_day_code,
    day_year_num,
    month_days,
    is_weekend,
    days_after1,
    days_after2,
    days_after3,
    days_after4,
    days_after5,
    days_after6,
    days_after7
from dim.ods_dim_date_f;



-- 分类表拉宽操作
insert overwrite table dim.dwd_dim_category_statistics_i partition (dt)
select
    t1.id as first_category_id,
    t1.category_no as first_category_no,
    t1.category_name as first_category_name,
    t2.id as second_category_id,
    t2.category_no as second_category_no,
    t2.category_name as second_category_name,
    t3.id as third_category_id,
    t3.category_no as third_category_no,
    t3.category_name as third_category_name,
    0 as status,
    date_sub(current_date(),1) as dt
from dim.ods_dim_category_f t1
    join dim.ods_dim_category_f t2 on t1.id = t2.parent_id
    join dim.ods_dim_category_f t3 on t2.id = t3.parent_id;




insert overwrite table dim.dwd_dim_goods_i partition (dt)
select
    t1.id as goods_id,
    t1.goods_no,
    t1.goods_name,
    t2.first_category_id,
    t2.first_category_no,
    t2.first_category_name,
    t2.second_category_id,
    t2.second_category_no,
    t2.second_category_name,
    t2.third_category_id,
    t2.third_category_no,
    t2.third_category_name,
    t1.brand_no,
    t1.spec,
    t1.sale_unit,
    t1.life_cycle_status,
    t1.tax_rate_status,
    t1.tax_rate,
    t1.tax_value,
    t1.order_multiple,
    t1.pack_qty,
    t1.split_type,
    t1.is_sell_by_piece,
    t1.is_self_support,
    t1.is_variable_price,
    t1.is_double_measurement,
    t1.is_must_sell,
    t1.is_seasonal,
    t1.seasonal_start_time,
    t1.seasonal_end_time,
    t1.is_deleted,
    t1.goods_type,
    t1.create_time,
    t1.update_time,
    date_sub(current_date(),1) as dt
from dim.ods_dim_goods_info_f t1
	left join (select * from dim.dwd_dim_category_statistics_i where dt = date_sub(current_date(),1)) t2
			on t1.category_no = t2.third_category_no;




insert overwrite table dim.dwd_dim_store_goods_i partition (dt)
select
    t1.uid,
    t1.store_no,
    t1.goods_no,
    t1.goods_name,
    t2.first_category_no,
    t2.first_category_name,
    t2.second_category_no,
    t2.second_category_name,
    t2.third_category_no,
    t2.third_category_name,
    t1.is_clear,
    t1.is_must_order,
    t1.is_orderable,
    t1.order_multiple,
    t1.min_order_qty,
    t1.vendor_no,
    t1.vendor_name,
    t1.group_no,
    t1.group_name,
    t1.dc_no,
    t1.dc_name,
    t1.tag,
    t1.create_time,
    t1.update_time,
    t1.is_deleted,
    date_sub(current_date(),1) as dt
from dim.ods_dim_store_goods_f t1
	join (select * from dim.dwd_dim_category_statistics_i where dt = date_sub(current_date(),1)) t2
		on t1.category_no = t2.third_category_no;



insert overwrite table dim.dwd_dim_store_clear_goods_i partition (dt)
select
    uid,
    store_no,
    goods_no,
    goods_name,
    first_category_no,
    first_category_name,
    second_category_no,
    second_category_name,
    third_category_no,
    third_category_name,
    is_clear,
    is_must_order,
    is_orderable,
    order_multiple,
    min_order_qty,
    vendor_no,
    vendor_name,
    group_no,
    group_name,
    dc_no,
    dc_name,
    tag,
    create_time,
    update_time,
    is_deleted,
    dt
from dim.dwd_dim_store_goods_i where dt = date_sub(current_date(),1) and is_clear = 1;




insert overwrite table dim.dwd_dim_source_type_map_i partition (dt)
select
    company,
    original_source_type,
    original_source_type_name,
    source_type,
    source_type_name,
    is_online,
    date_sub(current_date(),1) as dt

from dim.ods_dim_source_type_map_f ;



-- 门店宽表实现
with
t1 as  (
        select
            store_no,
            area_type_no,
            area
        from dim.ods_dim_store_area_info_f t1 where area_type_no = '8'
         )  ,

t2 as   (
        select
            store_no,
            area_type_no,
            area
        from dim.ods_dim_store_area_info_f t1 where area_type_no = '7'
    ) ,

t3 as  (
        select
            store_no,
            area_type_no,
            area
        from dim.ods_dim_store_area_info_f t1 where area_type_no = '1'
    ) ,
t4 as (
        select
            store_no,
            area_type_no,
            area
        from dim.ods_dim_store_area_info_f t1 where area_type_no = '2'
    ) ,

t5 as (
     select
        coalesce(t1.store_no,t2.store_no,t3.store_no,t4.store_no) as store_no,
        coalesce(t1.area_type_no,t2.area_type_no,t3.area_type_no,t4.area_type_no) as area_type_no,
        coalesce(t1.area,t2.area,t3.area,t4.area) as area
    from
        t1 full join t2 on t1.store_no = t2.store_no
        full join t3 on t2.store_no = t3.store_no
        full join t4 on t3.store_no = t4.store_no
),
t6 as (
    select
        store_no,
        collect_list(area_type_no)[0] as area_type_no,
        collect_list(area)[0] as area
    from t5 group by store_no
)

insert overwrite table dim.dwd_dim_store_i partition (dt)
select
    t1.id,
    t1.store_no,
    t1.store_name,
    cast(t1.management_type_code as bigint) as store_sale_type,
    cast(t1.store_type_code as bigint) as store_type_code,
    t1.city_id,
    t1.city_name,
    t1.region_code,
    t2.store_group_name as region_name, -- 需要关联区域表
    t1.worker_num,
    t1.manager_name,
    t1.telephone,
    t1.opening_date,
    t1.open_time,
    t1.close_time,
    t1.status,
    t1.is_deleted,
    t1.create_time,
    t1.update_time,
    t6.area as store_area, -- 需要关联分店面积明细表
    t1.decoration_code,
    if(t1.flag = 16,1,0) as is_day_clear,
    date_sub(current_date(),1) as dt
from dim.ods_dim_store_f t1
    left join dim.ods_dim_store_group_f t2 on t1.region_code = t2.store_group_no and t2.store_group_type_no = '04'
    left join t6 on t1.store_no = t6.store_no;