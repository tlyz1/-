CREATE TABLE IF NOT EXISTS ods.ods_sale_store_sale_info_i(
    id                      BIGINT COMMENT '主键',
    order_no                STRING COMMENT '单据唯一编号',
    order_id                BIGINT COMMENT '单据唯一编号',
    sale_store_no           STRING COMMENT '销售门店编码',
    store_no                STRING COMMENT '门店编码',
    store_name              STRING COMMENT '门店名称',
    trade_date              TIMESTAMP COMMENT '交易日期',
    pay_date                TIMESTAMP COMMENT '支付日期',
    deal_date               TIMESTAMP COMMENT '库存处理时间',
    pos_no                  STRING COMMENT 'pos机编号',
    ser_id                  BIGINT COMMENT '交易序号',
    trade_id                BIGINT COMMENT '销售类型:1-销售，2-退货，3-拒收，4-取消',
    parent_order_sn         STRING COMMENT '母单号，如果单据是子单有值',
    source_order_sn         STRING COMMENT '原始单据，退款的单据，则代表是原始销售单据',

    source_type             BIGINT COMMENT '销售渠道：1-门店pos，2-商城小程序，3-团购销售',
    cashier_no              STRING COMMENT '收银员编号',
    cashier_name            STRING COMMENT '收银员名称',
    sale_amount             DECIMAL(27, 2) COMMENT '单据总金额(支付+折扣+舍分)//total_amount',
    total_pay_amount        DECIMAL(27, 2) COMMENT '单据总支付金额',
    total_dis_amount        DECIMAL(27, 2) COMMENT '单据总折扣金额',
    round_amount            DECIMAL(27, 2) COMMENT '单据舍分金额',
    member_type             BIGINT COMMENT '会员类型',
    member_name             STRING COMMENT '会员名',
    member_center_sn        STRING COMMENT '会员中台编码',
    member_id               BIGINT COMMENT '会员编号',
    member_channel          BIGINT COMMENT '会员渠道：1-传智鲜，2-黑马',
    card_no                 STRING COMMENT '实体卡号',
    business_code           STRING COMMENT '业务类型:预售、及时达、b2c',
    create_time             TIMESTAMP COMMENT '记录创建时间',
    last_update_time        TIMESTAMP COMMENT '最后更新时间'
)
COMMENT '门店销售信息表'
partitioned by (dt STRING COMMENT '销售日期')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_sale_store_sale_dtl_i(
    id                              BIGINT COMMENT '主键',
    order_no                        STRING COMMENT '订单编码',
    order_id                        BIGINT COMMENT '订单ID',
    sale_store_no                   STRING COMMENT '销售门店编码',
    store_no                        STRING COMMENT '门店编码',
    store_name                      STRING COMMENT '门店名称',
    trade_date                      TIMESTAMP COMMENT '交易日期',
    pay_date                        TIMESTAMP COMMENT '支付日期',
    deal_date                       TIMESTAMP COMMENT '库存处理时间',
    pos_no                          STRING COMMENT 'pos机编号',
    ser_id                          BIGINT COMMENT '交易序号',
    trade_id                        BIGINT COMMENT '销售类型:1-销售，2-退货，3-拒收，4-取消',
    parent_order_sn                 STRING COMMENT '母单号，如果单据是子单有值',
    source_order_sn                 STRING COMMENT '原始单据，退款的单据，则代表是原始销售单据',
    source_type                     BIGINT COMMENT '销售渠道：1-门店pos，2-商城小程序，3-团购销售',
    cashier_no                      STRING COMMENT '收银员编号',
    cashier_name                    STRING COMMENT '收银员名称',
    sales_clerk_no                  STRING COMMENT '售货员编号',
    member_type                     BIGINT COMMENT '会员类型',
    member_name                     STRING COMMENT '会员名',
    member_id                       STRING COMMENT '会员编号',
    member_channel                  BIGINT COMMENT '会员渠道：1-传智鲜，2-黑马',
    card_no                         STRING COMMENT '实体卡号',   
    business_code                   STRING COMMENT '业务类型',
    goods_no                        STRING COMMENT '商品编码',
    goods_name                      STRING COMMENT '商品名称',
    channel_goods_no                STRING COMMENT '渠道商品编码',
    unit                            STRING COMMENT '单位',
    spec                            STRING COMMENT '规格',
    init_price                      DECIMAL(27, 2) COMMENT '原始价格',
    sale_price                      DECIMAL(27, 2) COMMENT '售价',
    price                           DECIMAL(27, 2) COMMENT '实际成交价',
    cost_price                      DECIMAL(27, 2) COMMENT '商品成本价',
    item                            BIGINT COMMENT '商品序号', 
    trade_mode_id                   BIGINT COMMENT '结算方式',
    is_daily_clear                  BIGINT COMMENT '是否日清，1-日清，0-非日清',
    sale_cost                       DECIMAL(27, 2) COMMENT '商品成本',
    sale_qty                        DECIMAL(27, 3) COMMENT '商品数量',
    sale_amount                     DECIMAL(27, 2) COMMENT '商品销售金额',
    dis_amount                      DECIMAL(27, 2) COMMENT '商品折扣金额',
    vendor_id                       BIGINT COMMENT '供应商编码',
    vendor_name                     STRING COMMENT '供应商名称',
    contract_no                     STRING COMMENT '合同号',
    batch_no                        STRING COMMENT '库存批次号', 
    combination_flag                BIGINT COMMENT '1-组合商品，2-组合成分',
    `sort`                          BIGINT COMMENT '序号',
    offset_flag                     BIGINT COMMENT '是否为冲减单，1-是，0-否',
    commission_amount               DECIMAL(27, 2) COMMENT '分佣金额',
    share_user_id                   STRING COMMENT '分销者ID（分享者ID）',
    tag                             BIGINT COMMENT '标记 0.默认 1.子商品盈余批次 2.母商品亏损批次',
    first_share_id                  STRING COMMENT '一级分享人', 
    shipping_type                   BIGINT COMMENT '订单类别',   
    create_time                     TIMESTAMP COMMENT '记录创建时间'
)
COMMENT '门店销售明细表'
partitioned by (dt STRING COMMENT '销售日期')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_sale_shop_order_i(
id                      BIGINT COMMENT '编号',
parent_order_no         STRING COMMENT '父单订单号',
order_id                STRING COMMENT '订单编号',
is_split                BIGINT COMMENT '是否拆单：0-不需要拆单；1-待拆单；2-已拆单',
platform_id             BIGINT COMMENT '平台id：1-有赞，2-京东到家，3-美团外卖，4-饿了么',
tid                     STRING COMMENT '平台订单号',
source_type             BIGINT COMMENT '订单来源：10,20,30,40,41,50,60,70',
source_name             STRING COMMENT '订单来源名称：10-有赞，20-京东到家，30-美团外卖，40-饿了么，41-百度外卖，50-传智鲜精选，60-黑马优选，70-抖店',
store_no                STRING COMMENT '门店编码',
city_id                 BIGINT COMMENT '城市编号',
city_name               STRING COMMENT '城市名称',
region_code             STRING COMMENT '区域编码',
    
order_status            BIGINT,
order_status_desc       STRING COMMENT '主订单状态描述：0-新建; 1-待出票；2-待备货；3-待揽件；4-待自提; 5-配送中；6-已完成；7-已取消',
 pay_type                BIGINT COMMENT '支付类型：1-线下支付；2-线上支付',
trade_type              STRING COMMENT '交易类型。取值范围：fixed(一口价) gift(送礼）bulk_purchase（来自分销商的采购）present （赠品领取）group （拼团订单） pifa （批发订单） cod （货到付款） peer （代付） qrcode（扫码商家二维码直接支付的交易）qrcode_3rd（线下收银台二维码交易)',
is_deleted              BIGINT COMMENT '是否有效，1：已删除，0：正常',
order_create_time       TIMESTAMP COMMENT '平台订单创建时间',
order_pay_time          TIMESTAMP COMMENT '订单支付时间',
create_time             TIMESTAMP COMMENT '创建时间',
print_status            BIGINT COMMENT '打印状态：0-未打票;1-已打票',
print_time              TIMESTAMP COMMENT '出票时间',
stock_up_status         BIGINT COMMENT '门店处理状态：0-待备货/1-已备货',
stock_up_time           TIMESTAMP COMMENT '备货完成时间',
    
order_type              BIGINT COMMENT '配送类型（真正的订单类型由业务类型来决定）：1-及时送；2-隔日送；3-自提单',
express_type            BIGINT COMMENT '配送方式：0-三方平台配送；1-自配送；2-快递；3-自提',
receive_time            TIMESTAMP COMMENT '要求送达/自提时间',
express_code            STRING COMMENT '配送单号',
delivery_status         BIGINT COMMENT '配送状态：0-待配送；1-配送中；2-已送达',
delivery_time           TIMESTAMP COMMENT '配送时间',
pick_up_status          BIGINT COMMENT '自提状态：0-待自提；1-已自提',
qr_code                 STRING COMMENT 'qr提货码',
pick_up_time            TIMESTAMP COMMENT '自提时间',

complete_time           TIMESTAMP COMMENT '订单完结时间',
is_cancel               BIGINT COMMENT '是否取消',
cancel_time             TIMESTAMP COMMENT '取消时间',
cancel_reason           STRING COMMENT '取消原因',
refund_status           BIGINT COMMENT '退款状态：0未退款，1部分退款，2已全额退款',
refund_time             TIMESTAMP COMMENT '已退款时间',
last_update_time        TIMESTAMP COMMENT '最新更新时间',

order_total_amount      DECIMAL(27, 2) COMMENT '订单总金额',
product_total_amount    DECIMAL(27, 2) COMMENT '商品总金额（原价）',
pack_amount             DECIMAL(27, 2) COMMENT '餐盒费/打包费',
delivery_amount         DECIMAL(27, 2) COMMENT '配送费',
discount_amount         DECIMAL(27, 2) COMMENT '订单优惠金额=商家承担优惠金额+平台补贴金额',
seller_discount_amount  DECIMAL(27, 2) COMMENT '商家承担优惠金额',
platform_allowance_amount DECIMAL(27, 2) COMMENT '平台补贴金额',
real_paid_amount        DECIMAL(27, 2) COMMENT '实付金额',
product_discount        DECIMAL(27, 2) COMMENT '商品优惠金额',
real_product_amount     DECIMAL(27, 2) COMMENT '商品实际金额',
buyer_id                BIGINT COMMENT '买家id',
buyer_phone             STRING COMMENT '买家电话',
buyer_remark            STRING COMMENT '买家备注',
r_name                  STRING COMMENT '收货人姓名',
r_tel                   STRING COMMENT '收货人电话',
r_province              STRING COMMENT '收货人省份',
r_city                  STRING COMMENT '收货人城市',
r_district              STRING COMMENT '收货人区域',
r_address               STRING COMMENT '收货人地址',
r_zipcode               STRING COMMENT '收货人邮编',

is_tuan_head            BIGINT COMMENT '是否为团长订单',
store_leader_id         BIGINT COMMENT '团长id',
order_group_no          STRING COMMENT '团单号',
commision_amount        DECIMAL(27, 2) COMMENT '抽佣金额',
settle_amount           DECIMAL(27, 2) COMMENT '结算金额',

points_amount           DECIMAL(27, 2) COMMENT '积分抵扣金额',
pay_point               BIGINT COMMENT '消费积分数',
balance_amount          DECIMAL(27, 2) COMMENT '余额扣除金额',
pay_channel_amount      DECIMAL(27, 2) COMMENT '通过支付渠道支付的金额',
point_amount            DECIMAL(27, 2) COMMENT '消费赠送积分',

sync_erp_status         BIGINT COMMENT '同步erp状态',
sync_erp_msg            STRING COMMENT '同步erp失败消息'
)
comment '商城订单表(更新表)'
partitioned by (dt STRING COMMENT '更新日期')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_sale_shop_order_item_i(
    id                          BIGINT COMMENT '自增id',
    order_id                    STRING COMMENT '订单编号',
    goods_no                    STRING COMMENT '商品编码',
    goods_name                  STRING COMMENT '商品名称',
    weight                      DECIMAL(27, 3) COMMENT '重量，单位kg',
    quantity                    BIGINT COMMENT '数量',
    unit                        STRING COMMENT '单位',
    sale_qty                    DECIMAL(27, 3) COMMENT '销售数量',
    disp_price                  DECIMAL(27, 2) COMMENT 'sku展示价格',
    pay_price                   DECIMAL(27, 2) COMMENT '价格',
    sale_amount                 DECIMAL(27, 2) COMMENT '单品销售金额',
    dis_amount                  DECIMAL(27, 2) COMMENT '单品总折扣金额',
    sale_cost                   DECIMAL(27, 2) COMMENT '销售成本',
    sale_type                   BIGINT COMMENT '类型：1-常规；2-赠品',
    create_time                 TIMESTAMP COMMENT '创建时间',
    complete_time               TIMESTAMP COMMENT '完成时间',
    last_update_time            TIMESTAMP COMMENT '更新时间',
    activity_plat_city_goods_id BIGINT COMMENT '活动商品区域id',
    activity_type               BIGINT COMMENT '活动类型(11:拼团 21:秒杀)',
    item_goods_key              STRING COMMENT '虚拟字段，itemgoodskey',
    is_deleted                  BIGINT COMMENT '是否删除：0-否；1-删除',
    transfer_paper_no           STRING COMMENT '要货单号',
    serial_no                   BIGINT COMMENT '商品序号，每个订单下起始都为1',
    is_delivery                 BIGINT COMMENT '仓发是否配送；1:配送',
    goods_source_type           BIGINT COMMENT '商品来源类型：1-生鲜品；2-标品',
    trade_mode_id               BIGINT COMMENT '结算方式:1购销,2联营',
    vendor_id                   BIGINT COMMENT '供应商id',
    contract_no                 STRING COMMENT '合同编号'
    
) 
COMMENT '订单明细表'
partitioned by (dt STRING COMMENT '创建日期')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_sale_shop_refund_i(
    id                    BIGINT COMMENT '主键',
    refund_no             STRING COMMENT '退款单号',
    refund_status         BIGINT COMMENT '退款状态：1-退款中；2-退款成功；3-退款失败',
    refund_code           BIGINT COMMENT '退款原因code',
    refund_msg            STRING COMMENT '退款原因',
    refund_desc           STRING COMMENT '退款描述',
    create_time           TIMESTAMP COMMENT '创建时间/退款申请时间',
    update_time           TIMESTAMP COMMENT '更新时间',
    cancel_time           TIMESTAMP COMMENT '退款申请取消时间',
    refund_amount         DECIMAL(27, 2) COMMENT '退款金额',
    refund_point_amount   DECIMAL(27, 2) COMMENT '扣减已赠积分',
    return_pay_point      BIGINT COMMENT '退还支付积分',
    return_point_amount   DECIMAL(27, 2) COMMENT '退还积分抵扣金额',
    refund_time           TIMESTAMP COMMENT '退款成功时间',
    less_weight           DECIMAL(27, 3) COMMENT '差额重量,单位kg',
    pick_weight           DECIMAL(27, 3) COMMENT '拣货重量,单位kg',
    is_deleted            BIGINT COMMENT '失效标志：0-正常；1-失效',
    refund_type           BIGINT COMMENT '退款类型：1-部分退；2-全额退; 3-差额退',
    order_no              STRING COMMENT '订单号',
    refund_apply_type     BIGINT COMMENT '退款申请类型：1-仅退款；2-退货退款',
    refund_delivery       DECIMAL(27, 2) COMMENT '运费退款',
    sync_erp_status       BIGINT COMMENT '同步erp状态：-1-失败，0-未同步，1-成功',
    sync_erp_msg          STRING COMMENT '同步erp失败消息',
    create_sys_user_id    BIGINT COMMENT '操作人id',
    create_sys_user_name  STRING COMMENT '操作人名称',
    store_no              STRING COMMENT '门店编码',
    store_leader_id       BIGINT COMMENT '团长id'
) 
COMMENT '订单退款表'
partitioned by (dt STRING COMMENT '创建日期')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_sale_shop_refund_item_i(
    id                          BIGINT COMMENT '主键',
    refund_no                   STRING COMMENT '退款单号',
    goods_no                    STRING COMMENT '商品编码',
    less_weight                 DECIMAL(27, 3) COMMENT '差额重量，单位kg',
    pick_weight                 DECIMAL(27, 3) COMMENT '拣货重量，单位kg',
    goods_name                  STRING COMMENT '商品名称',
    quantity                    DECIMAL(27, 3) COMMENT '退款数量',
    qty                         DECIMAL(27, 3) COMMENT '退款数量',
    amount                      DECIMAL(27, 2) COMMENT '退款金额',
    cost                        DECIMAL(27, 2) COMMENT '退款金额',
    create_time                 TIMESTAMP COMMENT '创建时间',
    update_time                 TIMESTAMP COMMENT '更新时间',
    activity_plat_city_goods_id BIGINT COMMENT '活动商品区域id',
    activity_type               BIGINT COMMENT '活动类型(11:拼团 21:秒杀)',
    order_item_id               BIGINT COMMENT '订单详情id',
    trade_mode_id               BIGINT COMMENT '结算方式:1购销,2联营',
    vendor_id                   BIGINT COMMENT '供应商id',
    contract_no                 STRING COMMENT '合同编号'
)
COMMENT '退款明细表'
partitioned by (dt STRING COMMENT '创建日期')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_sale_store_sale_pay_i(
    id              BIGINT COMMENT '主键',
    order_no        STRING COMMENT '单据唯一编号',
    order_id        BIGINT COMMENT '单据唯一编号',
    store_no        STRING COMMENT '门店编码',
    store_name      STRING COMMENT '门店名称',
    trade_date      TIMESTAMP COMMENT '交易日期',
    pay_date        TIMESTAMP COMMENT '支付日期',
    deal_date       TIMESTAMP COMMENT '库存处理时间',
    pos_no          STRING COMMENT 'POS机编号',
    ser_id          BIGINT COMMENT '交易序号',
    trade_id        BIGINT COMMENT '销售类型:1-销售，2-退货，3-拒收，4-取消',
    parent_order_sn STRING COMMENT '母单号，如果单据是子单有值',
    source_order_sn STRING COMMENT '原始单据，退款的单据，则代表是原始销售单据',
    source_type     BIGINT COMMENT '销售渠道：1-门店POS，2-商城小程序，3-团购销售',
    create_time     STRING COMMENT '记录创建时间',
    business_code   STRING COMMENT '业务类型//预售、及时达、B2C',
    pay_type_id     STRING COMMENT '支付类别ID',
    third_party_id  STRING COMMENT '第三方支付类别ID',
    third_party_name STRING COMMENT '第三方类别',
    pay_amount      DECIMAL(27, 2) COMMENT '支付金额',
    third_trade_no  STRING COMMENT '三方交易单号',
    trade_no        STRING COMMENT '交易单号',
    source_trade_no STRING COMMENT '原始交易单号',
    item            BIGINT COMMENT '序号,同一种支付方式可能多个条记录',
    ratio           DECIMAL(27, 4) COMMENT '支付费率',
    memo            STRING COMMENT '备注'
) 
comment '门店销售支付表'
partitioned by (dt STRING COMMENT '销售日期')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_sale_shop_sale_pay_i(
    id                      BIGINT COMMENT '主键',
    store_no                STRING COMMENT '门店编码',
    store_name              STRING COMMENT '门店名称',
    trade_date              TIMESTAMP COMMENT '交易日期',
    member_id               BIGINT COMMENT '会员id',
    zt_id                   BIGINT COMMENT '中台会员id',
    trade_order_id          STRING COMMENT '关联的交易单id',
    pay_order_id            STRING COMMENT '支付单id',
    order_no                STRING COMMENT '订单号',
    pay_channel             STRING COMMENT '支付渠道',
    pay_channel_name        STRING COMMENT '支付渠道名称',
    trade_order_type        BIGINT COMMENT '交易单类型，1消费,2充值,3提现,4退货退款',
    trade_order_type_name   STRING COMMENT '交易单类型名称',
    pay_amount              DECIMAL(27, 2) COMMENT '支付对等rmb的金额，比如是积分支付，那这里就是积分所对应的rmb的金额',
    trade_merchant          STRING COMMENT '交易商家'
) 
COMMENT '线上支付明细'
partitioned by (dt STRING COMMENT '创建日期')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_mem_member_union_i(
    zt_id                    BIGINT COMMENT '中台会员ID',
    member_id                BIGINT COMMENT '会员ID',
    user_id                  BIGINT COMMENT '用户ID',
    card_no                  STRING COMMENT '卡号',
    member_name              STRING COMMENT '会员名称',
    mobile                   STRING COMMENT '手机号',
    user_email               STRING COMMENT '邮箱',
    sex                      BIGINT COMMENT '用户的性别，1男性，2女性，0未知',
    birthday_date            STRING COMMENT '生日',
    address                  STRING COMMENT '地址',
    reg_time                 TIMESTAMP COMMENT '注册时间',
    reg_md                   STRING COMMENT '注册门店',
    bind_md                  STRING COMMENT '绑定门店',
    flag                     BIGINT COMMENT '0正常,1删除',
    is_black                 BIGINT COMMENT '是否被拉黑 1被拉黑,0正常用户',
    user_state               BIGINT COMMENT '会员状态，0停用/注销,1正常,2冻结',
    user_type                STRING COMMENT '用户类型（-1:传智鲜用户;0:普通用户;1:企业用户 2:内部员工 3:黑马门店 4:商铺会员 5:大买家 6:中间商 7:军区员工）',
    member_type              BIGINT COMMENT '会员状态 10：未付费会员 20：付费会员',
    member_status            BIGINT COMMENT '付费会员状态 -1:未付费会员 1：正常 2：试用 3：过期 4:试用已过期',
    expired_time             TIMESTAMP COMMENT '过期时间',
    user_source              BIGINT COMMENT '用户来源',
    member_level             BIGINT COMMENT '会员等级',
    growth                   BIGINT COMMENT '成长值',
    invite_member_id         BIGINT COMMENT '邀请人标识',
    invite_type              BIGINT COMMENT '邀请类型，0为内部',
    register_store_leader_id BIGINT COMMENT '注册归属团长 ID',
    last_update_time         TIMESTAMP COMMENT '更新时间'
) 
COMMENT '会员基础信息表'
partitioned by (dt STRING COMMENT '创建日期')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_order_store_receive_i(
    id                  BIGINT COMMENT '主键',
    uid                 STRING COMMENT '唯一标识',
    order_id            STRING COMMENT '收货单号',
    order_source        BIGINT COMMENT '下单来源，小程序、pc等',
    store_no            STRING COMMENT '门店编码',
    store_name          STRING COMMENT '门店名称',
    goods_no            STRING COMMENT '商品编码',
    goods_name          STRING COMMENT '商品名称',
    dc_no               STRING COMMENT '配送中心编码',
    dc_name             STRING COMMENT '配送中心名称',
    vendor_no           STRING COMMENT '供应商编码',
    vendor_name         STRING COMMENT '供应商名称',
    order_type          BIGINT COMMENT '订单类型，1-直送，2-配送，3-代发',
    receive_price       DECIMAL(27, 2) COMMENT '收货价',
    receive_qty         DECIMAL(27, 3) COMMENT '收货数量',
    git_qty             DECIMAL(27, 3) COMMENT '赠品数量',
    create_time         TIMESTAMP COMMENT '创建时间',
    stock_deal_time     TIMESTAMP COMMENT '库存处理时间',
    dc_send_order_id    STRING COMMENT '仓库发货单号',
    red_order_id        STRING COMMENT '被红冲单号',
    contract_no         STRING COMMENT '合同编号',
    contract_name       STRING COMMENT '合同名称',
    trade_mode          BIGINT COMMENT '1-直营，2-联营',
    order_source_type   BIGINT COMMENT '订货标识，0-门店订货，1-采购配货',
    sync_time           TIMESTAMP COMMENT '数据同步时间'
)
COMMENT '门店收货单'
partitioned by (dt STRING COMMENT '库存处理时间')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_order_store_return_to_dc_i(
    id                  BIGINT COMMENT '主键',
    uid                 STRING COMMENT '唯一标识',
    order_id            STRING COMMENT '退配单号',
    order_source        BIGINT COMMENT '下单来源，小程序、pc、智能补货、系统等',
    store_no            STRING COMMENT '门店编码',
    store_name          STRING COMMENT '门店名称',
    goods_no            STRING COMMENT '商品编码',
    goods_name          STRING COMMENT '商品名称',
    dc_no               STRING COMMENT '配送中心编码',
    dc_name             STRING COMMENT '配送中心名称',
    vendor_no           STRING COMMENT '供应商编码',
    vendor_name         STRING COMMENT '供应商名称',
    return_price        DECIMAL(27, 2) COMMENT '退配价',
    return_qty          DECIMAL(27, 3) COMMENT '退配数量',
    create_time         TIMESTAMP COMMENT '创建时间',
    stock_deal_time     TIMESTAMP COMMENT '库存处理时间',
    original_order_id   STRING COMMENT '退配原单号',
    is_fresh            BIGINT COMMENT '是否为生鲜店，0-否，1-是',
    is_entity           BIGINT COMMENT '是否实物退回，0-否，1-是',
    responsible_person  STRING COMMENT '责任归属方',
    return_reason_big   STRING COMMENT '退配原因（大类）',
    return_desc_big     STRING COMMENT '退配说明（大类）',
    return_reason_small STRING COMMENT '退配原因（小类）',
    return_desc_small   STRING COMMENT '退配说明（小类）',
    sync_time           TIMESTAMP COMMENT '数据同步时间',
    batch_type_id       STRING COMMENT '批次类型id'
)
COMMENT '门店退配单'
partitioned by (dt STRING COMMENT '库存处理时间')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_order_store_return_to_vendor_i(
    id                  BIGINT COMMENT '主键',
    uid                 STRING COMMENT '唯一标识',
    order_id            STRING COMMENT '退配单号',
    order_source        BIGINT COMMENT '下单来源，小程序、pc、智能补货、系统等',
    goods_no            STRING COMMENT '商品编码',
    goods_name          STRING COMMENT '商品名称',
    store_no            STRING COMMENT '门店编码',
    store_name          STRING COMMENT '门店名称',
    dc_no               STRING COMMENT '配送中心编码',
    dc_name             STRING COMMENT '配送中心名称',
    vendor_no           STRING COMMENT '供应商编码',
    vendor_name         STRING COMMENT '供应商名称',
    return_price        DECIMAL(27, 2) COMMENT '退配价',
    return_qty          DECIMAL(27, 3) COMMENT '退配数量',
    create_time         TIMESTAMP COMMENT '创建时间',
    stock_deal_time     TIMESTAMP COMMENT '库存处理时间',
    original_order_id   STRING COMMENT '退配原单号',
    is_fresh            BIGINT COMMENT '是否为生鲜店，0-否，1-是',
    is_entity           BIGINT COMMENT '是否实物退回，0-否，1-是',
    responsible_person  STRING COMMENT '责任归属方',
    return_reason_big   STRING COMMENT '退配原因（大类）',
    return_desc_big     STRING COMMENT '退配说明（大类）',
    return_reason_small STRING COMMENT '退配原因（小类）',
    return_desc_small   STRING COMMENT '退配说明（小类）',
    sync_time           TIMESTAMP COMMENT '数据同步时间'
) 
COMMENT '门店退货单'
partitioned by (dt STRING COMMENT '库存处理时间')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_order_store_alloc_in_i(
    id                      BIGINT COMMENT '主键',
    uid                     STRING COMMENT '唯一标识',
    order_id                STRING COMMENT '调拨单号',
    order_source            BIGINT COMMENT '下单来源，小程序、PC等',
    goods_no                STRING COMMENT '商品编码',
    goods_name              STRING COMMENT '商品名称',
    alloc_in_store_no       STRING COMMENT '调入门店编码',
    alloc_in_store_name     STRING COMMENT '调入门店名称',
    alloc_out_store_no      STRING COMMENT '调出门店编码',
    alloc_out_store_name    STRING COMMENT '调出门店名称',
    alloc_price             DECIMAL(27, 4) COMMENT '调拨单价',
    alloc_qty               DECIMAL(27, 3) COMMENT '调拨数量',
    alloc_reason            STRING COMMENT '调拨原因',
    alloc_amount            DECIMAL(27, 2) COMMENT '调拨金额',
    create_time             TIMESTAMP COMMENT '创建时间',
    stock_deal_time         TIMESTAMP COMMENT '库存处理时间',
    sync_time               TIMESTAMP COMMENT '数据同步时间',
    vendor_no               STRING COMMENT '供应商编码',
    vendor_name             STRING COMMENT '供应商名称'
) 
COMMENT '门店调入单'
partitioned by (dt STRING COMMENT '库存处理时间')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_order_store_alloc_out_i(
    id                      BIGINT COMMENT '主键',
    uid                     STRING COMMENT '唯一标识',
    order_id                STRING COMMENT '调拨单号',
    order_source            BIGINT COMMENT '下单来源，小程序、PC等',
    goods_no                STRING COMMENT '商品编码',
    goods_name              STRING COMMENT '商品名称',
    alloc_in_store_no       STRING COMMENT '调入门店编码',
    alloc_in_store_name     STRING COMMENT '调入门店名称',
    alloc_out_store_no      STRING COMMENT '调出门店编码',
    alloc_out_store_name    STRING COMMENT '调出门店名称',
    alloc_price             DECIMAL(27, 2) COMMENT '调拨单价',
    alloc_qty               DECIMAL(27, 3) COMMENT '调拨数量',
    alloc_reason            STRING COMMENT '调拨原因',
    alloc_amount            DECIMAL(27, 2) COMMENT '调拨金额',
    create_time             TIMESTAMP COMMENT '创建时间',
    stock_deal_time         TIMESTAMP COMMENT '库存处理时间',
    sync_time               TIMESTAMP COMMENT '数据同步时间',
    vendor_no               STRING COMMENT '供应商编码',
    vendor_name             STRING COMMENT '供应商名称'
)
COMMENT '门店调出单'
partitioned by (dt STRING COMMENT '库存处理时间')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_order_store_require_i(
    id                      BIGINT COMMENT '主键',
    uid                     STRING COMMENT '唯一标识',
    order_id                STRING COMMENT '要货单号',
    order_source            BIGINT COMMENT '下单来源，小程序、pc、智能补货、系统等',
    store_no                STRING COMMENT '门店编码',
    store_name              STRING COMMENT '门店名称',
    goods_no                STRING COMMENT '商品编码',
    goods_name              STRING COMMENT '商品名称',
    dc_no                   STRING COMMENT '配送中心编码',
    dc_name                 STRING COMMENT '配送中心名称',
    vendor_no               STRING COMMENT '供应商编码',
    vendor_name             STRING COMMENT '供应商名称',
    group_no                STRING COMMENT '采购柜组编号',
    require_price           DECIMAL(27, 2) COMMENT '要货价格',
    require_qty             DECIMAL(27, 3) COMMENT '要货数量',
    create_time             TIMESTAMP COMMENT '创建时间',
    send_time               TIMESTAMP COMMENT '预计送货时间',
    collect_require_order_id STRING COMMENT '要货汇总单号',
    require_type_code       BIGINT COMMENT '要货类型：1-直送，2-配送，3-代发',
    is_online               BIGINT COMMENT '1-线上，0-线下',
    confirm_time            TIMESTAMP COMMENT '审核时间',
    is_canceled             BIGINT COMMENT '1-取消，0-正常',
    sync_time               TIMESTAMP COMMENT '数据同步时间',
    is_urgent               BIGINT COMMENT '是否加急 0,否 1，是',
    original_order_price    DECIMAL(27, 4) COMMENT '原单价'
)
COMMENT '门店要货单'
partitioned by (dt STRING COMMENT 'confirm_time时间')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_stock_store_stock_adj_i(
    id                  BIGINT COMMENT '主键',
    uid                 STRING COMMENT '唯一标识',
    order_id            STRING COMMENT '库调单号',
    order_source        BIGINT COMMENT '下单来源，小程序、pc等',
    store_no            STRING COMMENT '门店编码',
    store_name          STRING COMMENT '门店名称',
    goods_no            STRING COMMENT '商品编码',
    goods_name          STRING COMMENT '商品名称',
    adj_type_big        STRING COMMENT '库调类型（大类）',
    adj_type_small      STRING COMMENT '库调类型（小类）',
    adj_reason_big      STRING COMMENT '库调原因（大类）',
    adj_reason_small    STRING COMMENT '库调原因（小类）',
    adj_qty             DECIMAL(27, 3) COMMENT '库调数量',
    adj_price           DECIMAL(27, 2) COMMENT '库调单价',
    adj_amount          DECIMAL(27, 2) COMMENT '库调金额',
    create_time         TIMESTAMP COMMENT '创建时间',
    stock_deal_time     TIMESTAMP COMMENT '库存处理时间',
    sync_time           TIMESTAMP COMMENT '数据同步时间',
    vendor_no           STRING COMMENT '供应商编码',
    vendor_name         STRING COMMENT '供应商名称'
) 
COMMENT '门店库调单'
partitioned by(dt STRING COMMENT '库存处理时间')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_mem_user_point_log_detailed_i(
    id                  BIGINT,
    zt_id               BIGINT COMMENT '关联的用户id',
    business_id         BIGINT COMMENT '关联的业务id',
    business_params     STRING COMMENT '业务参数',
    subject_id          BIGINT COMMENT '关联的主体id',
    occupy_subject_id   BIGINT COMMENT '占用的是哪个主体的积分',
    point_a             BIGINT COMMENT '变化后的积分(after)',
    point_c             BIGINT COMMENT '变化的积分(change)',
    change_type         BIGINT COMMENT '变更类型，0扣减积分，1增加积分',
    created_time        TIMESTAMP COMMENT '创建时间',
    updated_time        TIMESTAMP COMMENT '修改时间',
    is_deleted          BIGINT COMMENT '是否删除0正常，1删除'
)
COMMENT '用户积分变动明细表'
partitioned by (dt STRING COMMENT '统计日期')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_mem_store_amount_record_i(
    id                      BIGINT COMMENT '主键',
    trade_order_id          STRING COMMENT '对应的交易单id',
    pay_order_id            STRING COMMENT '对应的支付单id',
    refund_order_id         STRING COMMENT '对应的退款单id',
    convert_id              BIGINT COMMENT '对应的转化单id',
    clear_store_amount_id   BIGINT COMMENT '对应的清除余额单id',
    member_id               BIGINT COMMENT '会员id',
    zt_id                   BIGINT COMMENT '中台id',
    amount                  DECIMAL(27, 2) COMMENT '变动金额',
    record_type             BIGINT COMMENT '记录类型，1消费类型，2充值类型，3退款类型，4.退还充值，5.新老会员转化',
    create_time             TIMESTAMP,
    update_time             TIMESTAMP,
    trade_date              TIMESTAMP COMMENT '交易时间',
    store_no                STRING COMMENT '门店编号，无法确定的按照归属门店来',
    pos_no                  STRING COMMENT 'pos机编号',
    left_store_amount       DECIMAL(27, 2) COMMENT '交易完剩余的余额',
    trade_source            BIGINT COMMENT '交易来源，1线下，2线上',
    city_id                 BIGINT COMMENT '归属城市id',
    pay_channel             STRING COMMENT '支付渠道'
)
COMMENT '会员余额明细表'
partitioned by (dt STRING COMMENT '统计日期')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');


