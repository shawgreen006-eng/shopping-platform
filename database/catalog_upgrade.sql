-- 为现有商品增加展示信息。ALTER TABLE 只运行一次。
ALTER TABLE shop.products
  ADD COLUMN category VARCHAR(50) NOT NULL DEFAULT '其他',
  ADD COLUMN description VARCHAR(255) NOT NULL DEFAULT '',
  ADD COLUMN image_url VARCHAR(255) NOT NULL DEFAULT '';

UPDATE shop.products
SET category = CASE id
    WHEN 1 THEN '手机数码'
    WHEN 2 THEN '电脑外设'
    WHEN 3 THEN '电脑外设'
    WHEN 4 THEN '音频设备'
    WHEN 5 THEN '手机配件'
    WHEN 6 THEN '电脑配件'
    ELSE category END,
  description = CASE id
    WHEN 1 THEN '折叠设计与宽阔屏幕，兼顾便携和沉浸体验。'
    WHEN 2 THEN '轻巧便携，适合日常办公和学习。'
    WHEN 3 THEN '紧凑布局与清晰手感，适合长时间输入。'
    WHEN 4 THEN '无线聆听，收纳和充电都很方便。'
    WHEN 5 THEN '小巧便携的 USB-C 手机充电器。'
    WHEN 6 THEN '可调节高度，让桌面使用更舒适。'
    ELSE description END,
  image_url = CASE id
    WHEN 1 THEN '/products/foldable-phone.png'
    WHEN 2 THEN '/products/wireless-mouse.png'
    WHEN 3 THEN '/products/mechanical-keyboard.png'
    WHEN 4 THEN '/products/bluetooth-earbuds.png'
    WHEN 5 THEN '/products/phone-charger.png'
    WHEN 6 THEN '/products/laptop-stand.png'
    ELSE image_url END
WHERE id BETWEEN 1 AND 6;

SELECT id, name, category, description, image_url FROM shop.products ORDER BY id;
