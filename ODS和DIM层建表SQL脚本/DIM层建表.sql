drop database if exists dim cascade ;
CREATE DATABASE IF NOT EXISTS dim;

CREATE TABLE dim.ods_dim_date_f (
    trade_date              STRING COMMENT '日期编码',
    year_code               BIGINT COMMENT '年编码',
    month_code              BIGINT COMMENT '月份编码',
    day_code                BIGINT COMMENT '日编码',
    quanter_code            BIGINT COMMENT '季度编码',
    quanter_name            STRING COMMENT '季度名称',
    week_trade_date         STRING COMMENT '周一时间',
    month_trade_date        STRING COMMENT '月一时间',
    week_end_date           STRING COMMENT '周末时间',
    month_end_date          STRING COMMENT '月末时间',
    last_week_trade_date    STRING COMMENT '上周一时间',
    last_month_trade_date   STRING COMMENT '上月一时间',
    last_week_end_date      STRING COMMENT '上周末时间',
    last_month_end_date     STRING COMMENT '上月末时间',
    year_week_code          BIGINT COMMENT '一年中第几周',
    week_day_code           BIGINT COMMENT '周几code',
    day_year_num            BIGINT COMMENT '一年第几天',
    month_days              BIGINT comment '本月有多少天',
    is_weekend              BIGINT COMMENT '是否周末（周六和周日）',
    days_after1             STRING COMMENT '1天后的日期',
    days_after2             STRING COMMENT '2天后的日期',
    days_after3             STRING COMMENT '3天后的日期',
    days_after4             STRING COMMENT '4天后的日期',
    days_after5             STRING COMMENT '5天后的日期',
    days_after6             STRING COMMENT '6天后的日期',
    days_after7             STRING COMMENT '7天后的日期'
) 
comment '时间维度表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS dim.ods_dim_store_f(
    id                          BIGINT COMMENT '自增主键',
    store_no                    STRING COMMENT '分店编号',
    store_name                  STRING COMMENT '分店名称',
    store_short_name            STRING COMMENT '分店简称',
    region_code                 STRING COMMENT '区域编码',
    management_type_code        STRING COMMENT '经营类型1直营 2加盟',
    store_type_code             STRING COMMENT '分店类型',
    province_id                 BIGINT COMMENT '省份id',
    province_name               STRING COMMENT '省份名称',
    city_id                     BIGINT COMMENT '城市id',
    city_name                   STRING COMMENT '城市名称',
    address                     STRING COMMENT '地址(不详)',
    longitude                   DECIMAL(38,18) COMMENT '经度(116.40184)',
    latitude                    DECIMAL(38,18) COMMENT '纬度(40.00294)',
    worker_num                  BIGINT COMMENT '员工人数',
    manager_name                STRING COMMENT '经理姓名',
    telephone                   STRING COMMENT '分店电话(114)',
    opening_date                STRING COMMENT '开店日期',
    open_time                   STRING COMMENT '营业开始时间',
    close_time                  STRING COMMENT '营业结束时间',
    `status`                    BIGINT COMMENT '状态 1：开店  2：闭店',
    is_deleted                  BIGINT COMMENT '是否删除 0:否  1:是',
    flag                        BIGINT COMMENT '二进制标识，0初始值，16日清',
    store_version_code          BIGINT COMMENT '门店版本(1-1.0版本，16-2.0版本，32-3.0版本)',
    decoration_code             STRING COMMENT '装修标识',
    create_time                 TIMESTAMP COMMENT '创建时间',
    update_time                 TIMESTAMP COMMENT '更新时间'
) 
comment '分店信息表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS dim.ods_dim_store_group_f(
    id BIGINT           COMMENT '自增主键',
    store_group_no      STRING COMMENT '店组编号',
    store_group_name    STRING COMMENT '店组名称',
    store_group_type_no STRING COMMENT '店组类型编号',
    parent_id           BIGINT COMMENT '父级id',
    is_deleted          BIGINT COMMENT '是否删除 0:否  1:是',
    create_time         TIMESTAMP COMMENT '创建时间',
    update_time         TIMESTAMP COMMENT '修改时间') 
comment '店组信息表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS dim.ods_dim_store_area_info_f(
    id              BIGINT COMMENT '自增主键',
    store_no        STRING COMMENT '分店编号',
    area_type_no    STRING COMMENT '面积类型编号',
    area_type_name  STRING COMMENT '面积类型名称',
    area            DECIMAL(27, 2) COMMENT '面积',
    is_deleted      BIGINT COMMENT '是否删除 0:否  1:是',
    create_time     TIMESTAMP COMMENT '创建时间',
    update_time     TIMESTAMP COMMENT '修改时间') 