CREATE TABLE IF NOT EXISTS ods.ods_order_dc_send_i(
    id                          BIGINT COMMENT '主键',
    order_source                BIGINT COMMENT '下单来源，小程序、pc等',
    order_id                    STRING COMMENT '配送单号',
    goods_no                    STRING COMMENT '商品编码',
    goods_name                  STRING COMMENT '商品名称',
    dc_no                       STRING COMMENT '配送中心编码',
    dc_name                     STRING COMMENT '配送中心名称',
    vendor_no                   STRING COMMENT '供应商编码',
    vendor_name                 STRING COMMENT '供应商名称',
    trade_mode_id               STRING COMMENT '结算方式，1-购销，2-代销，，，',
    send_price                  DECIMAL(27, 2) COMMENT '配送价',
    send_qty                    DECIMAL(27, 3) COMMENT '配送数量',
    gift_qty                    DECIMAL(27, 3) COMMENT '赠品数量',
    single_tare_weight          DECIMAL(27, 3) COMMENT '每件皮重',
    tare_weight                 DECIMAL(27, 3) COMMENT '总皮重',
    freight_amount              DECIMAL(27, 2) COMMENT '运费',
    tax_rate                    DECIMAL(27, 3) COMMENT '税率',
    create_time                 TIMESTAMP COMMENT '创建时间',
    stock_deal_time             TIMESTAMP COMMENT '库存处理时间',
    collect_require_order_id    STRING COMMENT '要货汇总单号',
    red_order_id                STRING COMMENT '发货被红冲单号',
    order_type                  BIGINT COMMENT '订单类型，1-发货单，2-红冲单 ',
    store_no                    STRING COMMENT '门店编码',
    store_name                  STRING COMMENT '门店名称',
    cost_price                  DECIMAL(27, 2) COMMENT '仓库成本价',
    delivery_type               BIGINT COMMENT '配送方式',
    order_source_type           BIGINT COMMENT '订货标识，0-门店订货，1-采购配货',
    sync_time                   TIMESTAMP COMMENT '数据同步时间'
)
COMMENT '仓库配送单'
partitioned by (dt STRING COMMENT '库存处理时间')
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');



CREATE TABLE IF NOT EXISTS ods.ods_sale_store_sale_info_i_temp(
    id                      BIGINT COMMENT '主键',
    order_no                STRING COMMENT '单据唯一编号',
    order_id                BIGINT COMMENT '单据唯一编号',
    sale_store_no           STRING COMMENT '销售门店编码',
    store_no                STRING COMMENT '门店编码',
    store_name              STRING COMMENT '门店名称',
    trade_date              TIMESTAMP COMMENT '交易日期',
    pay_date                TIMESTAMP COMMENT '支付日期',
    deal_date               TIMESTAMP COMMENT '库存处理时间',
    pos_no                  STRING COMMENT 'pos机编号',
    ser_id                  BIGINT COMMENT '交易序号',
    trade_id                BIGINT COMMENT '销售类型:1-销售，2-退货，3-拒收，4-取消',
    parent_order_sn         STRING COMMENT '母单号，如果单据是子单有值',
    source_order_sn         STRING COMMENT '原始单据，退款的单据，则代表是原始销售单据',

    source_type             BIGINT COMMENT '销售渠道：1-门店pos，2-商城小程序，3-团购销售',
    cashier_no              STRING COMMENT '收银员编号',
    cashier_name            STRING COMMENT '收银员名称',
    sale_amount             DECIMAL(27, 2) COMMENT '单据总金额(支付+折扣+舍分)//total_amount',
    total_pay_amount        DECIMAL(27, 2) COMMENT '单据总支付金额',
    total_dis_amount        DECIMAL(27, 2) COMMENT '单据总折扣金额',
    round_amount            DECIMAL(27, 2) COMMENT '单据舍分金额',
    member_type             BIGINT COMMENT '会员类型',
    member_name             STRING COMMENT '会员名',
    member_center_sn        STRING COMMENT '会员中台编码',
    member_id               BIGINT COMMENT '会员编号',
    member_channel          BIGINT COMMENT '会员渠道：1-传智鲜，2-黑马',
    card_no                 STRING COMMENT '实体卡号',
    business_code           STRING COMMENT '业务类型:预售、及时达、b2c',
    create_time             TIMESTAMP COMMENT '记录创建时间',
    last_update_time        TIMESTAMP COMMENT '最后更新时间'
)
COMMENT '门店销售信息临时表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_sale_store_sale_dtl_i_temp(
    id                              BIGINT COMMENT '主键',
    order_no                        STRING COMMENT '订单编码',
    order_id                        BIGINT COMMENT '订单ID',
    sale_store_no                   STRING COMMENT '销售门店编码',
    store_no                        STRING COMMENT '门店编码',
    store_name                      STRING COMMENT '门店名称',
    trade_date                      TIMESTAMP COMMENT '交易日期',
    pay_date                        TIMESTAMP COMMENT '支付日期',
    deal_date                       TIMESTAMP COMMENT '库存处理时间',
    pos_no                          STRING COMMENT 'pos机编号',
    ser_id                          BIGINT COMMENT '交易序号',
    trade_id                        BIGINT COMMENT '销售类型:1-销售，2-退货，3-拒收，4-取消',
    parent_order_sn                 STRING COMMENT '母单号，如果单据是子单有值',
    source_order_sn                 STRING COMMENT '原始单据，退款的单据，则代表是原始销售单据',
    source_type                     BIGINT COMMENT '销售渠道：1-门店pos，2-商城小程序，3-团购销售',
    cashier_no                      STRING COMMENT '收银员编号',
    cashier_name                    STRING COMMENT '收银员名称',
    sales_clerk_no                  STRING COMMENT '售货员编号',
    member_type                     BIGINT COMMENT '会员类型',
    member_name                     STRING COMMENT '会员名',
    member_id                       STRING COMMENT '会员编号',
    member_channel                  BIGINT COMMENT '会员渠道：1-传智鲜，2-黑马',
    card_no                         STRING COMMENT '实体卡号',   
    business_code                   STRING COMMENT '业务类型',
    goods_no                        STRING COMMENT '商品编码',
    goods_name                      STRING COMMENT '商品名称',
    channel_goods_no                STRING COMMENT '渠道商品编码',
    unit                            STRING COMMENT '单位',
    spec                            STRING COMMENT '规格',
    init_price                      DECIMAL(27, 2) COMMENT '原始价格',
    sale_price                      DECIMAL(27, 2) COMMENT '售价',
    price                           DECIMAL(27, 2) COMMENT '实际成交价',
    cost_price                      DECIMAL(27, 2) COMMENT '商品成本价',
    item                            BIGINT COMMENT '商品序号', 
    trade_mode_id                   BIGINT COMMENT '结算方式',
    is_daily_clear                  BIGINT COMMENT '是否日清，1-日清，0-非日清',
    sale_cost                       DECIMAL(27, 2) COMMENT '商品成本',
    sale_qty                        DECIMAL(27, 3) COMMENT '商品数量',
    sale_amount                     DECIMAL(27, 2) COMMENT '商品销售金额',
    dis_amount                      DECIMAL(27, 2) COMMENT '商品折扣金额',
    vendor_id                       BIGINT COMMENT '供应商编码',
    vendor_name                     STRING COMMENT '供应商名称',
    contract_no                     STRING COMMENT '合同号',
    batch_no                        STRING COMMENT '库存批次号', 
    combination_flag                BIGINT COMMENT '1-组合商品，2-组合成分',
    `sort`                          BIGINT COMMENT '序号',
    offset_flag                     BIGINT COMMENT '是否为冲减单，1-是，0-否',
    commission_amount               DECIMAL(27, 2) COMMENT '分佣金额',
    share_user_id                   STRING COMMENT '分销者ID（分享者ID）',
    tag                             BIGINT COMMENT '标记 0.默认 1.子商品盈余批次 2.母商品亏损批次',
    first_share_id                  STRING COMMENT '一级分享人', 
    shipping_type                   BIGINT COMMENT '订单类别',   
    create_time                     TIMESTAMP COMMENT '记录创建时间'
)
COMMENT '门店销售明细临时表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_sale_shop_order_i_temp(
    id                      BIGINT COMMENT '编号',
    parent_order_no         STRING COMMENT '父单订单号',
    order_id                STRING COMMENT '订单编号',
    is_split                BIGINT COMMENT '是否拆单：0-不需要拆单；1-待拆单；2-已拆单',
    platform_id             BIGINT COMMENT '平台id：1-有赞，2-京东到家，3-美团外卖，4-饿了么',
    tid                     STRING COMMENT '平台订单号',
    source_type             BIGINT COMMENT '订单来源：10,20,30,40,41,50,60,70',
    source_name             STRING COMMENT '订单来源名称：10-有赞，20-京东到家，30-美团外卖，40-饿了么，41-百度外卖，50-传智鲜精选，60-黑马优选，70-抖店',
    store_no                STRING COMMENT '门店编码',
    city_id                 BIGINT COMMENT '城市编号',
    city_name               STRING COMMENT '城市名称',
    region_code             STRING COMMENT '区域编码',
    
    order_status            BIGINT,
    order_status_desc       STRING COMMENT '主订单状态描述：0-新建; 1-待出票；2-待备货；3-待揽件；4-待自提; 5-配送中；6-已完成；7-已取消',
    pay_type                BIGINT COMMENT '支付类型：1-线下支付；2-线上支付',
    trade_type              STRING COMMENT '交易类型。取值范围：fixed(一口价) gift(送礼）bulk_purchase（来自分销商的采购）present （赠品领取）group （拼团订单） pifa （批发订单） cod （货到付款） peer （代付） qrcode（扫码商家二维码直接支付的交易）qrcode_3rd（线下收银台二维码交易)',
    is_deleted              BIGINT COMMENT '是否有效，1：已删除，0：正常',
    order_create_time       TIMESTAMP COMMENT '平台订单创建时间',
    order_pay_time          TIMESTAMP COMMENT '订单支付时间',
    create_time             TIMESTAMP COMMENT '创建时间',
    print_status            BIGINT COMMENT '打印状态：0-未打票;1-已打票',
    print_time              TIMESTAMP COMMENT '出票时间',
    stock_up_status         BIGINT COMMENT '门店处理状态：0-待备货/1-已备货',
    stock_up_time           TIMESTAMP COMMENT '备货完成时间',
    
    order_type              BIGINT COMMENT '配送类型（真正的订单类型由业务类型来决定）：1-及时送；2-隔日送；3-自提单',
    express_type            BIGINT COMMENT '配送方式：0-三方平台配送；1-自配送；2-快递；3-自提',
    receive_time            TIMESTAMP COMMENT '要求送达/自提时间',
    express_code            STRING COMMENT '配送单号',
    delivery_status         BIGINT COMMENT '配送状态：0-待配送；1-配送中；2-已送达',
    delivery_time           TIMESTAMP COMMENT '配送时间',
    pick_up_status          BIGINT COMMENT '自提状态：0-待自提；1-已自提',
    qr_code                 STRING COMMENT 'qr提货码',
    pick_up_time            TIMESTAMP COMMENT '自提时间',
    
    complete_time           TIMESTAMP COMMENT '订单完结时间',
    is_cancel               BIGINT COMMENT '是否取消',
    cancel_time             TIMESTAMP COMMENT '取消时间',
    cancel_reason           STRING COMMENT '取消原因',
    refund_status           BIGINT COMMENT '退款状态：0未退款，1部分退款，2已全额退款',
    refund_time             TIMESTAMP COMMENT '已退款时间',
    last_update_time        TIMESTAMP COMMENT '最新更新时间',
    
    order_total_amount      DECIMAL(27, 2) COMMENT '订单总金额',
    product_total_amount    DECIMAL(27, 2) COMMENT '商品总金额（原价）',
    pack_amount             DECIMAL(27, 2) COMMENT '餐盒费/打包费',
    delivery_amount         DECIMAL(27, 2) COMMENT '配送费',
    discount_amount         DECIMAL(27, 2) COMMENT '订单优惠金额=商家承担优惠金额+平台补贴金额',
    seller_discount_amount  DECIMAL(27, 2) COMMENT '商家承担优惠金额',
    platform_allowance_amount DECIMAL(27, 2) COMMENT '平台补贴金额',
    real_paid_amount        DECIMAL(27, 2) COMMENT '实付金额',
    product_discount        DECIMAL(27, 2) COMMENT '商品优惠金额',
    real_product_amount     DECIMAL(27, 2) COMMENT '商品实际金额',
    buyer_id                BIGINT COMMENT '买家id',
    buyer_phone             STRING COMMENT '买家电话',
    buyer_remark            STRING COMMENT '买家备注',
    r_name                  STRING COMMENT '收货人姓名',
    r_tel                   STRING COMMENT '收货人电话',
    r_province              STRING COMMENT '收货人省份',
    r_city                  STRING COMMENT '收货人城市',
    r_district              STRING COMMENT '收货人区域',
    r_address               STRING COMMENT '收货人地址',
    r_zipcode               STRING COMMENT '收货人邮编',
    
    is_tuan_head            BIGINT COMMENT '是否为团长订单',
    store_leader_id         BIGINT COMMENT '团长id',
    order_group_no          STRING COMMENT '团单号',
    commision_amount        DECIMAL(27, 2) COMMENT '抽佣金额',
    settle_amount           DECIMAL(27, 2) COMMENT '结算金额',
    
    points_amount           DECIMAL(27, 2) COMMENT '积分抵扣金额',
    pay_point               BIGINT COMMENT '消费积分数',
    balance_amount          DECIMAL(27, 2) COMMENT '余额扣除金额',
    pay_channel_amount      DECIMAL(27, 2) COMMENT '通过支付渠道支付的金额',
    point_amount            DECIMAL(27, 2) COMMENT '消费赠送积分',
    
    sync_erp_status         BIGINT COMMENT '同步erp状态',
    sync_erp_msg            STRING COMMENT '同步erp失败消息'
)
comment '商城订单临时表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');