comment '分店面积明细表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS dim.ods_dim_goods_info_f(
    id                      BIGINT,
    goods_no                STRING COMMENT '系统维护商品唯一编号',
    short_name              STRING COMMENT '简称',
    goods_name              STRING COMMENT '名称',
    category_no             STRING COMMENT '商品类别编号',
    brand_no                STRING COMMENT '品牌编号',
    spec                    STRING COMMENT '商品规格',
    sale_unit               STRING COMMENT '销售单位',
    life_cycle_status       STRING COMMENT '生命周期状态',
    tax_rate_status         BIGINT COMMENT '税率审核状态 (0：未提交审核 1：待财务审核 2：税率已审核 3：未通过)',
    tax_rate                STRING COMMENT '税率code',
    tax_value               DECIMAL(27, 3) COMMENT '税率',
    order_multiple          DECIMAL(27, 2) COMMENT '订货倍数',
    pack_qty                DECIMAL(27, 3) COMMENT '箱装数量',
    split_type              STRING COMMENT '分割属性',
    is_sell_by_piece        BIGINT COMMENT '是否拆零，0:不拆；1:拆',
    is_self_support         BIGINT COMMENT '是否自营 0:非自营；1:自营',
    is_variable_price       BIGINT COMMENT '分店可变价 0:不可；1:可以',
    is_double_measurement   BIGINT COMMENT '是否双计量商品 0:否；1:是',
    is_must_sell            BIGINT COMMENT '必卖品  0:非；1:是',
    is_seasonal             BIGINT COMMENT '季节性商品  0:非；1:是',
    seasonal_start_time     STRING COMMENT '季节性开始时间',
    seasonal_end_time       STRING COMMENT '季节性结束时间',
    is_deleted              BIGINT COMMENT '是否删除0:正常；1:删除',
    goods_type              STRING COMMENT '商品类型 1-国产食品 2-进口食品 3-国产非食品 4-进口非食品',
    create_time             TIMESTAMP COMMENT '该记录创建时间',
    update_time             TIMESTAMP COMMENT '该记录最后更新时间') 
comment '商品表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS dim.ods_dim_category_f(
    id                  BIGINT COMMENT '自增主键',
    category_no         STRING COMMENT '分类编号',
    category_name       STRING COMMENT '分类名称',
    parent_id           BIGINT COMMENT '父级id',
    level               BIGINT COMMENT '等级',
    is_deleted          BIGINT COMMENT '否删除 0:否  1:是',
    create_time         TIMESTAMP COMMENT '创建时间',
    update_time         TIMESTAMP COMMENT '最后更新时间') 
comment '商品分类表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS dim.ods_dim_store_goods_f(
    uid             STRING COMMENT '唯一标识',
    store_no        STRING COMMENT '门店编码',
    goods_no        STRING COMMENT '商品编码',
    goods_name      STRING COMMENT '商品名称',
    category_no     STRING COMMENT '品类编码',
    is_clear        BIGINT COMMENT '商品是否日清，0-否，1-是',
    is_must_order   BIGINT COMMENT '是否必订品，0-否，1-是',
    is_orderable    BIGINT COMMENT '是否可订，0-否，1-是',
    order_multiple  DECIMAL(27,2) COMMENT '订货倍数',
    min_order_qty   DECIMAL(27,2) COMMENT '最小起订量',
    vendor_no       STRING COMMENT '主供应商编码',
    vendor_name     STRING COMMENT '主供应商名称',
    group_no        STRING COMMENT '采购柜组编码',
    group_name      STRING COMMENT '采购柜组名称',
    dc_no           STRING COMMENT '采购仓库编码',
    dc_name         STRING COMMENT '采购仓库名称',
    tag             BIGINT COMMENT '商品标识，1-传智鲜标品；2-黑马标品;3-生鲜品;4-其它',
    create_time     TIMESTAMP COMMENT '创建时间',
    update_time     TIMESTAMP COMMENT '最后修改时间',
    is_deleted      BIGINT COMMENT '是否删除0:正常；1:删除') 
comment '门店商品信息'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS dim.ods_dim_source_type_map_f(
    id                          BIGINT COMMENT 'id',
    company                     STRING COMMENT '公司:1.传智鲜 2.黑马优选',
    original_source_type        BIGINT COMMENT '原交易来源  传智鲜1:线下pos;2:线上订单;3:扫码购;4:美团;5:饿了么;6:百度外卖;7:京东到家;8:有赞;9:传智鲜精品;10:黑马;11:团购',
    original_source_type_name   STRING COMMENT '原交易来源名称',
    source_type                 BIGINT COMMENT '新交易来源：1',
    source_type_name            STRING COMMENT '新交易来源名称',
    is_online                   BIGINT COMMENT '是否线上交易 0否;1是')
comment '交易类型映射表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');