CREATE TABLE IF NOT EXISTS ods.ods_sale_shop_order_item_i_temp(
    id                          BIGINT COMMENT '自增id',
    order_id                    STRING COMMENT '订单编号',
    goods_no                    STRING COMMENT '商品编码',
    goods_name                  STRING COMMENT '商品名称',
    weight                      DECIMAL(27, 3) COMMENT '重量，单位kg',
    quantity                    BIGINT COMMENT '数量',
    unit                        STRING COMMENT '单位',
    sale_qty                    DECIMAL(27, 3) COMMENT '销售数量',
    disp_price                  DECIMAL(27, 2) COMMENT 'sku展示价格',
    pay_price                   DECIMAL(27, 2) COMMENT '价格',
    sale_amount                 DECIMAL(27, 2) COMMENT '单品销售金额',
    dis_amount                  DECIMAL(27, 2) COMMENT '单品总折扣金额',
    sale_cost                   DECIMAL(27, 2) COMMENT '销售成本',
    sale_type                   BIGINT COMMENT '类型：1-常规；2-赠品',
    create_time                 TIMESTAMP COMMENT '创建时间',
    complete_time               TIMESTAMP COMMENT '完成时间',
    last_update_time            TIMESTAMP COMMENT '更新时间',
    activity_plat_city_goods_id BIGINT COMMENT '活动商品区域id',
    activity_type               BIGINT COMMENT '活动类型(11:拼团 21:秒杀)',
    item_goods_key              STRING COMMENT '虚拟字段，itemgoodskey',
    is_deleted                  BIGINT COMMENT '是否删除：0-否；1-删除',
    transfer_paper_no           STRING COMMENT '要货单号',
    serial_no                   BIGINT COMMENT '商品序号，每个订单下起始都为1',
    is_delivery                 BIGINT COMMENT '仓发是否配送；1:配送',
    goods_source_type           BIGINT COMMENT '商品来源类型：1-生鲜品；2-标品',
    trade_mode_id               BIGINT COMMENT '结算方式:1购销,2联营',
    vendor_id                   BIGINT COMMENT '供应商id',
    contract_no                 STRING COMMENT '合同编号'
    
) 
COMMENT '订单明细临时表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_sale_shop_refund_i_temp(
    id                    BIGINT COMMENT '主键',
    refund_no             STRING COMMENT '退款单号',
    refund_status         BIGINT COMMENT '退款状态：1-退款中；2-退款成功；3-退款失败',
    refund_code           BIGINT COMMENT '退款原因code',
    refund_msg            STRING COMMENT '退款原因',
    refund_desc           STRING COMMENT '退款描述',
    create_time           TIMESTAMP COMMENT '创建时间/退款申请时间',
    update_time           TIMESTAMP COMMENT '更新时间',
    cancel_time           TIMESTAMP COMMENT '退款申请取消时间',
    refund_amount         DECIMAL(27, 2) COMMENT '退款金额',
    refund_point_amount   DECIMAL(27, 2) COMMENT '扣减已赠积分',
    return_pay_point      BIGINT COMMENT '退还支付积分',
    return_point_amount   DECIMAL(27, 2) COMMENT '退还积分抵扣金额',
    refund_time           TIMESTAMP COMMENT '退款成功时间',
    less_weight           DECIMAL(27, 3) COMMENT '差额重量,单位kg',
    pick_weight           DECIMAL(27, 3) COMMENT '拣货重量,单位kg',
    is_deleted            BIGINT COMMENT '失效标志：0-正常；1-失效',
    refund_type           BIGINT COMMENT '退款类型：1-部分退；2-全额退; 3-差额退',
    order_no              STRING COMMENT '订单号',
    refund_apply_type     BIGINT COMMENT '退款申请类型：1-仅退款；2-退货退款',
    refund_delivery       DECIMAL(27, 2) COMMENT '运费退款',
    sync_erp_status       BIGINT COMMENT '同步erp状态：-1-失败，0-未同步，1-成功',
    sync_erp_msg          STRING COMMENT '同步erp失败消息',
    create_sys_user_id    BIGINT COMMENT '操作人id',
    create_sys_user_name  STRING COMMENT '操作人名称',
    store_no              STRING COMMENT '门店编码',
    store_leader_id       BIGINT COMMENT '团长id'
) 
COMMENT '订单退款临时表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_sale_shop_refund_item_i_temp(
    id                          BIGINT COMMENT '主键',
    refund_no                   STRING COMMENT '退款单号',
    goods_no                    STRING COMMENT '商品编码',
    less_weight                 DECIMAL(27, 3) COMMENT '差额重量，单位kg',
    pick_weight                 DECIMAL(27, 3) COMMENT '拣货重量，单位kg',
    goods_name                  STRING COMMENT '商品名称',
    quantity                    DECIMAL(27, 3) COMMENT '退款数量',
    qty                         DECIMAL(27, 3) COMMENT '退款数量',
    amount                      DECIMAL(27, 2) COMMENT '退款金额',
    cost                        DECIMAL(27, 2) COMMENT '退款金额',
    create_time                 TIMESTAMP COMMENT '创建时间',
    update_time                 TIMESTAMP COMMENT '更新时间',
    activity_plat_city_goods_id BIGINT COMMENT '活动商品区域id',
    activity_type               BIGINT COMMENT '活动类型(11:拼团 21:秒杀)',
    order_item_id               BIGINT COMMENT '订单详情id',
    trade_mode_id               BIGINT COMMENT '结算方式:1购销,2联营',
    vendor_id                   BIGINT COMMENT '供应商id',
    contract_no                 STRING COMMENT '合同编号'
)
COMMENT '退款明细临时表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_sale_store_sale_pay_i_temp(
    id              BIGINT COMMENT '主键',
    order_no        STRING COMMENT '单据唯一编号',
    order_id        BIGINT COMMENT '单据唯一编号',
    store_no        STRING COMMENT '门店编码',
    store_name      STRING COMMENT '门店名称',
    trade_date      TIMESTAMP COMMENT '交易日期',
    pay_date        TIMESTAMP COMMENT '支付日期',
    deal_date       TIMESTAMP COMMENT '库存处理时间',
    pos_no          STRING COMMENT 'POS机编号',
    ser_id          BIGINT COMMENT '交易序号',
    trade_id        BIGINT COMMENT '销售类型:1-销售，2-退货，3-拒收，4-取消',
    parent_order_sn STRING COMMENT '母单号，如果单据是子单有值',
    source_order_sn STRING COMMENT '原始单据，退款的单据，则代表是原始销售单据',
    source_type     BIGINT COMMENT '销售渠道：1-门店POS，2-商城小程序，3-团购销售',
    create_time     STRING COMMENT '记录创建时间',
    business_code   STRING COMMENT '业务类型//预售、及时达、B2C',
    pay_type_id     STRING COMMENT '支付类别ID',
    third_party_id  STRING COMMENT '第三方支付类别ID',
    third_party_name STRING COMMENT '第三方类别',
    pay_amount      DECIMAL(27, 2) COMMENT '支付金额',
    third_trade_no  STRING COMMENT '三方交易单号',
    trade_no        STRING COMMENT '交易单号',
    source_trade_no STRING COMMENT '原始交易单号',
    item            BIGINT COMMENT '序号,同一种支付方式可能多个条记录',
    ratio           DECIMAL(27, 4) COMMENT '支付费率',
    memo            STRING COMMENT '备注'
) 
comment '门店销售支付临时表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');


CREATE TABLE IF NOT EXISTS ods.ods_sale_shop_sale_pay_i_temp(
    id                      BIGINT COMMENT '主键',
    store_no                STRING COMMENT '门店编码',
    store_name              STRING COMMENT '门店名称',
    trade_date              TIMESTAMP COMMENT '交易日期',
    member_id               BIGINT COMMENT '会员id',
    zt_id                   BIGINT COMMENT '中台会员id',
    trade_order_id          STRING COMMENT '关联的交易单id',
    pay_order_id            STRING COMMENT '支付单id',
    order_no                STRING COMMENT '订单号',
    pay_channel             STRING COMMENT '支付渠道',
    pay_channel_name        STRING COMMENT '支付渠道名称',
    trade_order_type        BIGINT COMMENT '交易单类型，1消费,2充值,3提现,4退货退款',
    trade_order_type_name   STRING COMMENT '交易单类型名称',
    pay_amount              DECIMAL(27, 2) COMMENT '支付对等rmb的金额，比如是积分支付，那这里就是积分所对应的rmb的金额',
    trade_merchant          STRING COMMENT '交易商家'
) 
COMMENT '线上支付明细临时表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_mem_member_union_i_temp(
    zt_id                    BIGINT COMMENT '中台会员ID',
    member_id                BIGINT COMMENT '会员ID',
    user_id                  BIGINT COMMENT '用户ID',
    card_no                  STRING COMMENT '卡号',
    member_name              STRING COMMENT '会员名称',
    mobile                   STRING COMMENT '手机号',
    user_email               STRING COMMENT '邮箱',
    sex                      BIGINT COMMENT '用户的性别，1男性，2女性，0未知',
    birthday_date            STRING COMMENT '生日',
    address                  STRING COMMENT '地址',
    reg_time                 TIMESTAMP COMMENT '注册时间',
    reg_md                   STRING COMMENT '注册门店',
    bind_md                  STRING COMMENT '绑定门店',
    flag                     BIGINT COMMENT '0正常,1删除',
    is_black                 BIGINT COMMENT '是否被拉黑 1被拉黑,0正常用户',
    user_state               BIGINT COMMENT '会员状态，0停用/注销,1正常,2冻结',
    user_type                STRING COMMENT '用户类型（-1:传智鲜用户;0:普通用户;1:企业用户 2:内部员工 3:黑马门店 4:商铺会员 5:大买家 6:中间商 7:军区员工）',
    member_type              BIGINT COMMENT '会员状态 10：未付费会员 20：付费会员',
    member_status            BIGINT COMMENT '付费会员状态 -1:未付费会员 1：正常 2：试用 3：过期 4:试用已过期',
    expired_time             TIMESTAMP COMMENT '过期时间',
    user_source              BIGINT COMMENT '用户来源',
    member_level             BIGINT COMMENT '会员等级',
    growth                   BIGINT COMMENT '成长值',
    invite_member_id         BIGINT COMMENT '邀请人标识',
    invite_type              BIGINT COMMENT '邀请类型，0为内部',
    register_store_leader_id BIGINT COMMENT '注册归属团长 ID',
    last_update_time         TIMESTAMP COMMENT '更新时间'
) 
COMMENT '会员基础信息临时表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_order_store_receive_i_temp(
    id                  BIGINT COMMENT '主键',
    uid                 STRING COMMENT '唯一标识',
    order_id            STRING COMMENT '收货单号',
    order_source        BIGINT COMMENT '下单来源，小程序、pc等',
    store_no            STRING COMMENT '门店编码',
    store_name          STRING COMMENT '门店名称',
    goods_no            STRING COMMENT '商品编码',
    goods_name          STRING COMMENT '商品名称',
    dc_no               STRING COMMENT '配送中心编码',
    dc_name             STRING COMMENT '配送中心名称',
    vendor_no           STRING COMMENT '供应商编码',
    vendor_name         STRING COMMENT '供应商名称',
    order_type          BIGINT COMMENT '订单类型，1-直送，2-配送，3-代发',
    receive_price       DECIMAL(27, 2) COMMENT '收货价',
    receive_qty         DECIMAL(27, 3) COMMENT '收货数量',
    git_qty             DECIMAL(27, 3) COMMENT '赠品数量',
    create_time         TIMESTAMP COMMENT '创建时间',
    stock_deal_time     TIMESTAMP COMMENT '库存处理时间',
    dc_send_order_id    STRING COMMENT '仓库发货单号',
    red_order_id        STRING COMMENT '被红冲单号',
    contract_no         STRING COMMENT '合同编号',
    contract_name       STRING COMMENT '合同名称',
    trade_mode          BIGINT COMMENT '1-直营，2-联营',
    order_source_type   BIGINT COMMENT '订货标识，0-门店订货，1-采购配货',
    sync_time           TIMESTAMP COMMENT '数据同步时间'
)
COMMENT '门店收货单临时'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_order_store_return_to_dc_i_temp(
    id                  BIGINT COMMENT '主键',
    uid                 STRING COMMENT '唯一标识',
    order_id            STRING COMMENT '退配单号',
    order_source        BIGINT COMMENT '下单来源，小程序、pc、智能补货、系统等',
    store_no            STRING COMMENT '门店编码',
    store_name          STRING COMMENT '门店名称',
    goods_no            STRING COMMENT '商品编码',
    goods_name          STRING COMMENT '商品名称',
    dc_no               STRING COMMENT '配送中心编码',
    dc_name             STRING COMMENT '配送中心名称',
    vendor_no           STRING COMMENT '供应商编码',
    vendor_name         STRING COMMENT '供应商名称',
    return_price        DECIMAL(27, 2) COMMENT '退配价',
    return_qty          DECIMAL(27, 3) COMMENT '退配数量',
    create_time         TIMESTAMP COMMENT '创建时间',
    stock_deal_time     TIMESTAMP COMMENT '库存处理时间',
    original_order_id   STRING COMMENT '退配原单号',
    is_fresh            BIGINT COMMENT '是否为生鲜店，0-否，1-是',
    is_entity           BIGINT COMMENT '是否实物退回，0-否，1-是',
    responsible_person  STRING COMMENT '责任归属方',
    return_reason_big   STRING COMMENT '退配原因（大类）',
    return_desc_big     STRING COMMENT '退配说明（大类）',
    return_reason_small STRING COMMENT '退配原因（小类）',
    return_desc_small   STRING COMMENT '退配说明（小类）',
    sync_time           TIMESTAMP COMMENT '数据同步时间',
    batch_type_id       STRING COMMENT '批次类型id'
)
COMMENT '门店退配单临时'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_order_store_return_to_vendor_i_temp(
    id                  BIGINT COMMENT '主键',
    uid                 STRING COMMENT '唯一标识',
    order_id            STRING COMMENT '退配单号',
    order_source        BIGINT COMMENT '下单来源，小程序、pc、智能补货、系统等',
    goods_no            STRING COMMENT '商品编码',
    goods_name          STRING COMMENT '商品名称',
    store_no            STRING COMMENT '门店编码',
    store_name          STRING COMMENT '门店名称',
    dc_no               STRING COMMENT '配送中心编码',
    dc_name             STRING COMMENT '配送中心名称',
    vendor_no           STRING COMMENT '供应商编码',
    vendor_name         STRING COMMENT '供应商名称',
    return_price        DECIMAL(27, 2) COMMENT '退配价',
    return_qty          DECIMAL(27, 3) COMMENT '退配数量',
    create_time         TIMESTAMP COMMENT '创建时间',
    stock_deal_time     TIMESTAMP COMMENT '库存处理时间',
    original_order_id   STRING COMMENT '退配原单号',
    is_fresh            BIGINT COMMENT '是否为生鲜店，0-否，1-是',
    is_entity           BIGINT COMMENT '是否实物退回，0-否，1-是',
    responsible_person  STRING COMMENT '责任归属方',
    return_reason_big   STRING COMMENT '退配原因（大类）',
    return_desc_big     STRING COMMENT '退配说明（大类）',
    return_reason_small STRING COMMENT '退配原因（小类）',
    return_desc_small   STRING COMMENT '退配说明（小类）',
    sync_time           TIMESTAMP COMMENT '数据同步时间'
) 
COMMENT '门店退货单临时'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_order_store_alloc_in_i_temp(
    id                      BIGINT COMMENT '主键',
    uid                     STRING COMMENT '唯一标识',
    order_id                STRING COMMENT '调拨单号',
    order_source            BIGINT COMMENT '下单来源，小程序、PC等',
    goods_no                STRING COMMENT '商品编码',
    goods_name              STRING COMMENT '商品名称',
    alloc_in_store_no       STRING COMMENT '调入门店编码',
    alloc_in_store_name     STRING COMMENT '调入门店名称',
    alloc_out_store_no      STRING COMMENT '调出门店编码',
    alloc_out_store_name    STRING COMMENT '调出门店名称',
    alloc_price             DECIMAL(27, 4) COMMENT '调拨单价',
    alloc_qty               DECIMAL(27, 3) COMMENT '调拨数量',
    alloc_reason            STRING COMMENT '调拨原因',
    alloc_amount            DECIMAL(27, 2) COMMENT '调拨金额',
    create_time             TIMESTAMP COMMENT '创建时间',
    stock_deal_time         TIMESTAMP COMMENT '库存处理时间',
    sync_time               TIMESTAMP COMMENT '数据同步时间',
    vendor_no               STRING COMMENT '供应商编码',
    vendor_name             STRING COMMENT '供应商名称'
) 
COMMENT '门店调入单临时'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_order_store_alloc_out_i_temp(
    id                      BIGINT COMMENT '主键',
    uid                     STRING COMMENT '唯一标识',
    order_id                STRING COMMENT '调拨单号',
    order_source            BIGINT COMMENT '下单来源，小程序、PC等',
    goods_no                STRING COMMENT '商品编码',
    goods_name              STRING COMMENT '商品名称',
    alloc_in_store_no       STRING COMMENT '调入门店编码',
    alloc_in_store_name     STRING COMMENT '调入门店名称',
    alloc_out_store_no      STRING COMMENT '调出门店编码',
    alloc_out_store_name    STRING COMMENT '调出门店名称',
    alloc_price             DECIMAL(27, 2) COMMENT '调拨单价',
    alloc_qty               DECIMAL(27, 3) COMMENT '调拨数量',
    alloc_reason            STRING COMMENT '调拨原因',
    alloc_amount            DECIMAL(27, 2) COMMENT '调拨金额',
    create_time             TIMESTAMP COMMENT '创建时间',
    stock_deal_time         TIMESTAMP COMMENT '库存处理时间',
    sync_time               TIMESTAMP COMMENT '数据同步时间',
    vendor_no               STRING COMMENT '供应商编码',
    vendor_name             STRING COMMENT '供应商名称'
)
COMMENT '门店调出单临时'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_order_store_require_i_temp(
    id                      BIGINT COMMENT '主键',
    uid                     STRING COMMENT '唯一标识',
    order_id                STRING COMMENT '要货单号',
    order_source            BIGINT COMMENT '下单来源，小程序、pc、智能补货、系统等',
    store_no                STRING COMMENT '门店编码',
    store_name              STRING COMMENT '门店名称',
    goods_no                STRING COMMENT '商品编码',
    goods_name              STRING COMMENT '商品名称',
    dc_no                   STRING COMMENT '配送中心编码',
    dc_name                 STRING COMMENT '配送中心名称',
    vendor_no               STRING COMMENT '供应商编码',
    vendor_name             STRING COMMENT '供应商名称',
    group_no                STRING COMMENT '采购柜组编号',
    require_price           DECIMAL(27, 2) COMMENT '要货价格',
    require_qty             DECIMAL(27, 3) COMMENT '要货数量',
    create_time             TIMESTAMP COMMENT '创建时间',
    send_time               TIMESTAMP COMMENT '预计送货时间',
    collect_require_order_id STRING COMMENT '要货汇总单号',
    require_type_code       BIGINT COMMENT '要货类型：1-直送，2-配送，3-代发',
    is_online               BIGINT COMMENT '1-线上，0-线下',
    confirm_time            TIMESTAMP COMMENT '审核时间',
    is_canceled             BIGINT COMMENT '1-取消，0-正常',
    sync_time               TIMESTAMP COMMENT '数据同步时间',
    is_urgent               BIGINT COMMENT '是否加急 0,否 1，是',
    original_order_price    DECIMAL(27, 4) COMMENT '原单价'
)
COMMENT '门店要货单临时'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_stock_store_stock_adj_i_temp(
    id                  BIGINT COMMENT '主键',
    uid                 STRING COMMENT '唯一标识',
    order_id            STRING COMMENT '库调单号',
    order_source        BIGINT COMMENT '下单来源，小程序、pc等',
    store_no            STRING COMMENT '门店编码',
    store_name          STRING COMMENT '门店名称',
    goods_no            STRING COMMENT '商品编码',
    goods_name          STRING COMMENT '商品名称',
    adj_type_big        STRING COMMENT '库调类型（大类）',
    adj_type_small      STRING COMMENT '库调类型（小类）',
    adj_reason_big      STRING COMMENT '库调原因（大类）',
    adj_reason_small    STRING COMMENT '库调原因（小类）',
    adj_qty             DECIMAL(27, 3) COMMENT '库调数量',
    adj_price           DECIMAL(27, 2) COMMENT '库调单价',
    adj_amount          DECIMAL(27, 2) COMMENT '库调金额',
    create_time         TIMESTAMP COMMENT '创建时间',
    stock_deal_time     TIMESTAMP COMMENT '库存处理时间',
    sync_time           TIMESTAMP COMMENT '数据同步时间',
    vendor_no           STRING COMMENT '供应商编码',
    vendor_name         STRING COMMENT '供应商名称'
) 
COMMENT '门店库调单临时'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_mem_user_point_log_detailed_i_temp(
    id                  BIGINT,
    zt_id               BIGINT COMMENT '关联的用户id',
    business_id         BIGINT COMMENT '关联的业务id',
    business_params     STRING COMMENT '业务参数',
    subject_id          BIGINT COMMENT '关联的主体id',
    occupy_subject_id   BIGINT COMMENT '占用的是哪个主体的积分',
    point_a             BIGINT COMMENT '变化后的积分(after)',
    point_c             BIGINT COMMENT '变化的积分(change)',
    change_type         BIGINT COMMENT '变更类型，0扣减积分，1增加积分',
    created_time        TIMESTAMP COMMENT '创建时间',
    updated_time        TIMESTAMP COMMENT '修改时间',
    is_deleted          BIGINT COMMENT '是否删除0正常，1删除'
)
COMMENT '用户积分变动明细临时表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');

CREATE TABLE IF NOT EXISTS ods.ods_mem_store_amount_record_i_temp(
    id                      BIGINT COMMENT '主键',
    trade_order_id          STRING COMMENT '对应的交易单id',
    pay_order_id            STRING COMMENT '对应的支付单id',
    refund_order_id         STRING COMMENT '对应的退款单id',
    convert_id              BIGINT COMMENT '对应的转化单id',
    clear_store_amount_id   BIGINT COMMENT '对应的清除余额单id',
    member_id               BIGINT COMMENT '会员id',
    zt_id                   BIGINT COMMENT '中台id',
    amount                  DECIMAL(27, 2) COMMENT '变动金额',
    record_type             BIGINT COMMENT '记录类型，1消费类型，2充值类型，3退款类型，4.退还充值，5.新老会员转化',
    create_time             TIMESTAMP,
    update_time             TIMESTAMP,
    trade_date              TIMESTAMP COMMENT '交易时间',
    store_no                STRING COMMENT '门店编号，无法确定的按照归属门店来',
    pos_no                  STRING COMMENT 'pos机编号',
    left_store_amount       DECIMAL(27, 2) COMMENT '交易完剩余的余额',
    trade_source            BIGINT COMMENT '交易来源，1线下，2线上',
    city_id                 BIGINT COMMENT '归属城市id',
    pay_channel             STRING COMMENT '支付渠道'
)
COMMENT '会员余额明细临时表'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');


CREATE TABLE IF NOT EXISTS ods.ods_order_dc_send_i_temp(
    id                          BIGINT COMMENT '主键',
    order_source                BIGINT COMMENT '下单来源，小程序、pc等',
    order_id                    STRING COMMENT '配送单号',
    goods_no                    STRING COMMENT '商品编码',
    goods_name                  STRING COMMENT '商品名称',
    dc_no                       STRING COMMENT '配送中心编码',
    dc_name                     STRING COMMENT '配送中心名称',
    vendor_no                   STRING COMMENT '供应商编码',
    vendor_name                 STRING COMMENT '供应商名称',
    trade_mode_id               STRING COMMENT '结算方式，1-购销，2-代销，，，',
    send_price                  DECIMAL(27, 2) COMMENT '配送价',
    send_qty                    DECIMAL(27, 3) COMMENT '配送数量',
    gift_qty                    DECIMAL(27, 3) COMMENT '赠品数量',
    single_tare_weight          DECIMAL(27, 3) COMMENT '每件皮重',
    tare_weight                 DECIMAL(27, 3) COMMENT '总皮重',
    freight_amount              DECIMAL(27, 2) COMMENT '运费',
    tax_rate                    DECIMAL(27, 3) COMMENT '税率',
    create_time                 TIMESTAMP COMMENT '创建时间',
    stock_deal_time             TIMESTAMP COMMENT '库存处理时间',
    collect_require_order_id    STRING COMMENT '要货汇总单号',
    red_order_id                STRING COMMENT '发货被红冲单号',
    order_type                  BIGINT COMMENT '订单类型，1-发货单，2-红冲单 ',
    store_no                    STRING COMMENT '门店编码',
    store_name                  STRING COMMENT '门店名称',
    cost_price                  DECIMAL(27, 2) COMMENT '仓库成本价',
    delivery_type               BIGINT COMMENT '配送方式',
    order_source_type           BIGINT COMMENT '订货标识，0-门店订货，1-采购配货',
    sync_time                   TIMESTAMP COMMENT '数据同步时间'
)
COMMENT '仓库配送临时单'
row format delimited fields terminated by ','
stored as orc
tblproperties ('orc.compress'='ZLIB');